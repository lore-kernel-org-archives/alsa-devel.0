From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] ASoC: rcar: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 13:56:11 +0100
Message-ID: <1420203373-1844-5-git-send-email-lars@metafoo.de>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A4A2604DD
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 13:56:35 +0100 (CET)
In-Reply-To: <1420203373-1844-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

The ALSA core takes care that all preallocated memory is freed when the PCM
itself is freed. There is no need to do this manually in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/rcar/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 75308bb..d9c81cd 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1140,15 +1140,9 @@ static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
 }
 
-static void rsnd_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static struct snd_soc_platform_driver rsnd_soc_platform = {
 	.ops		= &rsnd_pcm_ops,
 	.pcm_new	= rsnd_pcm_new,
-	.pcm_free	= rsnd_pcm_free,
 };
 
 static const struct snd_soc_component_driver rsnd_soc_component = {
-- 
1.8.0
