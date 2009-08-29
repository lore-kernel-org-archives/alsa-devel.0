From: Christos Nikolaou <sv1eia@gmail.com>
Subject: ASoC DAI on Atmel AT32AP7000
Date: Sat, 29 Aug 2009 21:41:59 +0300
Message-ID: <608a0a800908291141q47aa9944v47cdcdc88b306002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id E06B424716
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Aug 2009 20:42:00 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2133045fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2009 11:41:59 -0700 (PDT)
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

Up to 2.6.28 the ASoC framework was working on AT32AP7000 Atmel platform.
Now I try to recompile it on 2.6.31-rc8 and I get

Advance Linux Sound Architecture Driver Version 1.0.20.
No device for DAI atmel-ssc0
No device for DAI atmel-ssc1
No device for DAI atmel-ssc2

whereas the ssc devices are properly (as in 2.6.28) initialized
ssc ssc.0: Atmel SSC device at 0xffe1c00 (irq 10)
ssc ssc.1: Atmel SSC device at 0xffe2000 (irq 11)
ssc ssc.2: Atmel SSC device at 0xffe2400 (irq 12)


It looks that this message comes from snd_soc_register_dai in soc-core.c

if (!dai->dev)
         printk(KERN_WARNING "No device for DAI %s\n", dai->name);

it seems for some reason it thinks there is no device in dai->dev

Unless I'm mistaken, that is being called from
sound/soc/atmel/atmel_ssc_dai.c after some modifications done by
broonie on these files according to
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=sound/soc/atmel;hb=adda766193ea1cf3137484a9521972d080d0b7af
.

Is there anything that can be done to rectify this?

Regards,
Christos
