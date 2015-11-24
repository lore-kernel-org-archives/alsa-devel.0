From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH] ASoC: img: i2s out: Add AIF widgets
Date: Tue, 24 Nov 2015 15:34:48 +0000
Message-ID: <1448379288-2347-2-git-send-email-Damien.Horsley@imgtec.com>
References: <1448379288-2347-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D1C02659C4
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 16:35:06 +0100 (CET)
In-Reply-To: <1448379288-2347-1-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Damien.Horsley" <Damien.Horsley@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add AIF widgets to i2s output controller

This allows connections to this component in the dapm graph

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 sound/soc/img/img-i2s-out.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index 5f99713..b8dbe32 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -382,8 +382,14 @@ static int img_i2s_out_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget img_i2s_out_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("IMG I2S OUT", "Playback", 0, SND_SOC_NOPM, 0, 0)
+};
+
 static const struct snd_soc_component_driver img_i2s_out_component = {
-	.name = "img-i2s-out"
+	.name = "img-i2s-out",
+	.dapm_widgets = img_i2s_out_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(img_i2s_out_widgets)
 };
 
 static int img_i2s_out_dma_prepare_slave_config(struct snd_pcm_substream *st,
@@ -501,6 +507,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 	i2s->dai_driver.playback.channels_max = i2s->max_i2s_chan * 2;
 	i2s->dai_driver.playback.rates = SNDRV_PCM_RATE_8000_192000;
 	i2s->dai_driver.playback.formats = SNDRV_PCM_FMTBIT_S32_LE;
+	i2s->dai_driver.playback.stream_name = "Playback";
 	i2s->dai_driver.ops = &img_i2s_out_dai_ops;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-- 
2.1.4
