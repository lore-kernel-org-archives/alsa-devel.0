From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/10] ctl: deprecate APIs to add an element
	set with a single element
Date: Sun, 12 Jun 2016 17:16:07 +0900
Message-ID: <1465719371-27721-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 04A81261294
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 10:16:19 +0200 (CEST)
In-Reply-To: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
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

When comparing old APIs (to add a single element) with new APIs (to add
an element set), the latter has an benefit to get full identical
information for a first element in the element set. Furthermore, in
previous commit, the old APIs become simple wrappers to the new APIs.
Therefore, there's few intentions to use the old APIs.

This commit deprecates the old APIs to encourage the usage of new APIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     | 17 ++++++++++++-----
 src/control/control.c | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/control.h b/include/control.h
index d6069ff..e21a58a 100644
--- a/include/control.h
+++ b/include/control.h
@@ -443,14 +443,21 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
 			       unsigned int element_count,
 			       unsigned int member_count);
-
-int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long imin, long imax, long istep);
-int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long long imin, long long imax, long long istep);
-int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count);
-int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, unsigned int items, const char *const names[]);
 int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id);
 int snd_ctl_elem_remove(snd_ctl_t *ctl, snd_ctl_elem_id_t *id);
 
+int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+		unsigned int count, long imin, long imax,
+		long istep) __attribute__((deprecated));
+int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+		unsigned int count, long long imin, long long imax,
+		long long istep) __attribute__((deprecated));
+int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+		unsigned int count) __attribute__((deprecated));
+int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+		unsigned int count, unsigned int items,
+		const char *const names[]) __attribute__((deprecated));
+
 size_t snd_ctl_elem_value_sizeof(void);
 /** \hideinitializer
  * \brief allocate an invalid #snd_ctl_elem_value_t using standard alloca
diff --git a/src/control/control.c b/src/control/control.c
index fbc5e18..6893012 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -677,6 +677,8 @@ int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
  *
  * This function is a wrapper function to snd_ctl_elem_add_integer_set() for
  * single control element.
+ *
+ * \deprecated Since 1.1.2. Use snd_ctl_elem_add_integer_set(), instead.
  */
 int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count,
@@ -690,12 +692,17 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	return snd_ctl_elem_add_integer_set(ctl, local_id, 1, member_count,
 					    min, max, step);
 }
+link_warning(snd_ctl_elem_add_integer,
+	     "Warning: snd_ctl_elem_add_integer is deprecated, "
+	     "Use snd_ctl_elem_add_integer_set, instead.");
 
 /**
  * \brief Create and add an user-defined control element of integer64 type.
  *
  * This function is a wrapper function to snd_ctl_elem_add_integer64_set() for
  * single control element.
+ *
+ * \deprecated Since 1.1.2. Use snd_ctl_elem_add_integer64_set(), instead.
  */
 int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			       unsigned int member_count,
@@ -709,12 +716,17 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	return snd_ctl_elem_add_integer64_set(ctl, local_id, 1, member_count,
 					      min, max, step);
 }
+link_warning(snd_ctl_elem_add_integer64,
+	     "Warning: snd_ctl_elem_add_integer64 is deprecated, "
+	     "Use snd_ctl_elem_add_integer64_set, instead.");
 
 /**
  * \brief Create and add an user-defined control element of boolean type.
  *
  * This function is a wrapper function to snd_ctl_elem_add_boolean_set() for
  * single control element.
+ *
+ * \deprecated Since 1.1.2. Use snd_ctl_elem_add_boolean_set(), instead.
  */
 int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     unsigned int member_count)
@@ -726,6 +738,9 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 
 	return snd_ctl_elem_add_boolean_set(ctl, local_id, 1, member_count);
 }
+link_warning(snd_ctl_elem_add_boolean,
+	     "Warning: snd_ctl_elem_add_boolean is deprecated, "
+	     "Use snd_ctl_elem_add_boolean_set, instead.");
 
 /**
  * \brief Create and add a user-defined control element of enumerated type.
@@ -734,6 +749,8 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * single control element.
  *
  * This function is added in version 1.0.25.
+ *
+ * \deprecated Since 1.1.2. Use snd_ctl_elem_add_enumerated_set(), instead.
  */
 int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 				unsigned int member_count, unsigned int items,
@@ -747,6 +764,9 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	return snd_ctl_elem_add_enumerated_set(ctl, local_id, 1, member_count,
 					       items, labels);
 }
+link_warning(snd_ctl_elem_add_enumerated,
+	     "Warning: snd_ctl_elem_add_enumerated is deprecated, "
+	     "Use snd_ctl_elem_add_enumerated_set, instead.");
 
 /**
  * \brief Create and add a user-defined control element of IEC958 type.
-- 
2.7.4
