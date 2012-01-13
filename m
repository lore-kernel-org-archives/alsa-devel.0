From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: codecs: wm9090: Fix build warnings due
	to unused variables
Date: Thu, 12 Jan 2012 23:55:59 -0200
Message-ID: <1326419759-14853-1-git-send-email-festevam@gmail.com>
Content-Type: multipart/mixed; boundary="===============2575078280996627456=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E57924332
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 02:56:12 +0100 (CET)
Received: by ghrr11 with SMTP id r11so686469ghr.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 17:56:10 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============2575078280996627456==

Fix the following build warnings:

sound/soc/codecs/wm9090.c: In function ‘wm9090_set_bias_level’:
sound/soc/codecs/wm9090.c:496: warning: unused variable ‘ret’
sound/soc/codecs/wm9090.c:496: warning: unused variable ‘i’
sound/soc/codecs/wm9090.c:495: warning: unused variable ‘reg_cache’
sound/soc/codecs/wm9090.c: In function ‘wm9090_i2c_remove’:
sound/soc/codecs/wm9090.c:658: warning: unused variable ‘wm9090’

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm9090.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 41ebe0d..acac7d6 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -492,9 +492,6 @@ static int wm9090_add_controls(struct snd_soc_codec *codec)
 static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 *reg_cache = codec->reg_cache;
-	int i, ret;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -655,8 +652,6 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 static int __devexit wm9090_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
-- 
1.7.1


--===============2575078280996627456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2575078280996627456==--
