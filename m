From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] bebob: Arrangement for critical section to
	be shorter
Date: Mon, 21 Jul 2014 11:10:00 +0900
Message-ID: <1405908605-8105-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 23EDC2650EE
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 04:10:17 +0200 (CEST)
In-Reply-To: <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: Wei Yongjun <weiyj_lk@163.com>, alsa-devel@alsa-project.org, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Cc: Wei Yongjun <weiyj_lk@163.com>

This commit move some mutex_lock() to shorten critical section in some
functions. This commit is my solution for this post.

[PATCH -next] ALSA: bebob: Fix missing unlock on error in special_clk_ctl_put()
https://lkml.org/lkml/2014/7/20/12

This commit also renames a function for my naming consistency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 6af50eb..0a33045 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -372,23 +372,24 @@ static int special_clk_ctl_get(struct snd_kcontrol *kctl,
 	uval->value.enumerated.item[0] = params->clk_src;
 	return 0;
 }
-static int special_clk_ctl_put(struct snd_kcontrol *kctl,
+static int special_clk_ctl_set(struct snd_kcontrol *kctl,
 			       struct snd_ctl_elem_value *uval)
 {
 	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
 	struct special_params *params = bebob->maudio_special_quirk;
 	int err, id;
 
-	mutex_lock(&bebob->mutex);
-
 	id = uval->value.enumerated.item[0];
 	if (id >= ARRAY_SIZE(special_clk_labels))
 		return 0;
 
+	mutex_lock(&bebob->mutex);
+
 	err = avc_maudio_set_special_clk(bebob, id,
 					 params->dig_in_fmt,
 					 params->dig_out_fmt,
 					 params->clk_lock);
+
 	mutex_unlock(&bebob->mutex);
 
 	return err >= 0;
@@ -399,7 +400,7 @@ static struct snd_kcontrol_new special_clk_ctl = {
 	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.info	= special_clk_ctl_info,
 	.get	= special_clk_ctl_get,
-	.put	= special_clk_ctl_put
+	.put	= special_clk_ctl_set
 };
 
 /* Clock synchronization control for special firmware */
@@ -491,14 +492,14 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 	unsigned int id, dig_in_fmt, dig_in_iface;
 	int err;
 
-	mutex_lock(&bebob->mutex);
-
 	id = uval->value.enumerated.item[0];
 
 	/* decode user value */
 	dig_in_fmt = (id >> 1) & 0x01;
 	dig_in_iface = id & 0x01;
 
+	mutex_lock(&bebob->mutex);
+
 	err = avc_maudio_set_special_clk(bebob,
 					 params->clk_src,
 					 dig_in_fmt,
@@ -558,10 +559,10 @@ static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
 	unsigned int id;
 	int err;
 
-	mutex_lock(&bebob->mutex);
-
 	id = uval->value.enumerated.item[0];
 
+	mutex_lock(&bebob->mutex);
+
 	err = avc_maudio_set_special_clk(bebob,
 					 params->clk_src,
 					 params->dig_in_fmt,
-- 
1.9.1
