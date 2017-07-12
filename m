From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI
	assignments"
Date: Wed, 12 Jul 2017 17:55:30 +0200
Message-ID: <20170712155530.17765-2-johan@kernel.org>
References: <20170712155530.17765-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E600267025
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 17:57:20 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id z78so3464743lff.2
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 08:57:20 -0700 (PDT)
In-Reply-To: <20170712155530.17765-1-johan@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This reverts commit f1013cdeeeb9 ("ASoC: ux500: drop platform DAI
assignments"), which seems to have been based on a misunderstanding and
prevents the platform driver callbacks from being made (e.g. to
preallocate DMA memory).

The real culprit for the warnings about attempts to create duplicate
procfs entries was commit 99b04f4c4051 ("ASoC: add Component level
pcm_new/pcm_free" that broke PCM creation on systems that use more than
one platform component.

Fixes: f1013cdeeeb9 ("ASoC: ux500: drop platform DAI assignments")
Cc: stable <stable@vger.kernel.org>	# 4.11
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/ux500/mop500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index b50f68a439ce..ba9fc099cf67 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -33,6 +33,7 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 		.stream_name = "ab8500_0",
 		.cpu_dai_name = "ux500-msp-i2s.1",
 		.codec_dai_name = "ab8500-codec-dai.0",
+		.platform_name = "ux500-msp-i2s.1",
 		.codec_name = "ab8500-codec.0",
 		.init = mop500_ab8500_machine_init,
 		.ops = mop500_ab8500_ops,
@@ -42,6 +43,7 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 		.stream_name = "ab8500_1",
 		.cpu_dai_name = "ux500-msp-i2s.3",
 		.codec_dai_name = "ab8500-codec-dai.1",
+		.platform_name = "ux500-msp-i2s.3",
 		.codec_name = "ab8500-codec.0",
 		.init = NULL,
 		.ops = mop500_ab8500_ops,
@@ -85,6 +87,8 @@ static int mop500_of_probe(struct platform_device *pdev,
 	for (i = 0; i < 2; i++) {
 		mop500_dai_links[i].cpu_of_node = msp_np[i];
 		mop500_dai_links[i].cpu_dai_name = NULL;
+		mop500_dai_links[i].platform_of_node = msp_np[i];
+		mop500_dai_links[i].platform_name = NULL;
 		mop500_dai_links[i].codec_of_node = codec_np;
 		mop500_dai_links[i].codec_name = NULL;
 	}
-- 
2.13.2
