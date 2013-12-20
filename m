From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/19] ASoC: tegra: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:22 +0100
Message-ID: <1387545625-19240-16-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 2365626568C
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:47 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 sound/soc/tegra/tegra_pcm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 7b2d23b..c09ffd1 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -42,9 +42,6 @@ static const struct snd_pcm_hardware tegra_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
-	.channels_min		= 2,
-	.channels_max		= 2,
 	.period_bytes_min	= 1024,
 	.period_bytes_max	= PAGE_SIZE,
 	.periods_min		= 2,
-- 
1.8.0
