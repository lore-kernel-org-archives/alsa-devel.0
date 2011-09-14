From: Axel Lin <axel.lin@gmail.com>
Subject: [linux-next] ASoC: sound/soc/samsung/neo1973_wm8753.c build failure
Date: Wed, 14 Sep 2011 17:18:13 +0800
Message-ID: <1315991893.17271.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I got below build error: ( on linux-next 20110831 )
  CC      sound/soc/samsung/neo1973_wm8753.o
sound/soc/samsung/neo1973_wm8753.c: In function 'neo1973_wm8753_init':
sound/soc/samsung/neo1973_wm8753.c:325: error: implicit declaration of function 'machine_is_neo1973_gta01'
make[3]: *** [sound/soc/samsung/neo1973_wm8753.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

I think the root cause is below commit:
commit 6f82f4db "ARM: Update (and cut down) mach-types"
removes neo1973_gta01 entry.

I'm not sure if we should add back the neo1973_gta01 entry to mach-types or
remove all machine_is_neo1973_gta01() calls in neo1973_wm8753.c.
Comments?

Regards,
Axel
