From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: Is add uevent of controlC still a reliable
	synchronization point?
Date: Wed, 16 May 2018 06:22:40 +0800
Message-ID: <CA+Px+wXm57FaLj259NYZcKEmVJ5WoHtYrp7qa6-QfGci4C+c1w@mail.gmail.com>
References: <CA+Px+wXj-Pyak6dfrBA3VbZE-L_X-B2+s+yajeZRHSJQ1cSYiQ@mail.gmail.com>
 <s5htvr8bwbq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B10C266EDF
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 00:22:53 +0200 (CEST)
Received: by mail-ot0-f194.google.com with SMTP id t1-v6so2104748oth.8
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 15:22:53 -0700 (PDT)
In-Reply-To: <s5htvr8bwbq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

We noticed the issue because in some rarely case the code will be executed
by worker of workqueue (i.e. deferral probe since v3.4) instead of udevd.
As a result, applications rely on the change uevent of sound card (fired
from 78-sound-card.rules) will be signaled prematurely.  The applications
assume when they receive the signal, everything of the sound card should be
ready.  But in the case, they are still initializing.

We have tried to change the order of SNDRV_DEV_CONTROL to the last one to
fix the bug we met and it was doing great.  So if there will not bring any
side effect, it should be fine to apply the patch.

By the way, out of curiosity, prior to the commit 289ca025ee1d, it seems
the list is merely a FIFO.  How to ensure control device is the last one to
register at that time?

On Wed, May 16, 2018 at 2:36 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 15 May 2018 19:49:59 +0200,
> Tzung-Bi Shih wrote:
> >
> > Hi,
> >
> > We found an assumption in 78-sound-cards.rules and commit
> > 289ca025ee1d78223e3368801fc2b984e5efbfc7 are conflict.  The control
device
> > will not be the last one to register.
> >
> > The assumption in 78-sound-card.rules:
> > > The control device node creation can be used as synchronization point.
> > All other devices that belong to a card are created in the kernel
before it.
> >
> > The commit:
> > > commit 289ca025ee1d78223e3368801fc2b984e5efbfc7
> > > Author: Takashi Iwai <tiwai@suse.de>
> > > Date:   Wed Jan 29 15:53:35 2014 +0100
> > >
> > >    ALSA: Use priority list for managing device list
> > >
> > >    Basically, the device type specifies the priority of the device to
be
> > >    registered / freed, too.  However, the priority value isn't well
> > >    utilized but only it's checked as a group.  This results in
> > >    inconsistent register and free order (where each of them should be
in
> > >    reversed direction).
> > >
> > >    This patch simplifies the device list management code by simply
> > >    inserting a list entry at creation time in an incremental order for
> > >    the priority value.  Since we can just follow the link for
register,
> > >    disconnect and free calls, we don't have to specify the group; so
the
> > >    whole enum definitions are also simplified as well.
> > >
> > >    The visible change to outside is that the priorities of some object
> > >    types are revisited.  For example, now the SNDRV_DEV_LOWLEVEL
object
> > >    is registered before others (control, PCM, etc) and, in return,
> > >    released after others.  Similarly, SNDRV_DEV_CODEC is in a lower
> > >    priority than SNDRV_DEV_BUS for ensuring the dependency.
> > >
> > >    Also, the unused SNDRV_DEV_TOPLEVEL, SNDRV_DEV_LOWLEVEL_PRE and
> > >    SNDRV_DEV_LOWLEVEL_NORMAL are removed as a cleanup.
> > >
> > >    Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >
> > The device types:
> > > enum snd_device_type {
> > >        SNDRV_DEV_LOWLEVEL,
> > >        SNDRV_DEV_CONTROL,
> > >        SNDRV_DEV_INFO,
> > >        SNDRV_DEV_BUS,
> > >        SNDRV_DEV_CODEC,
> > >        SNDRV_DEV_SEQUENCER,
> > >        SNDRV_DEV_HWDEP,
> > >        SNDRV_DEV_JACK,
> > > };
> >
> > The commit sorts device types ascendantly and registers them from the
list
> > head.  As a result, SNDRV_DEV_CONTROL devices will be registered before
> > most other devices.
> >
> > We are writing to ask: Is add uevent of controlC still a reliable signal
> > for indicating everything is ready for a sound card?  Or is there now a
> > better way to do so?

> It's a good point, and I think it's rather a bug that was overlooked
> by the commit.

> A simple fix would be to adjust the priority order to move
> SNDRV_DEV_CONTROL at the end.  This would work for register and
> disconnect, but for free, we need to tweak it manually so that the
> control is freed at last.  It's because some components do create /
> free ctl elements, hence otherwise it may lead to double-free (if not
> written correctly).

> So it'd be a patch like below.  (WARNING: totally untested!!)


> thanks,

> Takashi

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: Register/disconnect control device always at last

> The commit 289ca025ee1d ("ALSA: Use priority list for managing device
> list") changed the way to register/disconnect/free devices via a
> single priority list.  This helped to make behavior consistent, but it
> also changed a slight behavior change: namely, the control device is
> registered earlier than others, while it was supposed to be the very
> last one.

> I've put SNDRV_DEV_CONTROL in the current position as the release of
> ctl elements often conflict with the private ctl elements some PCM or
> other components may create, which often leads to a double-free.
> But, the order of register and disconnect should be indeed fixed as
> expected in the early days: the control device gets registered at
> last, and disconnected at first.

> This patch changes the priority list order to move SNDRV_DEV_CONTROL
> as the last guy to assure the register / disconnect order.  Meanwhile,
> for keeping the messy resource release order, manually treat the
> control device as last freed one.

> Fixes: 289ca025ee1d ("ALSA: Use priority list for managing device list")
> Reported-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>      include/sound/core.h | 2 +-
>      sound/core/device.c  | 8 ++++++++
>      2 files changed, 9 insertions(+), 1 deletion(-)

> diff --git a/include/sound/core.h b/include/sound/core.h
> index 5f181b875c2f..36a5934cf4b1 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -51,7 +51,6 @@ struct completion;
>       */
>      enum snd_device_type {
>             SNDRV_DEV_LOWLEVEL,
> -       SNDRV_DEV_CONTROL,
>             SNDRV_DEV_INFO,
>             SNDRV_DEV_BUS,
>             SNDRV_DEV_CODEC,
> @@ -62,6 +61,7 @@ enum snd_device_type {
>             SNDRV_DEV_SEQUENCER,
>             SNDRV_DEV_HWDEP,
>             SNDRV_DEV_JACK,
> +       SNDRV_DEV_CONTROL,      /* NOTE: this must be the last one */
>      };

>      enum snd_device_state {
> diff --git a/sound/core/device.c b/sound/core/device.c
> index cb0e46f66cc9..dae845fd5852 100644
> --- a/sound/core/device.c
> +++ b/sound/core/device.c
> @@ -240,6 +240,14 @@ void snd_device_free_all(struct snd_card *card)

>             if (snd_BUG_ON(!card))
>                     return;
> +       list_for_each_entry_safe_reverse(dev, next, &card->devices, list)
{
> +               /* exception: free the control device at last */
> +               if (dev->type == SNDRV_DEV_CONTROL)
> +                       continue;
> +               __snd_device_free(dev);
> +       }
> +
> +       /* free all */
>             list_for_each_entry_safe_reverse(dev, next, &card->devices,
list)
>                     __snd_device_free(dev);
>      }
> --
> 2.16.3
