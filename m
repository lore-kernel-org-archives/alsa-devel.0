From: Bastien Nocera <hadess@hadess.net>
Subject: Surface 3 audio broken between 4.11 and 4.13 (rt5645)
Date: Fri, 13 Oct 2017 20:40:36 +0200
Message-ID: <1507920036.5910.46.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E14B266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 20:40:38 +0200 (CEST)
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
 (Authenticated sender: hadess@hadess.net)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 531C7C5A56
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 20:40:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey,

As I was trying to test PulseAudio HDMI LPE audio support fixes, I
realised that the internal sound card of my Surface 3 wasn't working
anymore, using the same user-space configuration.

Looks like detection of the device regressed between 2 versions. Does
this look familiar to anyone, or should I start bisecting? (which will
take me absolutely ages, as the CPU is anemic on that machine)

Working:
$ dmesg | grep rt5 
[   13.707825] rt5640 i2c-10EC5640:00: Device with ID register 0x6308 is not rt5640/39
[   15.010548] cht-bsw-rt5645 cht-bsw-rt5645: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
[   15.011132] cht-bsw-rt5645 cht-bsw-rt5645: snd-soc-dummy-dai <-> deepbuffer-cpu-dai mapping ok
[   15.012756] cht-bsw-rt5645 cht-bsw-rt5645: rt5645-aif1 <-> ssp2-port mapping ok
[   15.100152] input: chtrt5645 Headset as /devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0/input27

$ uname -r
4.11.0-0.rc0.git4.21.surface3.fc26.x86_64

Not working:
$ journalctl -b -2 | grep rt5 
Oct 13 20:10:19 surface kernel: rt5640 i2c-10EC5640:00: Device with ID register 0x6308 is not rt5640/39
Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
Oct 13 20:10:21 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
Oct 13 20:10:22 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk DMIC enabled
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: ASoC: CODEC DAI rt5640-aif1 not registered
Oct 13 20:10:23 surface kernel: bytcr_rt5640 bytcr_rt5640: devm_snd_soc_register_card failed -517

$ journalctl -b -2 | head -n3 | tail -n1 
Oct 13 22:10:10 surface kernel: Linux version 4.13.0-0.rc2.git0.26.surface3.fc27.x86_64 (hadess@classic) (gcc version 7.1.1 20170526 (Red Hat 7.1.1-2) (GCC)) #1 SMP Tue Jul 25 18:47:03 CEST 2017

Cheers
