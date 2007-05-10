From: "xinyun liu" <xinyunliu.osc@gmail.com>
Subject: Re: Can't record sound on Aser Aspire 5100. ATI SB450,
	RelTek ALC 883
Date: Fri, 11 May 2007 04:04:09 +0800
Message-ID: <afc365e50705101304x55a79f27t832f7ad577926a0e@mail.gmail.com>
References: <afc365e50704290722s1867f059h3759d078607ed3ad@mail.gmail.com>
	<afc365e50704290729n7d35c112uc363f7ebe4b9415@mail.gmail.com>
	<681812960704291617pfb0517evf95e784fbe51e914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B02724408
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 22:04:11 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so702903nzf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 13:04:10 -0700 (PDT)
In-Reply-To: <681812960704291617pfb0517evf95e784fbe51e914@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ustun ERGENOGLU <ustun.ergenoglu@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

I have test all modes for alc883. The result is here:

0. 3stack-dig.  both extern/internal can play, but can't record sound
1.  3stack-6ch-dig  same with 3stack-dig
2.  3stack-6ch  can play, but can't record sound.  Can hear noise from the Mic.
3. 6stack-dig  both can play sound, can't record sound
4. tarta-dig  With alsamixer, can set to 2ch or 6ch, both can play sound, can't
5. tarta-2ch-dig  both can play sound, can't record sound.
6. 6stack-dig-demo both can play sound, can't record sound.
7. aser    both can play sound, can't record sound
8. medion    can't play sound
9. laptop-eapd   can play sound, but can't record sound
10. lenovo-101e  both can play sound, can't record sound

11. auto  both can play sound, and can record sound.
But the sound quality is too bad to use from the internel Mic.
After test it a while on switching the extern/internal Mic, the
quality both droped.
So I use lenovo-101e model, ( rebuild the driver, rmmod/insmod, use
alsamixer to adjust the limits). Then I use auto mode,  and the sound
record work again from external Mic. After I switch to internel Mic,
the quality droped again.

Do you have any idea about it? Thx!



2007/4/30, Ustun ERGENOGLU <ustun.ergenoglu@gmail.com>:
> I have a Fujitsu Siemens Amilo pa1510, with the same sound hardware,
> and the same problem. I have posted some messages here, made a bug
> report but no answer came :( i'm going hopeless.
>
> 2007/4/29, xinyun liu <xinyunliu.osc@gmail.com>:
> > I know it's the system bios does not set the pin configuration right.
> > But I don't know how to try out a correct model.
> >
> > Can anyone help to give some hints to fix it?
> >
> >
> > Regards,
> > Xinyun
> >
> >
> > 2007/4/29, xinyun liu <xinyunliu.osc@gmail.com>:
> > > hi,
> > > I have an Acer Aspire 5100. I can play sound but with the build in
> > > mic, I can't record sound. The driver is the latest HG code.
> > > http://pastebin.ca/464406
> > >
> > > [root@localhost ~]# lspci -nnv -d1002:437b
> > > 00:14.2 0403: 1002:437b (rev 01)
> > >        Subsystem: 1025:009f
> > >        Flags: bus master, slow devsel, latency 64, IRQ 19
> > >        Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
> > >        Capabilities: [50] Power Management version 2
> > >        Capabilities: [60] Message Signalled Interrupts: 64bit+
> > > Queue=0/0 Enable-
> > >
> > >
> > > [root@localhost ~]# dmesg | fgrep ALSA > /tmp/1
> > > [root@localhost ~]# vi /tmp/1
> > > ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:698:
> > > codec_mask = 0xb
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:1820: hda_codec: model 'acer'
> > > is selected for config 1025:0 (Acer laptop)
> > > ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:698:
> > > codec_mask = 0xb
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:1820: hda_codec: model 'acer'
> > > is selected for config 1025:0 (Acer laptop)
> > > ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> > > azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x2, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x4, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x3, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x5, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x2, stream=0x0, channel=0, format=0x0
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x4, stream=0x0, channel=0, format=0x0
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x3, stream=0x0, channel=0, format=0x0
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x5, stream=0x0, channel=0, format=0x0
> > > ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> > > azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x8, stream=0x1, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x8, stream=0x0, channel=0, format=0x0
> > > ALSA ~/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> > > azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x2, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x4, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x3, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x5, stream=0x5, channel=0, format=0x11
> > > ALSA ~/alsa-driver/pci/hda/hda_codec.c:630: hda_codec_setup_stream:
> > > NID=0x2, stream=0x0, channel=0, format=0x0
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
