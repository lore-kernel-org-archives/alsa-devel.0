From: Eric Laurent <elaurent@google.com>
Subject: Re: compress offload patch
Date: Fri, 4 Mar 2016 08:50:56 -0800
Message-ID: <CAL-7xP8Da5Wxusu1spE3uLQXsp9KcM7hBfRbYOssPvfQ=s05OA@mail.gmail.com>
References: <CAL-7xP8m+p2XZHwM1y+KrH+FZUiux33dy6Y6LVEuAEiW6g5mDQ@mail.gmail.com>
 <s5hh9gma7yp.wl-tiwai@suse.de> <20160304135200.GY11154@localhost>
 <s5hpovacpwb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 61456266971
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 17:50:56 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id l68so28142193wml.0
 for <alsa-devel@alsa-project.org>; Fri, 04 Mar 2016 08:50:56 -0800 (PST)
In-Reply-To: <s5hpovacpwb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks

On Fri, Mar 4, 2016 at 5:51 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 04 Mar 2016 14:52:00 +0100,
> Vinod Koul wrote:
> >
> > On Fri, Mar 04, 2016 at 10:49:34AM +0100, Takashi Iwai wrote:
> > > On Thu, 03 Mar 2016 17:09:52 +0100,
> > > Eric Laurent wrote:
> > > >
> > > > Takashi, Vinod,
> > > >
> > > > Can you help with merging the attached patch for compress offload
> core
> > > > upstream?
> > >
> > > Looks good to me, but I'm waiting for ack from Vinod.
> >
> > Sounds good to me so:
> >
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
>
> OK, merged now to for-next branch.
>
> > > BTW, I noticed that SNDRV_PCM_STREAM_PREPARED is missing in the
> > > comment in snd_compr_open().  Should be fixed in another patch.
> >
> > Yes will send that and noticed a typo, will fix both
>
> Great, thanks.
>
>
> Takashi
>
