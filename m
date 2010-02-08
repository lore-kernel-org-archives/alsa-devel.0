From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: cs4270: enable regulators at probe
	time
Date: Tue,  9 Feb 2010 02:32:59 +0800
Message-ID: <1265653979-2333-1-git-send-email-daniel@caiaq.de>
References: <4B62E8B7.5080403@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 818291037FE
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 19:33:30 +0100 (CET)
In-Reply-To: <4B62E8B7.5080403@freescale.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Enable the bulk regulators at probe time so we can safely disable them
again when going to suspend without confusing the reference counter.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 8b54575..63cb669 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -617,8 +617,17 @@ static int cs4270_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error_free_pcms;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
+				    cs4270->supplies);
+	if (ret < 0)
+		goto error_free_regulators;
+
 	return 0;
 
+error_free_regulators:
+	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies),
+			    cs4270->supplies);
+
 error_free_pcms:
 	snd_soc_free_pcms(socdev);
 
@@ -638,6 +647,7 @@ static int cs4270_remove(struct platform_device *pdev)
 	struct cs4270_private *cs4270 = codec->private_data;
 
 	snd_soc_free_pcms(socdev);
+	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 
 	return 0;
-- 
1.6.3.3
