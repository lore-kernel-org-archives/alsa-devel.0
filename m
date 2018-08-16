From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: [PATCH] control_hw: Fix issue when applying
	seccomp policy
Date: Thu, 16 Aug 2018 17:06:33 +0800
Message-ID: <CANyK0SkHoKd1p6fg7mw3dZNic1BhDiQgJ0TOPtPj_4dVFPsKZw@mail.gmail.com>
References: <20180815081750.70746-1-hychao@chromium.org>
 <s5hzhxo6ke0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f196.google.com (mail-yb0-f196.google.com
 [209.85.213.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 239C62677E2
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2018 11:06:46 +0200 (CEST)
Received: by mail-yb0-f196.google.com with SMTP id d34-v6so261247yba.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2018 02:06:46 -0700 (PDT)
In-Reply-To: <s5hzhxo6ke0.wl-tiwai@suse.de>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The problem happens when I add seccomp filter to whiltelist syscall
"ioctl" with arguments of type 'U', for SNDRV_CTL_IOCTL_TLV_READ,
SNDRV_CTL_IOCTL_TLV_WRITE and SNDRV_CTL_IOCTL_TLV_COMMAND.
I was expecting snd_ctl_hw_elem_tlv() to run without problem, but
actually seeing it return error because of ioctl() call failure.

In control_hw.c, when the local int "inum" got passed to ioctl, it is
converted to "unsigned long".
Take SNDRV_CTL_IOCTL_TLV_WRITE as example, it will stretch to
0xffffffffc008551b.

This doesn't bring problem to snd function, I think it's because
snd_pcm_lib_ioctl takes "unsigned int cmd" as argument.
https://github.com/torvalds/linux/blob/master/sound/core/pcm_lib.c#L1769

However the seccomp_data struct takes 64 bits argument to check
against seccomp rules.
https://github.com/torvalds/linux/blob/master/arch/x86/entry/common.c#L104
and these unexpected 0xff bytes make the seccomp rule check fail.

Since ioctl takes "unsigned long" command, I think we should fix this
in alsa-lib as there is no intention to append the 0xff bytes to
kernel.

Thanks,
Hsin-yu

On Wed, Aug 15, 2018 at 5:37 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 15 Aug 2018 10:17:50 +0200,
> Hsin-Yu Chao wrote:
> >
> > When seccomp policy is applied to filter ioctl syscall with
> > SNDRV_CTL_IOCTL_TLV_COMMAND, SNDRV_CTL_IOCTL_TLV_READ and
> > SNDRV_CTL_IOCTL_TLV_WRITE in whiltelist, alsa-lib still breaks
> > in at snd_ctl_hw_elem_tlv().
> > Fix the problem by passing unsigned int to ioctl.
>
> Could you explain exactly what breaks and how?
>
>
> thanks,
>
> Takashi
>
> >
> > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > ---
> >  src/control/control_hw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/control/control_hw.c b/src/control/control_hw.c
> > index 68eca522..b54d65f2 100644
> > --- a/src/control/control_hw.c
> > +++ b/src/control/control_hw.c
> > @@ -215,7 +215,7 @@ static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
> >                              unsigned int numid,
> >                              unsigned int *tlv, unsigned int tlv_size)
> >  {
> > -     int inum;
> > +     unsigned int inum;
> >       snd_ctl_hw_t *hw = handle->private_data;
> >       struct snd_ctl_tlv *xtlv;
> >
> > --
> > 2.18.0.865.gffc8e1a3cd6-goog
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
