From: Kunal Singh <kunal@singhkunal.com>
Subject: Re: problem with usb-audio and oss emulation
Date: Tue, 27 May 2008 18:16:07 +0530
Message-ID: <483C028F.5050503@singhkunal.com>
References: <mailman.276.1211814913.2149.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-mail-35.bluehost.com (outbound-mail-35.bluehost.com
	[69.89.18.155]) by alsa0.perex.cz (Postfix) with SMTP id 6BB9324339
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 14:46:20 +0200 (CEST)
Received: from [122.167.44.165] (helo=[127.0.0.1])
	by host100.hostmonster.com with esmtpa (Exim 4.68)
	(envelope-from <kunal@singhkunal.com>) id 1K0yZF-0006VZ-BC
	for alsa-devel@alsa-project.org; Tue, 27 May 2008 06:46:18 -0600
In-Reply-To: <mailman.276.1211814913.2149.alsa-devel@alsa-project.org>
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

Hi All,

	The first issue was resolved by disabling the "CONFIG_SND_PCM_OSS_PLUGINS <http://lxr.linux.no/linux/+code=CONFIG_SND_PCM_OSS_PLUGINS>".i.e. disable the OSS plug-in support under KernelConfigMenu->sound->alsa

	CAN SOME ONE PLEASE HELP ON THIS?
	(2) Once I connect the iPod to my target, I can not any more use the default sound card. I read on the oss-emulation tutorial that this could be a problem with "dsp_map". But I am not able to check the current settings.
	

Thanks and Regards,
Kunal


Date: Mon, 26 May 2008 20:10:11 +0530
From: Kunal Singh <kunal@singhkunal.com>
Subject: [alsa-devel] problem with usb-audio and oss emulation
To: alsa-devel@alsa-project.org
Message-ID: <483ACBCB.2020800@singhkunal.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hi,

    I am working on a ARM based target with 2.6.23 Kernel.  My project 
involves streaming data from a USB-Audio Device (an iPod) and playing it 
back on the target. I am using OSS-emulation API to communicate with the 
audio devices.
    What I am able to do:
    (1) I have a sound card in my target. This is mapped to card0. I can 
open the "dsp" device and can playback any audio data on this.
    (2) I have enabled the usb-audio module support in kernel 
configuration.   When I connect iPod to the target, I can see a new card 
"card1" being added in the /proc/asound/ directory.
    (3) I can open the "dsp1" device and can read from it. When I 
connect a "USB-Analyzer" I can see some valid data being streamed to the 
target.

    However, I am stuck with following issues:
    (1) The data being received on the target (in user mode) is junk. I 
put some printfs in the function "retire_capture_urb" in file 
"/linux/sound/usb/usbaudio.c", and I can see that the "data" which I see 
through usb-analzyer is reaching till this point. However, there seem to 
be some problem with one of the "snd_pmc_oss_ReadN" functions in file 
"http://lxr.linux.no/linux/sound/core/oss/pcm_oss.c". I am not able to 
exactly trace the problem, but I think that the "byte count" and "buffer 
address" being passed to snd-usb-audio is getting messed up some where. 
Has any one faced similar problems before?
    (2) Once I connect the iPod to my target, I can not any more use the 
default sound card. I read on the oss-emulation tutorial that this could 
be a problem with "dsp_map". But I am not able to check the current 
settings.
   
    Can some one give me some pointers for further debugging?

Thanks and Regards,
Kunal Singh
www.singhkunal.com
