From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Fix sense of speech clarity
	enable
Date: Fri,  4 Jan 2013 21:19:36 +0000
Message-ID: <1357334377-16388-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CEA2264F08
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 22:19:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 1cbe88f..12bcae6 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -209,9 +209,9 @@ static int wm2000_power_up(struct i2c_client *i2c, int analogue)
 
 	ret = wm2000_read(i2c, WM2000_REG_SPEECH_CLARITY);
 	if (wm2000->speech_clarity)
-		ret &= ~WM2000_SPEECH_CLARITY;
-	else
 		ret |= WM2000_SPEECH_CLARITY;
+	else
+		ret &= ~WM2000_SPEECH_CLARITY;
 	wm2000_write(i2c, WM2000_REG_SPEECH_CLARITY, ret);
 
 	wm2000_write(i2c, WM2000_REG_SYS_START0, 0x33);
-- 
1.7.10.4
