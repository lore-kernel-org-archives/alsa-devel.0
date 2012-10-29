From: Paolo Doz <paolo.doz@gmail.com>
Subject: [PATCH 4/4] ASoC: ak5702: Makefile and Kconfig for
	ak5702
Date: Mon, 29 Oct 2012 09:44:14 +0100
Message-ID: <CAFsPKCUFn2VsEmfD0t7Uv4K2FFENNQoeJGMWQRQnw5cK2VHdyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 79412265D0D
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 09:44:14 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1964642eek.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 01:44:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ASoC: ak5702: Makefile and Kconfig for ak5702

Signed-off-by: Paolo Doz <paolo.doz@gmail.com>
---
 sound/soc/codecs/Kconfig  |    4 ++++
 sound/soc/codecs/Makefile |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6f4f284..c029778 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -26,6 +26,7 @@ config SND_SOC_ALL_CODECS
     select SND_SOC_AK4641 if I2C
     select SND_SOC_AK4642 if I2C
     select SND_SOC_AK4671 if I2C
+    select SND_SOC_AK5702 if I2C
     select SND_SOC_ALC5623 if I2C
     select SND_SOC_ALC5632 if I2C
     select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
@@ -194,6 +195,9 @@ config SND_SOC_AK4642
 config SND_SOC_AK4671
     tristate

+config SND_SOC_AK5702
+    tristate
+
 config SND_SOC_ALC5623
        tristate
 config SND_SOC_ALC5632
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index c55d2d7..cc201a0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -14,6 +14,7 @@ snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4641-objs := ak4641.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
+snd-soc-ak5702-objs := ak5702.o
 snd-soc-arizona-objs := arizona.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs42l51-objs := cs42l51.o
@@ -134,6 +135,7 @@ obj-$(CONFIG_SND_SOC_AK4535)    += snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4641)    += snd-soc-ak4641.o
 obj-$(CONFIG_SND_SOC_AK4642)    += snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)    += snd-soc-ak4671.o
+obj-$(CONFIG_SND_SOC_AK5702)    += snd-soc-ak5702.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)    += snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)    += snd-soc-arizona.o
-- 
1.7.9.5
