From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Set config update bits only when
	really changed
Date: Tue,  2 Jan 2018 15:24:21 +0100
Message-ID: <20180102142421.6028-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CD2C266DD5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 15:24:23 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AFF31AC30
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 14:24:22 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The PCM config space refine codes touch the parameter rmask and cmask
bits when the given config parameter is changed.  But in most places
it checks only whether the changed value is non-zero or not, and they
don't consider whether a negative error value is returned.  This will
lead to the incorrect update bits set upon the error path.

Fix the codes to check properly the return code whether it's really
updated or an error.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This was found during looking at the hw_params WARN_ON() with aloop.
It's likely harmless, but certainly a bug.

 sound/core/oss/pcm_oss.c | 10 +++++-----
 sound/core/pcm_lib.c     |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index e49f448ee04f..5d131088ac7c 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -186,7 +186,7 @@ static int _snd_pcm_hw_param_mask(struct snd_pcm_hw_params *params,
 {
 	int changed;
 	changed = snd_mask_refine(hw_param_mask(params, var), val);
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
@@ -233,7 +233,7 @@ static int _snd_pcm_hw_param_min(struct snd_pcm_hw_params *params,
 						  val, open);
 	else
 		return -EINVAL;
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
@@ -294,7 +294,7 @@ static int _snd_pcm_hw_param_max(struct snd_pcm_hw_params *params,
 						  val, open);
 	else
 		return -EINVAL;
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
@@ -500,7 +500,7 @@ static int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
 		}
 	} else
 		return -EINVAL;
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
@@ -540,7 +540,7 @@ static int _snd_pcm_hw_param_setinteger(struct snd_pcm_hw_params *params,
 {
 	int changed;
 	changed = snd_interval_setinteger(hw_param_interval(params, var));
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 10e7ef7a8804..bfff8d001466 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1603,7 +1603,7 @@ static int _snd_pcm_hw_param_first(struct snd_pcm_hw_params *params,
 		changed = snd_interval_refine_first(hw_param_interval(params, var));
 	else
 		return -EINVAL;
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
@@ -1649,7 +1649,7 @@ static int _snd_pcm_hw_param_last(struct snd_pcm_hw_params *params,
 		changed = snd_interval_refine_last(hw_param_interval(params, var));
 	else
 		return -EINVAL;
-	if (changed) {
+	if (changed > 0) {
 		params->cmask |= 1 << var;
 		params->rmask |= 1 << var;
 	}
-- 
2.15.1
