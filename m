From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Mon, 11 Feb 2008 16:46:55 +0100
Message-ID: <47B06DEF.4070609@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	
	<476A2BCC.4060109@gmail.com> <s5h1w9h4g5d.wl%tiwai@suse.de>	
	<47727C6C.6080401@gmail.com>
	<1198815321.3732.229.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 925A91038A9
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 16:47:05 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so413172uge.50
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 07:47:05 -0800 (PST)
In-Reply-To: <1198815321.3732.229.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis ha scritto:
> Ok, I'm going to dive into this one this weekend.  I have a test board
> ready to run.
> 
> Daniele, please email me off list to keep the noise level down.  I'm
> also tracking this in bugzilla.

since 16/01 i haven't any news from Tobin Davis in private email..

i sent him 3 mails in 3 weeks waiting for a reply without gettin any one

you can find all the news at the bug report:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3659

the last time i sent him an email with some remind on what's are, still, 
my problems..

can someone else take care of this problem? i'll try to help as best as 
i can...
you can find on the bug report the debug ( detect ) info with "test" 
module parameter

note: things still missing.. microphone don't work in recording, the 56k 
modem isn't recognized and i've some error in dmesg:
ALSA 
/usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1784: 
chipset global capabilities = 0x4401
ALSA 
/usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:736: 
codec_mask = 0xb
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:2212: hda_codec: 
model 'auto' is selected
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:2855: autoconfig: 
line_outs=1 (0x14/0x0/0x0/0x0/0x0)
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:2859: 
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:2863:    hp_outs=1 
(0x15/0x0/0x0/0x0/0x0)
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:2871:    inputs: 
mic=0x19, fmic=0x18, line=0x1a, fline=0x0, cd=0x0, aux=0x0
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Surround Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Center Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave LFE Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Side Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Speaker Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Mono Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave iSpeaker Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Line-Out Playback Volume, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Surround Playback Switch, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Center Playback Switch, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave LFE Playback Switch, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Side Playback Switch, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Speaker Playback Switch, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave Mono Playback Switch, skipped
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:1075: Cannot find 
slave iSpeaker Playback Switch, skipped
ALSA 
/usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1264: 
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:691: 
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x11
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:691: 
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
ALSA /usr/src/modules/alsa-driver/pci/hda/hda_codec.c:691: 
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11

thanks again


-- 
Iscritto alla ML del BiLUG da Lun 27 Mar 2006 21:39:26 CEST
Utilizzatore di Linux dal Luglio 2006

blog: http://natonelbronx.wordpress.com/
Daniele
