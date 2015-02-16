From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Improve round to next
	4-byte boundary
Date: Mon, 16 Feb 2015 15:25:49 +0000
Message-ID: <1424100349-10520-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1424100349-10520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7586A260699
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:28:13 +0100 (CET)
In-Reply-To: <1424100349-10520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nikesh.oswal@wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Whilst the existing code does correctly round to the next 4-byte boundary
it does so rather inefficiently. This patch changes the rounding to be
simpler and more efficient.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 185ee85..d01c209 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1184,7 +1184,6 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	int ret, pos, blocks, type, offset, reg;
 	char *file;
 	struct wm_adsp_buf *buf;
-	int tmp;
 
 	file = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (file == NULL)
@@ -1334,12 +1333,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 			}
 		}
 
-		tmp = le32_to_cpu(blk->len) % 4;
-		if (tmp)
-			pos += le32_to_cpu(blk->len) + (4 - tmp) + sizeof(*blk);
-		else
-			pos += le32_to_cpu(blk->len) + sizeof(*blk);
-
+		pos += (le32_to_cpu(blk->len) + sizeof(*blk) + 3) & ~0x03;
 		blocks++;
 	}
 
-- 
1.7.2.5
