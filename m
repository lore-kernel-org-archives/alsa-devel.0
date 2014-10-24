From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add snd_ctl_enum_info
Date: Fri, 24 Oct 2014 09:25:19 +0200
Message-ID: <1414135519-6096-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AD1C626049E
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 09:25:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/sound/control.h |  2 ++
 snd-control.c           | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sound/control.h b/include/sound/control.h
index 47b92c5..eaaada4 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -101,6 +101,8 @@ int snd_ctl_boolean_mono_info(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_info *uinfo);
 int snd_ctl_boolean_stereo_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo);
+int snd_ctl_enum_info(struct snd_ctl_elem_info *info, unsigned int channels,
+		      unsigned int items, const char *const names[]);
 
 /*
  * virtual master control
diff --git a/snd-control.c b/snd-control.c
index 3e3686f..a4a7a14 100644
--- a/snd-control.c
+++ b/snd-control.c
@@ -153,6 +153,24 @@ int snd_ctl_boolean_stereo_info(struct snd_kcontrol *kcontrol,
 }
 #endif
 
+int snd_ctl_enum_info(struct snd_ctl_elem_info *info, unsigned int channels,
+		      unsigned int items, const char *const names[])
+{
+	info->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	info->count = channels;
+	info->value.enumerated.items = items;
+	if (!items)
+		return 0;
+	if (info->value.enumerated.item >= items)
+		info->value.enumerated.item = items - 1;
+	if (strlen(names[info->value.enumerated.item]) >= sizeof(info->value.enumerated.name))
+		hda_log(HDA_LOG_WARN, "ALSA: too long item name '%s'\n", names[info->value.enumerated.item]);
+	strlcpy(info->value.enumerated.name,
+		names[info->value.enumerated.item],
+		sizeof(info->value.enumerated.name));
+	return 0;
+}
+
 int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
 			int active)
 {
-- 
1.9.1
