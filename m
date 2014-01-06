From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 08/11] ASoC: nuc900: Don't set unused struct
	snd_pcm_hardware fields
Date: Mon,  6 Jan 2014 14:19:13 +0100
Message-ID: <1389014356-7014-8-git-send-email-lars@metafoo.de>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E1FF261A06
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:19:02 +0100 (CET)
In-Reply-To: <1389014356-7014-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>
---
No changes since v1
---
 sound/soc/nuc900/nuc900-pcm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index f588ee4..f434ed7 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -32,9 +32,6 @@ static const struct snd_pcm_hardware nuc900_pcm_hardware = {
 					SNDRV_PCM_INFO_MMAP_VALID |
 					SNDRV_PCM_INFO_PAUSE |
 					SNDRV_PCM_INFO_RESUME,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
-	.channels_min		= 1,
-	.channels_max		= 2,
 	.buffer_bytes_max	= 4*1024,
 	.period_bytes_min	= 1*1024,
 	.period_bytes_max	= 4*1024,
-- 
1.8.0
