From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: round to 4-byte boundary for
	coeff file blocks
Date: Fri,  8 Feb 2013 14:32:15 +0000
Message-ID: <1360333935-4939-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 354322615E5
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 15:37:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index be45e2b..f3f7e75 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -711,6 +711,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	int ret, pos, blocks, type, offset, reg;
 	char *file;
 	struct wm_adsp_buf *buf;
+	int tmp;
 
 	file = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (file == NULL)
@@ -842,7 +843,12 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 			}
 		}
 
-		pos += le32_to_cpu(blk->len) + sizeof(*blk);
+		tmp = le32_to_cpu(blk->len) % 4;
+		if (tmp)
+			pos += le32_to_cpu(blk->len) + (4 - tmp) + sizeof(*blk);
+		else
+			pos += le32_to_cpu(blk->len) + sizeof(*blk);
+
 		blocks++;
 	}
 
-- 
1.7.2.5
