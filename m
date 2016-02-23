From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] control: improve API documentation for
	functions to set/get channel values for an element
Date: Tue, 23 Feb 2016 09:48:27 +0900
Message-ID: <1456188510-7189-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FA3F260563
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 01:48:35 +0100 (CET)
In-Reply-To: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
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

Current API documentation about functions to set/get element value
includes unfriendry texts for userspace developers. This commit improves
them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 117 +++++++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 53 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index fe9e557..3ce14c2 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2563,10 +2563,11 @@ void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val)
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_BOOLEAN CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value from given data for a specified channel as an element of
+ * boolean type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \return Value for the channel.
  */ 
 int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2576,10 +2577,11 @@ int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value from given data for a specified channel as an element of
+ * integer type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \return Value for the channel.
  */ 
 long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2589,10 +2591,11 @@ long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned in
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER64 CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value from given data for a specified channel as an element of
+ * integer64 type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \return Value for the channel.
  */ 
 long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2602,10 +2605,11 @@ long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsi
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_ENUMERATED CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value from given data for a specified channel as an element of
+ * enumerated type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \return Value for the channel. This is an index of name set in the element.
  */ 
 unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2615,10 +2619,11 @@ unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj,
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value from given data for a specified channel as an element of
+ * bytes type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \return Value for the channel.
  */ 
 unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2628,10 +2633,11 @@ unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsig
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_BOOLEAN CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value to given data for a specified channel as an element of
+ * boolean type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \param[in] val Value for the channel.
  */ 
 void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
 {
@@ -2641,10 +2647,11 @@ void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx,
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value to given data for a specified channel as an element of
+ * integer type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \param[in] val Value for the channel.
  */ 
 void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
 {
@@ -2654,10 +2661,11 @@ void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx,
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER64 CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value to given data for a specified channel as an element of
+ * integer64 type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \param[in] val Value for the channel.
  */ 
 void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int idx, long long val)
 {
@@ -2667,10 +2675,12 @@ void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int id
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_ENUMERATED CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value to given data for a specified channel as an element of
+ * enumerated type.
+ * \param[in] obj Data of an element.
+ * \param[in] idx index of channel in the control element
+ * \param[in] val Value for the channel. This is an index of name set in the
+ * element.
  */ 
 void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned int val)
 {
@@ -2680,10 +2690,11 @@ void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int i
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value to given data for a specified channel as an element of
+ * bytes type.
+ * \param[in] obj Data of the element.
+ * \param[in] idx index of channel in the control element
+ * \param[in] val Value for the channel.
  */ 
 void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned char val)
 {
@@ -2693,10 +2704,10 @@ void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, un
 }
 
 /**
- * \brief Set CTL element #SND_CTL_ELEM_TYPE_BYTES value
- * \param obj CTL handle
- * \param data Bytes value
- * \param size Size in bytes
+ * \brief Set values to given data as an element of bytes type.
+ * \param[in] obj Data of the element.
+ * \param[in] data Pointer to memory block for values.
+ * \param[in] size The number of bytes included in the memory block.
  */
 void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size)
 {
@@ -2706,9 +2717,9 @@ void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size)
 }
 
 /**
- * \brief Get value for a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \return Pointer to CTL element value
+ * \brief Get memory block from given data as an element of bytes type.
+ * \param[in] obj Data of an element.
+ * \return Pointer to a memory block for values.
  */ 
 const void * snd_ctl_elem_value_get_bytes(const snd_ctl_elem_value_t *obj)
 {
@@ -2717,9 +2728,9 @@ const void * snd_ctl_elem_value_get_bytes(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Get value for a #SND_CTL_ELEM_TYPE_IEC958 CTL element id/value 
- * \param obj CTL element id/value
- * \param ptr Pointer to returned CTL element value
+ * Get value from given data to given pointer as an element of IEC958 type.
+ * \param[in] obj Data of an element.
+ * \param[out] ptr Pointer to an IEC958 data.
  */ 
 void snd_ctl_elem_value_get_iec958(const snd_ctl_elem_value_t *obj, snd_aes_iec958_t *ptr)
 {
@@ -2728,9 +2739,9 @@ void snd_ctl_elem_value_get_iec958(const snd_ctl_elem_value_t *obj, snd_aes_iec9
 }
 
 /**
- * \brief Set value for a #SND_CTL_ELEM_TYPE_IEC958 CTL element id/value 
- * \param obj CTL element id/value
- * \param ptr Pointer to CTL element value
+ * Set value from given pointer to given data as an element of IEC958 type.
+ * \param obj Data of an element.
+ * \param ptr Pointer to an IEC958 data.
  */ 
 void snd_ctl_elem_value_set_iec958(snd_ctl_elem_value_t *obj, const snd_aes_iec958_t *ptr)
 {
-- 
2.5.0
