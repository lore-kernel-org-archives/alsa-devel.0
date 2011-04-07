From: Valerio tesei <valerio.tesei@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Thu, 7 Apr 2011 15:55:09 +0200
Message-ID: <BANLkTini-z-gZw9jGfCgj8eAVx=jbh15yg@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTim1wU9RBpZ3As9uxb=YEXWVST1FVw@mail.gmail.com>
	<BANLkTinSpX+EOs2EMTxTpwKKk4sm89Q_LA@mail.gmail.com>
	<BANLkTi=D1AX9b-kU6oZv+F0aWa0fGcuNtg@mail.gmail.com>
	<BANLkTikorXUoaGiJ94i_syzfN-0Oy98tzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DEB40103815
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 15:55:09 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1865823fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2011 06:55:09 -0700 (PDT)
In-Reply-To: <BANLkTikorXUoaGiJ94i_syzfN-0Oy98tzw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

to find out which hw cannot ioremap just search around dmesg and messages ?
Need some debug flag in kernel?

About the stream_cleanup are comed out after enabling verbose messages in
kernel config for alsa.

must we rename the subject of the email?
we passed from alc662 to alc892,this may confuse some one else

here is 15.50, at 19.30 i'm back home and could test and compile :)

So write here anything you need, i will post it later.

V.

2011/4/7 Raymond Yau <superquad.vortex2@gmail.com>

> 2011/4/7 Valerio tesei <valerio.tesei@gmail.com>
>
> > This evening i will check out the Takashi sound-2.6 git kernel tree and
> > update it every day to give feedback on problems with this card on my
> > motherboard.
> >
> > If i could help in any other way (debug, dmesg or others) let me know :)
> >
> > why alsaconf does not find my card? what i'm wrong?
> >
> > anyway, thanks for all this work.
> >
> >
> You have to find out from system log which hardware cannot ioremap
>
> [ 250.950937] ioremap error for 0xdde70000-0xdde71000, requested 0x10, got
> 0x0
>
> Is it normal to have so many hda_codec_cleanup_stream  ?
>
> [ 369.824424] hda_codec_cleanup_stream: NID=0x9
> [ 369.824857] hda_codec_cleanup_stream: NID=0x9
> [ 369.825335] hda_codec_cleanup_stream: NID=0x9
> [ 369.825764] hda_codec_cleanup_stream: NID=0x9
> [ 369.826232] hda_codec_cleanup_stream: NID=0x9
> [ 369.826634] hda_codec_cleanup_stream: NID=0x9
> [ 369.827095] hda_codec_cleanup_stream: NID=0x9
>
>
> The HDA controller seem support multi stream capture
>
> [ 6.748965] hda-intel: chipset global capabilities = 0x4401
>
> Two stereo ADCs support 16/20/24-bit PCM format, multiple stereo recording
>
> but the driver only create 1 capture stream.but two capture volume/switches
> and input sources
>
> ARECORD
> **** List of CAPTURE Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC892 Analog [ALC892 Analog]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
>
> Simple mixer control 'Input Source',0
>  Capabilities: cenum
>  Items: 'Rear Mic' 'Front Mic' 'Line'
>  Item0: 'Rear Mic'
> Simple mixer control 'Input Source',1
>  Capabilities: cenum
>  Items: 'Rear Mic' 'Front Mic' 'Line'
>  Item0: 'Rear Mic'
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
