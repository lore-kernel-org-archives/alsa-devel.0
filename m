From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/9] ctl: improve comments for handling element
	data
Date: Wed, 15 Jun 2016 23:57:38 +0900
Message-ID: <1466002665-30048-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id B50222668A2
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:51 +0200 (CEST)
In-Reply-To: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
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

Some parts of control API documentation are described with core-developer
friendly explanations. To usual developer such as me, they're quite hard
to understand.

This commit improves such comments for a part of APIs to handle data of
each element.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 246 +++++++++++++++++++++++++++-----------------------
 1 file changed, 131 insertions(+), 115 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 504da1f..7d1e412 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -482,7 +482,7 @@ int snd_ctl_elem_remove(snd_ctl_t *ctl, snd_ctl_elem_id_t *id)
 /**
  * \brief Get CTL element value
  * \param ctl CTL handle
- * \param control CTL element id/value pointer
+ * \param obj Data of an element.
  * \return 0 on success otherwise a negative error code
  */
 int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *control)
@@ -494,7 +494,7 @@ int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *control)
 /**
  * \brief Set CTL element value
  * \param ctl CTL handle
- * \param control CTL element id/value pointer
+ * \param obj Data of an element.
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
@@ -2295,8 +2295,8 @@ void snd_ctl_elem_info_set_index(snd_ctl_elem_info_t *obj, unsigned int val)
 }
 
 /**
- * \brief get size of #snd_ctl_elem_value_t
- * \return size in bytes
+ * \brief Get size of data structure for an element.
+ * \return Size in bytes.
  */
 size_t snd_ctl_elem_value_sizeof()
 {
@@ -2304,9 +2304,9 @@ size_t snd_ctl_elem_value_sizeof()
 }
 
 /**
- * \brief allocate an invalid #snd_ctl_elem_value_t using standard malloc
- * \param ptr returned pointer
- * \return 0 on success otherwise negative error code
+ * \brief Allocate an invalid #snd_ctl_elem_value_t using standard malloc(3).
+ * \param ptr Returned pointer for data of an element.
+ * \return 0 on success otherwise negative error code.
  */
 int snd_ctl_elem_value_malloc(snd_ctl_elem_value_t **ptr)
 {
@@ -2318,8 +2318,8 @@ int snd_ctl_elem_value_malloc(snd_ctl_elem_value_t **ptr)
 }
 
 /**
- * \brief frees a previously allocated #snd_ctl_elem_value_t
- * \param obj pointer to object to free
+ * \brief Frees a previously allocated data of an element.
+ * \param obj Data of an element.
  */
 void snd_ctl_elem_value_free(snd_ctl_elem_value_t *obj)
 {
@@ -2327,8 +2327,8 @@ void snd_ctl_elem_value_free(snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief clear given #snd_ctl_elem_value_t object
- * \param obj pointer to object to clear
+ * \brief Clear given data of an element.
+ * \param obj Data of an element.
  */
 void snd_ctl_elem_value_clear(snd_ctl_elem_value_t *obj)
 {
@@ -2336,32 +2336,34 @@ void snd_ctl_elem_value_clear(snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief copy one #snd_ctl_elem_value_t to another
- * \param dst pointer to destination
- * \param src pointer to source
+ * \brief Copy two data of elements.
+ * \param dst Pointer to destination.
+ * \param src Pointer to source.
  */
-void snd_ctl_elem_value_copy(snd_ctl_elem_value_t *dst, const snd_ctl_elem_value_t *src)
+void snd_ctl_elem_value_copy(snd_ctl_elem_value_t *dst,
+			     const snd_ctl_elem_value_t *src)
 {
 	assert(dst && src);
 	*dst = *src;
 }
 
 /**
- * \brief compare one #snd_ctl_elem_value_t to another
- * \param left pointer to first value
- * \param right pointer to second value
- * \return 0 on match, less than or greater than otherwise, see memcmp
+ * \brief Compare one data of an element to the other.
+ * \param left Pointer to first data.
+ * \param right Pointer to second data.
+ * \return 0 on match, less than or greater than otherwise, see memcmp(3).
  */
-int snd_ctl_elem_value_compare(snd_ctl_elem_value_t *left, const snd_ctl_elem_value_t *right)
+int snd_ctl_elem_value_compare(snd_ctl_elem_value_t *left,
+			       const snd_ctl_elem_value_t *right)
 {
 	assert(left && right);
 	return memcmp(left, right, sizeof(*left));
 }
 
 /**
- * \brief Get CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param ptr Pointer to returned CTL element identifier
+ * \brief Get element identifier from given data of an element.
+ * \param obj Data of an element.
+ * \param ptr Pointer for element identifier.
  */
 void snd_ctl_elem_value_get_id(const snd_ctl_elem_value_t *obj, snd_ctl_elem_id_t *ptr)
 {
@@ -2370,9 +2372,9 @@ void snd_ctl_elem_value_get_id(const snd_ctl_elem_value_t *obj, snd_ctl_elem_id_
 }
 
 /**
- * \brief Get element numeric identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \return element numeric identifier
+ * \brief Get element numeric identifier from given data of an element.
+ * \param obj Data of an element.
+ * \return Element numeric identifier.
  */
 unsigned int snd_ctl_elem_value_get_numid(const snd_ctl_elem_value_t *obj)
 {
@@ -2381,9 +2383,10 @@ unsigned int snd_ctl_elem_value_get_numid(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Get interface part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \return interface part of element identifier
+ * \brief Get interface part of element identifier from given data of an
+ *	  element.
+ * \param obj Data of an element.
+ * \return Interface part of element identifier.
  */
 snd_ctl_elem_iface_t snd_ctl_elem_value_get_interface(const snd_ctl_elem_value_t *obj)
 {
@@ -2392,9 +2395,9 @@ snd_ctl_elem_iface_t snd_ctl_elem_value_get_interface(const snd_ctl_elem_value_t
 }
 
 /**
- * \brief Get device part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \return device part of element identifier
+ * \brief Get device part of element identifier from given data of an element.
+ * \param obj Data of an element.
+ * \return Device part of element identifier.
  */
 unsigned int snd_ctl_elem_value_get_device(const snd_ctl_elem_value_t *obj)
 {
@@ -2403,9 +2406,10 @@ unsigned int snd_ctl_elem_value_get_device(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Get subdevice part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \return subdevice part of element identifier
+ * \brief Get subdevice part of element identifier from given data of an
+ *	  element.
+ * \param obj Data of an element.
+ * \return Subdevice part of element identifier.
  */
 unsigned int snd_ctl_elem_value_get_subdevice(const snd_ctl_elem_value_t *obj)
 {
@@ -2414,9 +2418,9 @@ unsigned int snd_ctl_elem_value_get_subdevice(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Get name part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \return name part of element identifier
+ * \brief Get name part of element identifier from given data of an element.
+ * \param obj Data of an element.
+ * \return Name part of element identifier.
  */
 const char *snd_ctl_elem_value_get_name(const snd_ctl_elem_value_t *obj)
 {
@@ -2425,9 +2429,9 @@ const char *snd_ctl_elem_value_get_name(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Get index part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \return index part of element identifier
+ * \brief Get index part of element identifier from given data of an element.
+ * \param obj Data of an element.
+ * \return Index part of element identifier.
  */
 unsigned int snd_ctl_elem_value_get_index(const snd_ctl_elem_value_t *obj)
 {
@@ -2436,9 +2440,9 @@ unsigned int snd_ctl_elem_value_get_index(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Set CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param ptr CTL element identifier
+ * \brief Set element identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param ptr Pointer to an element identifier.
  */
 void snd_ctl_elem_value_set_id(snd_ctl_elem_value_t *obj, const snd_ctl_elem_id_t *ptr)
 {
@@ -2447,9 +2451,9 @@ void snd_ctl_elem_value_set_id(snd_ctl_elem_value_t *obj, const snd_ctl_elem_id_
 }
 
 /**
- * \brief Set element numeric identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param val element numeric identifier
+ * \brief Set numeric identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param val Value for numeric identifier.
  */
 void snd_ctl_elem_value_set_numid(snd_ctl_elem_value_t *obj, unsigned int val)
 {
@@ -2458,9 +2462,9 @@ void snd_ctl_elem_value_set_numid(snd_ctl_elem_value_t *obj, unsigned int val)
 }
 
 /**
- * \brief Set interface part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param val interface part of element identifier
+ * \brief Set interface part of element identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param val Value for interface part of element identifier.
  */
 void snd_ctl_elem_value_set_interface(snd_ctl_elem_value_t *obj, snd_ctl_elem_iface_t val)
 {
@@ -2469,9 +2473,9 @@ void snd_ctl_elem_value_set_interface(snd_ctl_elem_value_t *obj, snd_ctl_elem_if
 }
 
 /**
- * \brief Set device part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param val device part of element identifier
+ * \brief Set device part of element identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param val Value for device part of element identifier.
  */
 void snd_ctl_elem_value_set_device(snd_ctl_elem_value_t *obj, unsigned int val)
 {
@@ -2480,9 +2484,9 @@ void snd_ctl_elem_value_set_device(snd_ctl_elem_value_t *obj, unsigned int val)
 }
 
 /**
- * \brief Set subdevice part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param val subdevice part of element identifier
+ * \brief Set subdevice part of element identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param val Value for subdevice part of element identifier.
  */
 void snd_ctl_elem_value_set_subdevice(snd_ctl_elem_value_t *obj, unsigned int val)
 {
@@ -2491,9 +2495,9 @@ void snd_ctl_elem_value_set_subdevice(snd_ctl_elem_value_t *obj, unsigned int va
 }
 
 /**
- * \brief Set name part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param val name part of element identifier
+ * \brief Set name part of element identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param val Value for name part of element identifier,
  */
 void snd_ctl_elem_value_set_name(snd_ctl_elem_value_t *obj, const char *val)
 {
@@ -2502,9 +2506,9 @@ void snd_ctl_elem_value_set_name(snd_ctl_elem_value_t *obj, const char *val)
 }
 
 /**
- * \brief Set index part of CTL element identifier of a CTL element id/value
- * \param obj CTL element id/value
- * \param val index part of element identifier
+ * \brief Set index part of element identifier to given data of an element.
+ * \param obj Data of an element.
+ * \param val Value for index part of element identifier.
  */
 void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val)
 {
@@ -2513,10 +2517,11 @@ void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val)
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_BOOLEAN CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified member from given data as an element of
+ *	  boolean type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \return Value for the member.
  */ 
 int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2526,10 +2531,11 @@ int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified member from given data as an element of
+ *	  integer type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \return Value for the member.
  */ 
 long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2539,10 +2545,11 @@ long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned in
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER64 CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified member from given data as an element of
+ *	  integer64 type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \return Value for the member.
  */ 
 long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2552,10 +2559,11 @@ long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsi
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_ENUMERATED CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified member from given data as an element of
+ *	  enumerated type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \return Value for the member. This is an index of name set in the element.
  */ 
 unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2565,10 +2573,11 @@ unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj,
 }
 
 /**
- * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \return value for the entry
+ * \brief Get value of a specified member from given data as an element of
+ *	  bytes type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \return Value for the member.
  */ 
 unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int idx)
 {
@@ -2578,10 +2587,11 @@ unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsig
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_BOOLEAN CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified member to given data as an element of
+ *	  boolean type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \param val Value for the member.
  */ 
 void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
 {
@@ -2591,10 +2601,11 @@ void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx,
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified member to given data as an element of
+ *	  integer type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \param val Value for the member.
  */ 
 void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
 {
@@ -2604,10 +2615,11 @@ void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx,
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER64 CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified member to given data as an element of
+ *	  integer64 type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \param val Value for the member.
  */ 
 void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int idx, long long val)
 {
@@ -2617,10 +2629,11 @@ void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int id
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_ENUMERATED CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value of a specified member to given data as an element of
+ * 	  enumerated type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \param val Value for the member.
  */ 
 void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned int val)
 {
@@ -2630,10 +2643,11 @@ void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int i
 }
 
 /**
- * \brief Set value for an entry of a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \param idx Entry index
- * \param val value for the entry
+ * \brief Set value for a specified member to given data as an element of byte
+ *	  type.
+ * \param obj Data of an element.
+ * \param idx Index of member in the element.
+ * \param val Value for the member.
  */ 
 void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned char val)
 {
@@ -2643,10 +2657,10 @@ void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, un
 }
 
 /**
- * \brief Set CTL element #SND_CTL_ELEM_TYPE_BYTES value
- * \param obj CTL handle
- * \param data Bytes value
- * \param size Size in bytes
+ * \brief Set values to given data as an element of bytes type.
+ * \param obj Data of an element.
+ * \param data Pointer for byte array.
+ * \param size The number of bytes included in the memory block.
  */
 void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size)
 {
@@ -2656,9 +2670,9 @@ void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size)
 }
 
 /**
- * \brief Get value for a #SND_CTL_ELEM_TYPE_BYTES CTL element id/value 
- * \param obj CTL element id/value
- * \return Pointer to CTL element value
+ * \brief Get memory block from given data as an element of bytes type.
+ * \param obj Data of an element.
+ * \return Pointer for byte array.
  */ 
 const void * snd_ctl_elem_value_get_bytes(const snd_ctl_elem_value_t *obj)
 {
@@ -2667,9 +2681,10 @@ const void * snd_ctl_elem_value_get_bytes(const snd_ctl_elem_value_t *obj)
 }
 
 /**
- * \brief Get value for a #SND_CTL_ELEM_TYPE_IEC958 CTL element id/value 
- * \param obj CTL element id/value
- * \param ptr Pointer to returned CTL element value
+ * \brief Get value from given data to given pointer as an element of IEC958
+ *	  type.
+ * \param obj Data of an element.
+ * \param ptr Pointer to IEC958 data.
  */ 
 void snd_ctl_elem_value_get_iec958(const snd_ctl_elem_value_t *obj, snd_aes_iec958_t *ptr)
 {
@@ -2678,9 +2693,10 @@ void snd_ctl_elem_value_get_iec958(const snd_ctl_elem_value_t *obj, snd_aes_iec9
 }
 
 /**
- * \brief Set value for a #SND_CTL_ELEM_TYPE_IEC958 CTL element id/value 
- * \param obj CTL element id/value
- * \param ptr Pointer to CTL element value
+ * \brief Set value from given pointer to given data as an element of IEC958
+ *	  type.
+ * \param obj Data of an element.
+ * \param ptr Pointer to IEC958 data.
  */ 
 void snd_ctl_elem_value_set_iec958(snd_ctl_elem_value_t *obj, const snd_aes_iec958_t *ptr)
 {
-- 
2.7.4
