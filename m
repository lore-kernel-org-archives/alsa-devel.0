From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 06/13] ASoC: wm_adsp: Clean up low level
	control read/write functions
Date: Mon, 13 Apr 2015 13:27:58 +0100
Message-ID: <1428928085-20250-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90312265104
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:07 +0200 (CEST)
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

Physically reading and writing controls to/from the DSP are handled by
two low level functions (wm_coeff_{write|read}_control, these currently
take in a snd_kcontrol pointer but immediately pull out a wm_coeff_ctl
pointer from the private data. These functions don't handle the kcontrols
at all they just shuttle data to and from the chip and all the call
sites have a wm_coeff_ctl pointer available. This patch just passes the
wm_coeff_ctl pointer straight into these functions.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6c4f013..37e01b0 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -372,10 +372,9 @@ static int wm_coeff_info(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
+static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 				  const void *buf, size_t len)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
 	const struct wm_adsp_region *mem;
 	struct wm_adsp *dsp = ctl->dsp;
@@ -424,13 +423,12 @@ static int wm_coeff_put(struct snd_kcontrol *kcontrol,
 	if (!ctl->enabled)
 		return 0;
 
-	return wm_coeff_write_control(kcontrol, p, ctl->len);
+	return wm_coeff_write_control(ctl, p, ctl->len);
 }
 
-static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
+static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 				 void *buf, size_t len)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
 	const struct wm_adsp_region *mem;
 	struct wm_adsp *dsp = ctl->dsp;
@@ -739,7 +737,7 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled || ctl->set)
 			continue;
-		ret = wm_coeff_read_control(ctl->kcontrol,
+		ret = wm_coeff_read_control(ctl,
 					    ctl->cache,
 					    ctl->len);
 		if (ret < 0)
@@ -758,7 +756,7 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 		if (!ctl->enabled)
 			continue;
 		if (ctl->set) {
-			ret = wm_coeff_write_control(ctl->kcontrol,
+			ret = wm_coeff_write_control(ctl,
 						     ctl->cache,
 						     ctl->len);
 			if (ret < 0)
-- 
1.7.2.5
