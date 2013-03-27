From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: Constify the 'compr_ops' field of
	snd_soc_platform_driver
Date: Wed, 27 Mar 2013 12:02:24 +0100
Message-ID: <1364382144-30151-3-git-send-email-lars@metafoo.de>
References: <1364382144-30151-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EF41265134
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 12:06:58 +0100 (CET)
In-Reply-To: <1364382144-30151-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC core does not modify a platform driver's compr_ops structure. Making it
const allows ASoC platform drivers to declare their snd_compr_ops struct as
const.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index eae9c10..9eb0e4d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -810,7 +810,7 @@ struct snd_soc_platform_driver {
 	const struct snd_pcm_ops *ops;
 
 	/* platform stream compress ops */
-	struct snd_compr_ops *compr_ops;
+	const struct snd_compr_ops *compr_ops;
 
 	/* platform stream completion event */
 	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
-- 
1.8.0
