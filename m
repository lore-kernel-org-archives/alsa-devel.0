From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Fri, 14 Sep 2012 10:10:25 +0800
Message-ID: <CAN8cciYZMWz=wz-NNA1Pyydd57y4Sfu7Tr+0KFT4cESJxkv_tw@mail.gmail.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciYZBU+LaaQFXrn9kPoFc=MdYahw0ucKNmAhrG=CT0+C5g@mail.gmail.com>
 <s5h392rhbyu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 7915D26537E
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 04:10:26 +0200 (CEST)
Received: by qcse14 with SMTP id e14so2424398qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 19:10:25 -0700 (PDT)
In-Reply-To: <s5h392rhbyu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 939161@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > the real cases are those desktop which does not use hda front audio
panel ,
> > they just loss the auto mute since there is no jack detect circuit but
they
> > can still hear sound from the headphone at anytime
> >
> > do pulseaudio need a phantom port for the front panel headphone and mic
> > without jack detection ?
>
> Actually this is one good point.
> The jack detection isn't always reliably on such old machines, and
> BIOS cannot know, too.  That is, it has to be adjusted by user
> manually, whether the jack detection is enabled or not.
>
> So far, we solved this by providing "Auto-Mute Mode" mixer switch.
> But the jack detection controls don't follow this yet.  Maybe we can
> set such a jack control as inactive state when the jack detection is
> disabled.
>
> (And this reminds me that we can cut off "Phantom" name hack by
>  following the same rule -- just set the control inactive when it has
>  no real detection.  But it still appears in control list.)
>
>

The other case is the bios of some computers with alc880 codec have pin
defaults 0x00000000
for some pin complexes

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1015232

hda jack detect need pin fixup

Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=67b6ec3196da235317ff1b9474f17379b78f3294
