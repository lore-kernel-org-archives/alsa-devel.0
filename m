From: Robert Rosengren <robert.rosengren@axis.com>
Subject: [PATCH] ASoC: sigmadsp: safeload should be used from 4
	bytes
Date: Wed, 22 Aug 2018 08:11:31 +0200
Message-ID: <20180822061131.13191-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id E17CB267657
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 08:11:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

From: Danny Smith <dannys@axis.com>

Fixed range in safeload conditional to allow safeload to be used from
4 bytes.

Signed-off-by: Danny Smith <dannys@axis.com>
---
 sound/soc/codecs/sigmadsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index d53680ac78e4..d63d58350cd8 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -117,7 +117,7 @@ static int sigmadsp_ctrl_write(struct sigmadsp *sigmadsp,
 	struct sigmadsp_control *ctrl, void *data)
 {
 	/* safeload loads up to 20 bytes in a atomic operation */
-	if (ctrl->num_bytes > 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
+	if (ctrl->num_bytes >= 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
 	    sigmadsp->ops->safeload)
 		return sigmadsp->ops->safeload(sigmadsp, ctrl->addr, data,
 			ctrl->num_bytes);
-- 
2.11.0
