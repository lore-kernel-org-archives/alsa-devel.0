From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 04/13] ASoC: wm_adsp: Limit firmware control
	name to ALSA control name size
Date: Mon, 13 Apr 2015 13:27:56 +0100
Message-ID: <1428928085-20250-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 809C62650F2
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:05 +0200 (CEST)
In-Reply-To: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

ALSA only supports control names up to 44 bytes, so there is no point
allocating a whole page of memory to hold the control name, just limit
the control name to 44 bytes.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3f6b49d..c291203 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -789,7 +789,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	char *region_name;
 	int ret;
 
-	name = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	name = kmalloc(SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
 
@@ -814,7 +814,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		goto err_name;
 	}
 
-	snprintf(name, PAGE_SIZE, "DSP%d %s %x",
+	snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
 		 dsp->num, region_name, alg_region->alg);
 
 	list_for_each_entry(ctl, &dsp->ctl_list,
-- 
1.7.2.5
