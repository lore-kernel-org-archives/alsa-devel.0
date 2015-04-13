From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 08/13] ASoC: wm_adsp: Remove private field from
	wm_coeff_ctl
Date: Mon, 13 Apr 2015 13:28:00 +0100
Message-ID: <1428928085-20250-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CD0A26508C
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:09 +0200 (CEST)
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

The private field in wm_coeff_ctl is currently unused and given the
controls are entirely handled within the ADSP code it is not clear what
it would be used for in the future. Remove the field for now it can be
readded if it is ever required.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9283d08..d6e8913 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -232,7 +232,6 @@ struct wm_coeff_ctl {
 	struct wm_adsp_alg_region alg_region;
 	struct wm_coeff_ctl_ops ops;
 	struct wm_adsp *dsp;
-	void *private;
 	unsigned int enabled:1;
 	struct list_head list;
 	void *cache;
-- 
1.7.2.5
