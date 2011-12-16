From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove unused variables in wm9090.c
Date: Fri, 16 Dec 2011 15:49:10 +0800
Message-ID: <1324021750.15709.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
	[209.85.216.44]) by alsa0.perex.cz (Postfix) with ESMTP id D7CB22414E
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 08:49:23 +0100 (CET)
Received: by qadb15 with SMTP id b15so853175qad.17
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 23:49:20 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Fix below build warnings:
  CC      sound/soc/codecs/wm9090.o
sound/soc/codecs/wm9090.c: In function 'wm9090_set_bias_level':
sound/soc/codecs/wm9090.c:496: warning: unused variable 'ret'
sound/soc/codecs/wm9090.c:496: warning: unused variable 'i'
sound/soc/codecs/wm9090.c:495: warning: unused variable 'reg_cache'
sound/soc/codecs/wm9090.c: In function 'wm9090_i2c_remove':
sound/soc/codecs/wm9090.c:658: warning: unused variable 'wm9090'

Signed-off-by: Axel Lin <axel.lin@gmail.com>
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
1.7.5.4
