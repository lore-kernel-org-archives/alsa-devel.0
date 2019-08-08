From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: max98926: remove two unused variables
Date: Thu, 8 Aug 2019 22:32:15 +0800
Message-ID: <20190808143215.65904-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kstewart@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/max98926.c:28:26: warning:
 max98926_dai_txt defined but not used [-Wunused-const-variable=]
sound/soc/codecs/max98926.c:23:27: warning:
 max98926_boost_current_txt defined but not used [-Wunused-const-variable=]

They are never used, so can be removd.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/max98926.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 818c030..c4dfa8a 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -20,15 +20,6 @@ static const char * const max98926_boost_voltage_txt[] = {
 	"6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V"
 };
 
-static const char * const max98926_boost_current_txt[] = {
-	"0.6", "0.8", "1.0", "1.2", "1.4", "1.6", "1.8", "2.0",
-	"2.2", "2.4", "2.6", "2.8", "3.2", "3.6", "4.0", "4.4"
-};
-
-static const char *const max98926_dai_txt[] = {
-	"Left", "Right", "LeftRight", "LeftRightDiv2",
-};
-
 static const char *const max98926_pdm_ch_text[] = {
 	"Current", "Voltage",
 };
-- 
2.7.4
