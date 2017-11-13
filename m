From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH v2 1/2] ctl: deprecate APIs of
	dimensional information
Date: Mon, 13 Nov 2017 09:14:10 +0900
Message-ID: <20171113001411.7430-2-o-takashi@sakamocchi.jp>
References: <20171113001411.7430-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 192F926726B
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 01:14:19 +0100 (CET)
In-Reply-To: <20171113001411.7430-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In ALSA control interface in asound.h, 'struct snd_ctl_elem_info' has
'dimen' member to deliver information for multi-dimensional array, however
there's no common way to handle the member. As a result, drivers can
force userspace applications to handle the information by inconsistent
ways.

This issue was reported by a commit 51db452df07b ('Revert "ALSA: echoaudio:
purge contradictions between dimension matrix members and total number of
members"') to Linux kernel. As a result of discussion at Linux
miniconference 2017, usage of 'dimen' member of 'struct snd_ctl_elem_info'
is going to be deprecated for future removal.

A removal of kernel interface can cause regression issues. However no ALSA
driver in kernel land except for 'echoaudio' series utilizes this feature.
Actually it's reasonable to assume that 'echomixer' program is an unique
consumer of the interface in user land and the removal rarely brings any
impact to user land.

This commit deprecates some APIs corresponding to the kernel interface. The
kernel interface is kept till Linux kernel v4.20 at least, but actual
timing of removal is not fixed yet. After that, these APIs may also be
removed at a reasonable timing.
---
 src/control/control.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index 6439b294..268c5e9c 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2503,6 +2503,9 @@ const char *snd_ctl_elem_info_get_item_name(const snd_ctl_elem_info_t *obj)
  * \brief Get count of dimensions for given element
  * \param obj CTL element id/info
  * \return zero value if no dimensions are defined, otherwise positive value with count of dimensions
+ *
+ * \deprecated	Since 1.1.5
+ * #snd_ctl_elem_info_get_dimensions is deprecated without any replacement.
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_ctl_elem_info_get_dimensions)(const snd_ctl_elem_info_t *obj)
@@ -2525,6 +2528,9 @@ use_default_symbol_version(__snd_ctl_elem_info_get_dimensions, snd_ctl_elem_info
  * \param obj CTL element id/info
  * \param idx The dimension index
  * \return zero value if no dimension width is defined, otherwise positive value with with of specified dimension
+ *
+ * \deprecated	Since 1.1.5
+ * #snd_ctl_elem_info_get_dimension is deprecated without any replacement.
  */
 #ifndef DOXYGEN
 int INTERNAL(snd_ctl_elem_info_get_dimension)(const snd_ctl_elem_info_t *obj, unsigned int idx)
@@ -2553,6 +2559,9 @@ use_default_symbol_version(__snd_ctl_elem_info_get_dimension, snd_ctl_elem_info_
  *
  * \par Compatibility:
  * This function is added in version 1.1.2.
+ *
+ * \deprecated Since 1.1.5
+ * #snd_ctl_elem_info_set_dimension is deprecated without any replacement.
  */
 int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info,
 				    const int dimension[4])
-- 
2.14.1
