From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: vc4: vc4_htmi: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:13 +0100 (BST)
Message-ID: <20190606212614.07E01440049@finisterre.sirena.org.uk>
References: <87tvd3fjgj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D10BDF89756
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:14 +0200 (CEST)
In-Reply-To: <87tvd3fjgj.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: vc4: vc4_htmi: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0467d8ef0f61c91774f49a2d287b4d6fe58d5bdb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:19:19 +0900
Subject: [PATCH] ASoC: vc4: vc4_htmi: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 99fc8569e0f5..6beac1ca1f27 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -69,6 +69,9 @@
 struct vc4_hdmi_audio {
 	struct snd_soc_card card;
 	struct snd_soc_dai_link link;
+	struct snd_soc_dai_link_component cpu;
+	struct snd_soc_dai_link_component codec;
+	struct snd_soc_dai_link_component platform;
 	int samplerate;
 	int channels;
 	struct snd_dmaengine_dai_dma_data dma_data;
@@ -1096,12 +1099,20 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *hdmi)
 		return ret;
 	}
 
+	dai_link->cpus		= &hdmi->audio.cpu;
+	dai_link->codecs	= &hdmi->audio.codec;
+	dai_link->platforms	= &hdmi->audio.platform;
+
+	dai_link->num_cpus	= 1;
+	dai_link->num_codecs	= 1;
+	dai_link->num_platforms	= 1;
+
 	dai_link->name = "MAI";
 	dai_link->stream_name = "MAI PCM";
-	dai_link->codec_dai_name = vc4_hdmi_audio_codec_dai_drv.name;
-	dai_link->cpu_dai_name = dev_name(dev);
-	dai_link->codec_name = dev_name(dev);
-	dai_link->platform_name = dev_name(dev);
+	dai_link->codecs->dai_name = vc4_hdmi_audio_codec_dai_drv.name;
+	dai_link->cpus->dai_name = dev_name(dev);
+	dai_link->codecs->name = dev_name(dev);
+	dai_link->platforms->name = dev_name(dev);
 
 	card->dai_link = dai_link;
 	card->num_links = 1;
-- 
2.20.1
