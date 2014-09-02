From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v5 03/12] ALSA: control: Add init callback for
	kcontrol
Date: Tue,  2 Sep 2014 18:05:58 +0530
Message-ID: <1409661367-19047-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BF7A265529
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 14:58:32 +0200 (CEST)
In-Reply-To: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Some controls need to initialize stuffs like pvt data, so they need a
callback if the control creation is successful.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/control.h | 3 +++
 sound/core/control.c    | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/sound/control.h b/include/sound/control.h
index 0426139..1389f69 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -30,6 +30,7 @@ struct snd_kcontrol;
 typedef int (snd_kcontrol_info_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_info * uinfo);
 typedef int (snd_kcontrol_get_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
 typedef int (snd_kcontrol_put_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
+typedef int (snd_kcontrol_init_t) (struct snd_kcontrol * kcontrol);
 typedef int (snd_kcontrol_tlv_rw_t)(struct snd_kcontrol *kcontrol,
 				    int op_flag, /* SNDRV_CTL_TLV_OP_XXX */
 				    unsigned int size,
@@ -52,6 +53,7 @@ struct snd_kcontrol_new {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	snd_kcontrol_init_t *init;
 	union {
 		snd_kcontrol_tlv_rw_t *c;
 		const unsigned int *p;
@@ -71,6 +73,7 @@ struct snd_kcontrol {
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
+	snd_kcontrol_init_t *init;
 	union {
 		snd_kcontrol_tlv_rw_t *c;
 		const unsigned int *p;
diff --git a/sound/core/control.c b/sound/core/control.c
index b961134..9d30663 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -256,6 +256,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 	kctl.info = ncontrol->info;
 	kctl.get = ncontrol->get;
 	kctl.put = ncontrol->put;
+	kctl.init = ncontrol->init;
 	kctl.tlv.p = ncontrol->tlv.p;
 	kctl.private_value = ncontrol->private_value;
 	kctl.private_data = private_data;
@@ -362,6 +363,12 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 		err = -ENOMEM;
 		goto error;
 	}
+	if (kcontrol->init) {
+		err = kcontrol->init(kcontrol);
+		if (err < 0)
+			goto error;
+	}
+
 	list_add_tail(&kcontrol->list, &card->controls);
 	card->controls_count += kcontrol->count;
 	kcontrol->id.numid = card->last_numid + 1;
-- 
1.9.0
