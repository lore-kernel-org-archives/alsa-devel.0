From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Tue, 25 Jan 2011 09:17:21 +0800
Message-ID: <AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 78757103848
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 02:17:23 +0100 (CET)
Received: by ewy19 with SMTP id 19so2211781ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 17:17:22 -0800 (PST)
In-Reply-To: <AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
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

2011/1/24 Robin Neatherway <neatherway@gmail.com>

> > If you compiled the driver in debug mode, you can select model=test for
> > alc260
> >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=7cf51e48315d87b4c1cf600d611894f45f661142
>
> Thanks for the suggestion. I tried compiling both the stable versions
> and the latest snapshots. The result was that new modules appeared in
> /lib/modules/`uname -r`/updates/alsa, which I think is the idea.
> However, when trying to use these modules, I received
>
> $ sudo modprobe snd-hda-intel
> FATAL: Error inserting snd_hda_intel
> (/lib/modules/2.6.35-24-generic/updates/alsa/pci/hda/snd-hda-intel.ko):
> Unknown symbol in module, or unknown parameter (see dmesg)
>
> And dmesg contains the following:
> syslog:Jan 23 16:47:03 baldur kernel: [   23.389315] snd: Unknown
> symbol unregister_sound_special (err 0)
> syslog:Jan 23 16:47:03 baldur kernel: [   23.390067] snd: Unknown
> symbol register_sound_special_device (err 0)
>
> After reinstalling the alsa and linux-sound packages for Ubuntu, I
> recovered sound, but I can't try the "test" parameter without being
> able to load the module.
>
> Do you know what this error means?
>


Because ubuntu had disabled OSS emulation , you have to disable OSS
emulation too.

./configure --with-oss=no
