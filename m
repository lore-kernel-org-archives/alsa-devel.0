From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Tue,  5 May 2009 11:25:00 +0200
Message-ID: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B307244F6
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 11:25:14 +0200 (CEST)
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
Cc: Timur Tabi <timur@freescale.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Replace the magic 0x80 value with a suitable macro definition.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
Cc: Mark Brown <broonie@sirena.org.uk>
---
 sound/soc/codecs/cs4270.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 0f453a0..bc338df 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -56,6 +56,7 @@
 #define CS4270_FIRSTREG	0x01
 #define CS4270_LASTREG	0x08
 #define CS4270_NUMREGS	(CS4270_LASTREG - CS4270_FIRSTREG + 1)
+#define CS4270_I2C_INCR	0x80
 
 /* Bit masks for the CS4270 registers */
 #define CS4270_CHIPID_ID	0xF0
@@ -296,7 +297,7 @@ static int cs4270_fill_cache(struct snd_soc_codec *codec)
 	s32 length;
 
 	length = i2c_smbus_read_i2c_block_data(i2c_client,
-		CS4270_FIRSTREG | 0x80, CS4270_NUMREGS, cache);
+		CS4270_FIRSTREG | CS4270_I2C_INCR, CS4270_NUMREGS, cache);
 
 	if (length != CS4270_NUMREGS) {
 		dev_err(codec->dev, "i2c read failure, addr=0x%x\n",
-- 
1.6.2.1
