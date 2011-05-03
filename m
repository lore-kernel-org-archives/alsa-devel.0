From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [PATCH] SOC: UDA134x: Enable POWER_OFF_ON_STANDBY define.
Date: Tue,  3 May 2011 11:32:29 +0200
Message-ID: <1304415149-19725-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: alsa-devel@alsa-project.org

Without this define we can't get any sound from codec so enable
it by default. This define unlock bias settings which control
power control for DAC and ADC (by default 0 0 which is off off).

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 sound/soc/codecs/uda134x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 48ffd40..8c6808ad 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -26,6 +26,7 @@
 
 #include "uda134x.h"
 
+#define POWER_OFF_ON_STANDBY
 
 #define UDA134X_RATES SNDRV_PCM_RATE_8000_48000
 #define UDA134X_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
-- 
1.7.4.1
