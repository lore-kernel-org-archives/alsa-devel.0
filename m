From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: Can not rmmod snd_hda_codec_hdmi
Date: Wed, 24 Dec 2014 19:54:33 +0800
Message-ID: <1419422073.1929.5.camel@gmail.com>
References: <1419332872.4067.10.camel@xbing-ubuntu>
 <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
 <1419414572.1861.3.camel@gmail.com> <549A8DF8.1010004@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F82A261490
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 12:54:41 +0100 (CET)
Received: by mail-pa0-f44.google.com with SMTP id et14so9947348pad.17
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 03:54:40 -0800 (PST)
In-Reply-To: <549A8DF8.1010004@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: "; Libin Yang" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Takashi Iwai" <tiwai@suse.de>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, Clemens Ladisch <clemens@ladisch.de>, "; Fengguang Wu" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-12-24 at 11:57 +0200, Anssi Hannula wrote:
> 24.12.2014, 11:49, Xuebing Wang kirjoitti:
> > On Tue, 2014-12-23 at 17:21 +0100, Clemens Ladisch wrote:
> >> Xuebing Wang wrote:
> >>> rmmod: ERROR: Module snd_hda_codec_hdmi is in use
> >>
> >> rmmod snd-hda-intel first.
> >>
> > Clemens, thanks for your help.
> > 
> > I am using Fedora 21 (Ubuntu 14.04.1 has the same problem).
> > 
> > 'rmmod snd-hda-intel' shows this module is in use too. 
> > 
> > 'modinfo snd-hda-intel', nor file /lib/modules/.../modules.dep shows that any kernel modules depends
> > on snd-hda-intel or snd_hda_codec_hdmi.
> > 
> > Is it possible that a kernel thread is using these 2 modules?
> > 
> > Any ideas? Thanks.
> 
> Run this to see if some userspace process is using the ALSA devices:
> fuser -v /dev/snd/*
> 

Anssi, thanks for your help.

1) In Fedora 21 (kernel 3.17.4), 
'fuser -v /dev/snd/*' shows below:
/dev/snd/controlC0:  xbing      2400 F.... pulseaudio
/dev/snd/controlC1:  xbing      2400 F.... pulseaudio
/dev/snd/pcmC0D3p:   xbing      2400 F...m pulseaudio
/dev/snd/pcmC1D0c:   xbing      2400 F...m pulseaudio
/dev/snd/pcmC1D0p:   xbing      2400 F...m pulseaudio

After 'pulseaudio --kill' to kill pulseaudio (after disable autospawn),
lsmod shows refcount of snd_hda_intel is down from 7 to 2 as below:
$ lsmod | grep hda_intel
snd_hda_intel          30479  2

'rmmod snd_hda_intel' still shows this module is in use.

2) But, in Ubuntu 14.04.1 (kernel 3.13.0) DOES work after 'pulseaudio --kill', because lsmod shows refcount of snd_hda_intel is 5.

Any suggestions? Could it be because of kernel difference 3.17.4 vs 3.13.0?

Thanks.
