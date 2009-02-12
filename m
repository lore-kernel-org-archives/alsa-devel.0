From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: ASoC ac97: kobject warnings
Date: Thu, 12 Feb 2009 18:05:05 +0100
Message-ID: <20090212170504.GA7118@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil36.netpark.at
	[217.175.205.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 283F524131
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 18:05:05 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

the asoc generic ac97 codec support throws a warning on 2.6.29:

Advanced Linux Sound Architecture Driver Version 1.0.18a.
No device for DAI WM8731
No device for DAI au1xpsc_i2s
No device for DAI au1xpsc_ac97
AC97 SoC Audio Codec 0.6
asoc: AC97 HiFi <-> au1xpsc_ac97 mapping ok
kobject (8f9279ec): tried to init an initialized object, something is
seriously wrong.
Call Trace:
[<80106bcc>] dump_stack+0x8/0x34
[<8022c680>] kobject_init+0x50/0xcc
[<8026d914>] device_initialize+0x2c/0x9c
[<8026e274>] device_register+0x14/0x28
[<802ff2b8>] snd_soc_init_card+0x18c/0x24c
[<803024a4>] ac97_soc_probe+0x12c/0x178
[<802fe76c>] snd_soc_instantiate_cards+0x1d4/0x2f4
[<802fe8fc>] soc_probe+0x70/0xb8
[<8027044c>] driver_probe_device+0xe0/0x1b8
[<8026f884>] bus_for_each_drv+0x60/0xb0
[<80270670>] device_attach+0x60/0x88
[<8026f63c>] bus_attach_device+0x38/0x94
[<8026e0cc>] device_add+0x390/0x524
[<80271a90>] platform_device_add+0x14c/0x1bc
[<80462bd4>] db1200_audio_load+0xd8/0x10c
[<801090e0>] __kprobes_text_end+0x60/0x1c8
[<804532d0>] kernel_init+0x9c/0x108
[<8010cf90>] kernel_thread_helper+0x10/0x18

ALSA device list:
  #0: DB1200 AC97 Audio (AC97)


The asoc machine code is very similar to sound/soc/au1x/sample-ac97.c (full
source here:  http://mlau.at/db1200.c).  

I didn't bisect it;  however it started after the first ASoC patches went in
mainline after 2.6.28's release.

Please have a look!

Thanks,
	Manuel Lauss
