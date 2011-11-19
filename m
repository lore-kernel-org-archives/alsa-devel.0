From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: cs4271: Fix wrong mask parameter in some
 snd_soc_update_bits calls
Date: Sat, 19 Nov 2011 14:41:07 +0800
Message-ID: <1321684867.4103.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F6951037EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 07:41:19 +0100 (CET)
Received: by yenr9 with SMTP id r9so1309770yen.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 22:41:17 -0800 (PST)
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
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs4271.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 23d1bd5..69fde15 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -434,7 +434,8 @@ static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 {
 	int ret;
 	/* Set power-down bit */
-	ret = snd_soc_update_bits(codec, CS4271_MODE2, 0, CS4271_MODE2_PDN);
+	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
+				  CS4271_MODE2_PDN);
 	if (ret < 0)
 		return ret;
 	return 0;
@@ -501,8 +502,9 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = snd_soc_update_bits(codec, CS4271_MODE2, 0,
-		CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
+	ret = snd_soc_update_bits(codec, CS4271_MODE2,
+				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
+				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
 		return ret;
 	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
-- 
1.7.5.4
