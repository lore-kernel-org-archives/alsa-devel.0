From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ALSA: ASoC: cs4720: use snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 17:17:23 +0100
Message-ID: <1321978643-23976-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F31B103AB1
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 17:17:45 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, s.neumann@raumfeld.com, timur@freescale.com, Daniel Mack <zonque@gmail.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Replace the manual register restore mechanism in cs4270.c and call the
generic snd_soc_cache_sync() handler instead.

This factors code out in favour of core facilities and also fixes a
bus confusion that is most probably caused by intermixing i2c-regmap
functions and i2c_smbus_* accessors.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
---
 sound/soc/codecs/cs4270.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index f1f237e..73f46eb 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -601,7 +601,6 @@ static int cs4270_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 static int cs4270_soc_resume(struct snd_soc_codec *codec)
 {
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c_client = to_i2c_client(codec->dev);
 	int reg;
 
 	regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
@@ -612,14 +611,7 @@ static int cs4270_soc_resume(struct snd_soc_codec *codec)
 	ndelay(500);
 
 	/* first restore the entire register cache ... */
-	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
-		u8 val = snd_soc_read(codec, reg);
-
-		if (i2c_smbus_write_byte_data(i2c_client, reg, val)) {
-			dev_err(codec->dev, "i2c write failed\n");
-			return -EIO;
-		}
-	}
+	snd_soc_cache_sync(codec);
 
 	/* ... then disable the power-down bits */
 	reg = snd_soc_read(codec, CS4270_PWRCTL);
-- 
1.7.7.3
