From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ctl: add an API to set dimension levels to
	element information
Date: Wed, 29 Jun 2016 22:43:00 +0900
Message-ID: <1467207783-19792-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 22C55266D8E
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 15:43:08 +0200 (CEST)
In-Reply-To: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In a former commit, 'struct snd_ctl_elem_info' is used as a 'container' to
transfer extra fields of element information for APIs to add an element
set. The extra fields should be filled in advance of call of the APIs.
Currently, dimension level is in the extra fields and no APIs to set it.

This commit adds an API to set dimension level to the information
structure. This API is expected to be used in advance of usage of APIs
to add an element set, for nothing others. When the information structure
is extended in future, then the similar APIs shall be added for the new
feature.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     |  2 ++
 src/control/control.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/control.h b/include/control.h
index b14edee..cd60d90 100644
--- a/include/control.h
+++ b/include/control.h
@@ -408,6 +408,8 @@ void snd_ctl_elem_info_set_item(snd_ctl_elem_info_t *obj, unsigned int val);
 const char *snd_ctl_elem_info_get_item_name(const snd_ctl_elem_info_t *obj);
 int snd_ctl_elem_info_get_dimensions(const snd_ctl_elem_info_t *obj);
 int snd_ctl_elem_info_get_dimension(const snd_ctl_elem_info_t *obj, unsigned int idx);
+int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info,
+				    const int dimension[4]);
 void snd_ctl_elem_info_get_id(const snd_ctl_elem_info_t *obj, snd_ctl_elem_id_t *ptr);
 unsigned int snd_ctl_elem_info_get_numid(const snd_ctl_elem_info_t *obj);
 snd_ctl_elem_iface_t snd_ctl_elem_info_get_interface(const snd_ctl_elem_info_t *obj);
diff --git a/src/control/control.c b/src/control/control.c
index 70b166b..2ad3e0d 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2458,6 +2458,36 @@ int snd_ctl_elem_info_get_dimension(const snd_ctl_elem_info_t *obj, unsigned int
 use_default_symbol_version(__snd_ctl_elem_info_get_dimension, snd_ctl_elem_info_get_dimension, ALSA_0.9.3);
 
 /**
+ * \brief Set width to a specified dimension level of given element information.
+ * \param info Information of an element.
+ * \param dimension Dimension width for each level by member unit.
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EINVAL
+ * <dd>Invalid arguments are given as parameters.
+ * </dl>
+ */
+int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info,
+				    const int dimension[4])
+{
+	unsigned int i;
+
+	if (info == NULL)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(info->dimen.d); i++) {
+		if (dimension[i] < 0)
+			return -EINVAL;
+
+		info->dimen.d[i] = dimension[i];
+	}
+
+	return 0;
+}
+
+/**
  * \brief Get CTL element identifier of a CTL element id/info
  * \param obj CTL element id/info
  * \param ptr Pointer to returned CTL element identifier
-- 
2.7.4
