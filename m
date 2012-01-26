From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8994: Report any low impedance
	accessory as a headphone
Date: Thu, 26 Jan 2012 19:16:02 +0000
Message-ID: <1327605362-27065-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327605362-27065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9077B103920
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 20:16:05 +0100 (CET)
In-Reply-To: <1327605362-27065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Report any accessory with a low impedance as a headphone, previously
anything other than a short or microphone would not be reported at all.
The most likely reason is a microphone with incorrect polarity.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b047bfa..11ca19b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3089,7 +3089,7 @@ static void wm8958_default_micdet(u16 status, void *data)
 	}
 
 
-	if (wm8994->mic_detecting && status & 0x4) {
+	if (wm8994->mic_detecting && status & 0xfc) {
 		dev_dbg(codec->dev, "Detected headphone\n");
 		wm8994->mic_detecting = false;
 
-- 
1.7.9.rc1
