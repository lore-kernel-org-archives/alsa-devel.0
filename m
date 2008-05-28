From: "kunal@singhkunal.com" <kunal@singhkunal.com>
Subject: Re: problem with usb-audio and oss emulation
Date: Wed, 28 May 2008 03:47:39 -0400
Message-ID: <380-22008532874739209@M2W103.mail2web.com>
Reply-To: kunal@singhkunal.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xsmtp10.mail2web.com (xsmtp10.mail2web.com [168.144.250.180])
	by alsa0.perex.cz (Postfix) with ESMTP id ECE0A245A0
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 09:47:41 +0200 (CEST)
Received: from [168.144.108.103] (helo=M2W103.mail2web.com)
	by xsmtp10.mail2web.com with smtp (Exim 4.63)
	(envelope-from <kunal@singhkunal.com>) id 1K1GNn-0001jL-8w
	for alsa-devel@alsa-project.org; Wed, 28 May 2008 03:47:41 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

   The second issue is resolved too.
   I was using /dev/dsp to access the Default sound card -> card0.
   (1) The /dev/dsp is mapped (through a symbolic link) to /dev/sound/dsp
by default, when the system boots up. So, all works fine for me.
   (2) When I connect a usb-audio-device to my system, =

         (a) the /dev/dsp1 gets mapped to  /sound/dev/dsp1
         (b) And /dev/dsp too gets mapped to /sound/dev/dsp1
       So, I could not access /sound/dev/dsp. Is it not a bug?
    (3) When I dis-connect the usb-audio-device from my system
         both the "/dev/dsp" and "/dev/dsp1" entries dis-appear from my
system.
         Is this not a bug too?

    Every thing will work fine for me as long as I use entries
/dev/sound/dspN, insteading of /dev/dspN. =

    I think this issue must be fixed. Shall I report a bug or something? In
any case, I will spend some time in fixing this issue, when I get free from
current assignment.

Thanks and Regards,
Kunal


*****************


Hi All,

	The first issue was resolved by disabling the "CONFIG_SND_PCM_OSS_PLUGINS
<http://lxr.linux.no/linux/+code=3DCONFIG_SND_PCM_OSS_PLUGINS>".i.e. disable
the OSS plug-in support under KernelConfigMenu->sound->alsa

	CAN SOME ONE PLEASE HELP ON THIS?
	(2) Once I connect the iPod to my target, I can not any more use the
default sound card. I read on the oss-emulation tutorial that this could be
a problem with "dsp_map". But I am not able to check the current settings.
	=


Thanks and Regards,
Kunal


Date: Mon, 26 May 2008 20:10:11 +0530
From: Kunal Singh <kunal at singhkunal.com>
Subject: [alsa-devel] problem with usb-audio and oss emulation
To: alsa-devel at alsa-project.org
Message-ID: <483ACBCB.2020800 at singhkunal.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Hi,

    I am working on a ARM based target with 2.6.23 Kernel.  My project =

involves streaming data from a USB-Audio Device (an iPod) and playing it =

back on the target. I am using OSS-emulation API to communicate with the =

audio devices.
    What I am able to do:
    (1) I have a sound card in my target. This is mapped to card0. I can =

open the "dsp" device and can playback any audio data on this.
    (2) I have enabled the usb-audio module support in kernel =

configuration.   When I connect iPod to the target, I can see a new card =

"card1" being added in the /proc/asound/ directory.
    (3) I can open the "dsp1" device and can read from it. When I =

connect a "USB-Analyzer" I can see some valid data being streamed to the =

target.

    However, I am stuck with following issues:
    (1) The data being received on the target (in user mode) is junk. I =

put some printfs in the function "retire_capture_urb" in file =

"/linux/sound/usb/usbaudio.c", and I can see that the "data" which I see =

through usb-analzyer is reaching till this point. However, there seem to =

be some problem with one of the "snd_pmc_oss_ReadN" functions in file =

"http://lxr.linux.no/linux/sound/core/oss/pcm_oss.c". I am not able to =

exactly trace the problem, but I think that the "byte count" and "buffer =

address" being passed to snd-usb-audio is getting messed up some where. =

Has any one faced similar problems before?
    (2) Once I connect the iPod to my target, I can not any more use the =

default sound card. I read on the oss-emulation tutorial that this could =

be a problem with "dsp_map". But I am not able to check the current =

settings.
   =

    Can some one give me some pointers for further debugging?

Thanks and Regards,
Kunal Singh
www.singhkunal.com

--------------------------------------------------------------------
myhosting.com - Premium Microsoft=AE Windows=AE and Linux web and applicati=
on
hosting - http://link.myhosting.com/myhosting
