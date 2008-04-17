From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] SOC: fix tests in cs4270_hw_params()
Date: Thu, 17 Apr 2008 17:45:39 +0200
Message-ID: <480770A3.3070805@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	by alsa0.perex.cz (Postfix) with ESMTP id A28E924340
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 17:45:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

cs4270_hw_params does several times:

ret = snd_soc_write()
if (ret < 0)
	...

This only works when ret is signed.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index bf2ab72..e73fcfd 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -372,7 +372,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->codec;
 	struct cs4270_private *cs4270 = codec->private_data;
-	unsigned int ret = 0;
+	int ret;
 	unsigned int i;
 	unsigned int rate;
 	unsigned int ratio;
