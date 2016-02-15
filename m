From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: [RFC 2/4] alsa: add locked variant for
	snd_ctl_remove_id
Date: Mon, 15 Feb 2016 17:49:30 +0530
Message-ID: <1455538772-24926-3-git-send-email-vaibhav.agarwal@linaro.org>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id B878326063A
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:19:48 +0100 (CET)
Received: by mail-pf0-f175.google.com with SMTP id e127so86964051pfe.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 04:19:48 -0800 (PST)
In-Reply-To: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
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
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

While removing kcontrols due to dynamic dai_link/codec removal,
mutex/semaphore for soc-card/sound card is already acquired.
Thus, added lock already acquired variant for ctl_remove_id.

Signed-off-by: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
---
 include/sound/control.h |  1 +
 sound/core/control.c    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sound/control.h b/include/sound/control.h
index 21d047f..8faea10 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -125,6 +125,7 @@ int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol, bool add_on_replace);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
+int snd_ctl_remove_id_locked(struct snd_card *card, struct snd_ctl_elem_id *id);
 int snd_ctl_rename_id(struct snd_card * card, struct snd_ctl_elem_id *src_id, struct snd_ctl_elem_id *dst_id);
 int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
 			int active);
diff --git a/sound/core/control.c b/sound/core/control.c
index a85d455..dca1998 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -530,6 +530,29 @@ int snd_ctl_remove_id(struct snd_card *card, struct snd_ctl_elem_id *id)
 EXPORT_SYMBOL(snd_ctl_remove_id);
 
 /**
+ * snd_ctl_remove_id_locked - remove the control of the given id and release it
+ * @card: the card instance
+ * @id: the control id to remove
+ *
+ * Finds the control instance with the given id, removes it from the
+ * card list and releases it.
+ *
+ * Return: 0 if successful, or a negative error code on failure.
+ */
+int snd_ctl_remove_id_locked(struct snd_card *card, struct snd_ctl_elem_id *id)
+{
+	struct snd_kcontrol *kctl;
+	int ret;
+
+	kctl = snd_ctl_find_id(card, id);
+	if (kctl == NULL)
+		return -ENOENT;
+	ret = snd_ctl_remove(card, kctl);
+	return ret;
+}
+EXPORT_SYMBOL(snd_ctl_remove_id_locked);
+
+/**
  * snd_ctl_remove_user_ctl - remove and release the unlocked user control
  * @file: active control handle
  * @id: the control id to remove
-- 
2.1.4
