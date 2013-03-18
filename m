From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: spear_pcm: Staticize non-exported
	structs
Date: Mon, 18 Mar 2013 18:57:24 +0100
Message-ID: <1363629444-22082-2-git-send-email-lars@metafoo.de>
References: <1363629444-22082-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 814162625D2
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 18:55:34 +0100 (CET)
In-Reply-To: <1363629444-22082-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/spear/spear_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 5e7aebe..dd71167 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -25,7 +25,7 @@
 #include <sound/soc.h>
 #include <sound/spear_dma.h>
 
-struct snd_pcm_hardware spear_pcm_hardware = {
+static struct snd_pcm_hardware spear_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
@@ -178,7 +178,7 @@ static int spear_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-struct snd_soc_platform_driver spear_soc_platform = {
+static struct snd_soc_platform_driver spear_soc_platform = {
 	.ops		=	&spear_pcm_ops,
 	.pcm_new	=	spear_pcm_new,
 	.pcm_free	=	spear_pcm_free,
-- 
1.8.0
