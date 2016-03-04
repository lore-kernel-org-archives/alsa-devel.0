From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH] ASoC: rt5616: allow to build with CONFIG_SND_SOC_RT5616
Date: Fri,  4 Mar 2016 14:54:50 +0800
Message-ID: <1457074490-9636-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bardliao@realtek.com, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes that hasn't built the rt5616 driver with
'CONFIG_SND_SOC_RT5616=y' in .config.

The tristate is the prompt on the 'make menuconfig',
in other words, that can't show the prompt and select it
if we don't say what's the tristate.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4383966..14eb5f3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -623,7 +623,7 @@ config SND_SOC_RT5514
 	tristate
 
 config SND_SOC_RT5616
-	tristate
+	tristate "Realtek RT5616 CODEC"
 
 config SND_SOC_RT5631
 	tristate "Realtek ALC5631/RT5631 CODEC"
-- 
1.9.1
