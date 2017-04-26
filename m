From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: hdmi-codec: Use devm_kcalloc() in
	hdmi_codec_probe()
Date: Wed, 26 Apr 2017 12:48:06 +0200
Message-ID: <de31f756-5be4-be07-aacf-055e2c2607f8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 29D022670B0
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 12:48:57 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jaroslav Kysela <perex@perex.cz>, Jon Medhurst <tixy@linaro.org>, Jyri Sarha <jsarha@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Vincent Abriou <vincent.abriou@st.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 12:26:06 +0200

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "devm_kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/hdmi-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 8c5ae1fc23a9..99933488fa03 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -825,8 +825,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 	hcp->hcd = *hcd;
 	mutex_init(&hcp->current_stream_lock);
-
-	hcp->daidrv = devm_kzalloc(dev, dai_count * sizeof(*hcp->daidrv),
+	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
 				   GFP_KERNEL);
 	if (!hcp->daidrv)
 		return -ENOMEM;
-- 
2.12.2
