From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Handle read failures in codec_reg
Date: Wed, 14 Jul 2010 16:15:13 +0100
Message-ID: <1279120513-29226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CE8E24520
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 17:15:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When a device is powered down volatile registers can't be read so
attempts to display codec_reg will show error values, and obviously
it is also possible for there to be hardware errors too. Check for
errors from reads and display them more clearly when formatting
codec_reg.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96f9a8e..844ae82 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -84,7 +84,7 @@ static int run_delayed_work(struct delayed_work *dwork)
 /* codec register dump */
 static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 {
-	int i, step = 1, count = 0;
+	int ret, i, step = 1, count = 0;
 
 	if (!codec->reg_cache_size)
 		return 0;
@@ -101,12 +101,24 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 		if (count >= PAGE_SIZE - 1)
 			break;
 
-		if (codec->display_register)
+		if (codec->display_register) {
 			count += codec->display_register(codec, buf + count,
 							 PAGE_SIZE - count, i);
-		else
-			count += snprintf(buf + count, PAGE_SIZE - count,
-					  "%4x", codec->read(codec, i));
+		} else {
+			/* If the read fails it's almost certainly due to
+			 * the register being volatile and the device being
+			 * powered off.
+			 */
+			ret = codec->read(codec, i);
+			if (ret >= 0)
+				count += snprintf(buf + count,
+						  PAGE_SIZE - count,
+						  "%4x", ret);
+			else
+				count += snprintf(buf + count,
+						  PAGE_SIZE - count,
+						  "<no data: %d>", ret);
+		}
 
 		if (count >= PAGE_SIZE - 1)
 			break;
-- 
1.7.1
