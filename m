From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH] ASoC: rk3036: fix missing dependency on
	REGMAP_MMIO
Date: Mon, 25 Jan 2016 18:23:30 +0100
Message-ID: <1453742610-23418-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A822260535
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 18:23:51 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Antonio Ospite <ao2@ao2.it>, ZhengShunQian <zhengsq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

When SND_SOC_INNO_RK3036 is enabled but REGMAP_MMIO is not, the MODPOST
step fails with this error:

  ...
  Kernel: arch/x86/boot/bzImage is ready  (#3)
    Building modules, stage 2.
    MODPOST 3203 modules
  ERROR: "__devm_regmap_init_mmio_clk" [sound/soc/codecs/snd-soc-inno-rk3036.ko] undefined!

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: ZhengShunQian <zhengsq@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>
---

Hi,

I enabled SND_SOC_INNO_RK3036 by chance in 4.5-rc1 and the build failed.
The patch below allows the kernel to be configured in a buildable way.

Ciao ciao,
   Antonio

 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 50693c8..1f7eaa9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -497,6 +497,7 @@ config SND_SOC_ICS43432
 
 config SND_SOC_INNO_RK3036
 	tristate "Inno codec driver for RK3036 SoC"
+	select REGMAP_MMIO
 
 config SND_SOC_ISABELLE
         tristate
-- 
2.7.0
