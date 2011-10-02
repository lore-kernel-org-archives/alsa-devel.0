From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Remove unused rate variable in
 magician_playback_hw_params
Date: Sun, 02 Oct 2011 21:05:56 +0800
Message-ID: <1317560756.21926.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E6AEA244E1
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 15:06:06 +0200 (CEST)
Received: by iabn5 with SMTP id n5so4317559iab.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 06:06:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/magician.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 67dcc36..098e5f4 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -92,11 +92,10 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	unsigned int acps, acds, width, rate;
+	unsigned int acps, acds, width;
 	unsigned int div4 = PXA_SSP_CLK_SCDB_4;
 	int ret = 0;
 
-	rate = params_rate(params);
 	width = snd_pcm_format_physical_width(params_format(params));
 
 	/*
-- 
1.7.4.1
