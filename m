From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Is add uevent of controlC still a reliable
	synchronization point?
Date: Wed, 16 May 2018 01:49:59 +0800
Message-ID: <CA+Px+wXj-Pyak6dfrBA3VbZE-L_X-B2+s+yajeZRHSJQ1cSYiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C8D5266F4E
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 19:50:12 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id n3-v6so1213261ota.5
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 10:50:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

We found an assumption in 78-sound-cards.rules and commit
289ca025ee1d78223e3368801fc2b984e5efbfc7 are conflict.  The control device
will not be the last one to register.

The assumption in 78-sound-card.rules:
> The control device node creation can be used as synchronization point.
All other devices that belong to a card are created in the kernel before it.

The commit:
> commit 289ca025ee1d78223e3368801fc2b984e5efbfc7
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed Jan 29 15:53:35 2014 +0100
>
>    ALSA: Use priority list for managing device list
>
>    Basically, the device type specifies the priority of the device to be
>    registered / freed, too.  However, the priority value isn't well
>    utilized but only it's checked as a group.  This results in
>    inconsistent register and free order (where each of them should be in
>    reversed direction).
>
>    This patch simplifies the device list management code by simply
>    inserting a list entry at creation time in an incremental order for
>    the priority value.  Since we can just follow the link for register,
>    disconnect and free calls, we don't have to specify the group; so the
>    whole enum definitions are also simplified as well.
>
>    The visible change to outside is that the priorities of some object
>    types are revisited.  For example, now the SNDRV_DEV_LOWLEVEL object
>    is registered before others (control, PCM, etc) and, in return,
>    released after others.  Similarly, SNDRV_DEV_CODEC is in a lower
>    priority than SNDRV_DEV_BUS for ensuring the dependency.
>
>    Also, the unused SNDRV_DEV_TOPLEVEL, SNDRV_DEV_LOWLEVEL_PRE and
>    SNDRV_DEV_LOWLEVEL_NORMAL are removed as a cleanup.
>
>    Signed-off-by: Takashi Iwai <tiwai@suse.de>

The device types:
> enum snd_device_type {
>        SNDRV_DEV_LOWLEVEL,
>        SNDRV_DEV_CONTROL,
>        SNDRV_DEV_INFO,
>        SNDRV_DEV_BUS,
>        SNDRV_DEV_CODEC,
>        SNDRV_DEV_SEQUENCER,
>        SNDRV_DEV_HWDEP,
>        SNDRV_DEV_JACK,
> };

The commit sorts device types ascendantly and registers them from the list
head.  As a result, SNDRV_DEV_CONTROL devices will be registered before
most other devices.

We are writing to ask: Is add uevent of controlC still a reliable signal
for indicating everything is ready for a sound card?  Or is there now a
better way to do so?
