From: Ryan Mallon <ryan@bluewatersys.com>
Subject: [PATCH] ASoC: Multi-component - Fix tlv320aic23
 hw_write/hw_read functions
Date: Mon, 28 Jun 2010 09:20:59 +1200
Message-ID: <4C27C0BB.5020600@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FCD6243EC
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 23:20:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Commit 5ce5888769c4a453bb5a852e156ab4ac72822c40 removed the
initialisations of the codec->hw_write/read functions for the
tlv320aic23. Fix this by adding the initialisations in tlv320aic23_probe.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index fbc95c5..fe89521 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -637,6 +637,8 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 
 	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
 	codec->control_data = aic23->control_data;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->hw_read = NULL;
 
 	/* Reset codec */
 	tlv320aic23_write(codec, TLV320AIC23_RESET, 0);
