From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Make SND_SOC_LITTLEMILL select MFD_WM8994
Date: Sun, 04 Dec 2011 08:15:17 +0800
Message-ID: <1322957717.19303.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA7B2445A
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 01:15:26 +0100 (CET)
Received: by iakr3 with SMTP id r3so2183684iak.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Dec 2011 16:15:24 -0800 (PST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SND_SOC_LITTLEMILL selects SND_SOC_WM8994, but SND_SOC_WM8994 needs MFD_WM8994.
Thus we need to select MFD_WM8994 to fix below build error:

  LD      .tmp_vmlinux1
sound/built-in.o: In function `wm8994_write':
sound/soc/codecs/wm8994.c:201: undefined reference to `wm8994_reg_write'
sound/built-in.o: In function `wm8994_read':
sound/soc/codecs/wm8994.c:222: undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_resume':
sound/soc/codecs/wm8994.c:2847: undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_codec_probe':
sound/soc/codecs/wm8994.c:3501: undefined reference to `wm8994_reg_read'
sound/soc/codecs/wm8994.c:3660: undefined reference to `wm8994_reg_read'
sound/soc/codecs/wm8994.c:3672: undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8958_dsp2_fw':
sound/soc/codecs/wm8958-dsp2.c:154: undefined reference to `wm8994_bulk_write'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 09d636c..f3417f2 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -210,4 +210,5 @@ config SND_SOC_LITTLEMILL
 	tristate "Audio support for Wolfson Littlemill"
 	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
 	select SND_SAMSUNG_I2S
+	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
1.7.5.4
