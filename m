From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/6] control: rename variables so that it
	represents a channel in element
Date: Tue, 23 Feb 2016 09:48:28 +0900
Message-ID: <1456188510-7189-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 62154260686
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

In ALSA control core, an element has some channels which can be changed
by a single operation from userspace. Currently, control API uses 'idx'
to indicate the position of channel, while 'index' is also used to
identify an element in an element set. The usage of 'idx' for channel
is a bit confusing.

This commit replaces 'idx' with 'channel' to help userspace developers
to understand ALSA control interface.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     | 21 ++++++------
 src/control/control.c | 90 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/include/control.h b/include/control.h
index 5fdf379..12859f0 100644
--- a/include/control.h
+++ b/include/control.h
@@ -455,16 +455,17 @@ void snd_ctl_elem_value_set_device(snd_ctl_elem_value_t *obj, unsigned int val);
 void snd_ctl_elem_value_set_subdevice(snd_ctl_elem_value_t *obj, unsigned int val);
 void snd_ctl_elem_value_set_name(snd_ctl_elem_value_t *obj, const char *val);
 void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val);
-int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int idx);
-long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx);
-long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int idx);
-unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int idx);
-unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int idx);
-void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx, long val);
-void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx, long val);
-void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int idx, long long val);
-void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned int val);
-void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned char val);
+
+int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int channel);
+long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int channel);
+long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int channel);
+unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int channel);
+unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int channel);
+void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int channel, long val);
+void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int channel, long val);
+void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int channel, long long val);
+void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int channel, unsigned int val);
+void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int channel, unsigned char val);
 void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size);
 const void * snd_ctl_elem_value_get_bytes(const snd_ctl_elem_value_t *obj);
 void snd_ctl_elem_value_get_iec958(const snd_ctl_elem_value_t *obj, snd_aes_iec958_t *ptr);
diff --git a/src/control/control.c b/src/control/control.c
index 3ce14c2..69dbdc2 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2566,141 +2566,151 @@ void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val)
  * \brief Get value from given data for a specified channel as an element of
  * boolean type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \return Value for the channel.
  */ 
-int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int idx)
+int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj,
+				   unsigned int channel)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.integer.value));
-	return obj->value.integer.value[idx];
+	assert(channel < ARRAY_SIZE(obj->value.integer.value));
+	return obj->value.integer.value[channel];
 }
 
 /**
  * \brief Get value from given data for a specified channel as an element of
  * integer type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \return Value for the channel.
  */ 
-long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx)
+long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj,
+				    unsigned int channel)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.integer.value));
-	return obj->value.integer.value[idx];
+	assert(channel < ARRAY_SIZE(obj->value.integer.value));
+	return obj->value.integer.value[channel];
 }
 
 /**
  * \brief Get value from given data for a specified channel as an element of
  * integer64 type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \return Value for the channel.
  */ 
-long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int idx)
+long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj,
+					   unsigned int channel)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.integer64.value));
-	return obj->value.integer64.value[idx];
+	assert(channel < ARRAY_SIZE(obj->value.integer64.value));
+	return obj->value.integer64.value[channel];
 }
 
 /**
  * \brief Get value from given data for a specified channel as an element of
  * enumerated type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \return Value for the channel. This is an index of name set in the element.
  */ 
-unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int idx)
+unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj,
+					       unsigned int channel)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.enumerated.item));
-	return obj->value.enumerated.item[idx];
+	assert(channel < ARRAY_SIZE(obj->value.enumerated.item));
+	return obj->value.enumerated.item[channel];
 }
 
 /**
  * \brief Get value from given data for a specified channel as an element of
  * bytes type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \return Value for the channel.
  */ 
-unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int idx)
+unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj,
+					  unsigned int channel)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.bytes.data));
-	return obj->value.bytes.data[idx];
+	assert(channel < ARRAY_SIZE(obj->value.bytes.data));
+	return obj->value.bytes.data[channel];
 }
 
 /**
  * \brief Set value to given data for a specified channel as an element of
  * boolean type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \param[in] val Value for the channel.
  */ 
-void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
+void snd_ctl_elem_value_set_boolean(snd_ctl_elem_value_t *obj,
+				    unsigned int channel, long val)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.integer.value));
-	obj->value.integer.value[idx] = val;
+	assert(channel < ARRAY_SIZE(obj->value.integer.value));
+	obj->value.integer.value[channel] = val;
 }
 
 /**
  * \brief Set value to given data for a specified channel as an element of
  * integer type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \param[in] val Value for the channel.
  */ 
-void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj, unsigned int idx, long val)
+void snd_ctl_elem_value_set_integer(snd_ctl_elem_value_t *obj,
+				    unsigned int channel, long val)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.integer.value));
-	obj->value.integer.value[idx] = val;
+	assert(channel < ARRAY_SIZE(obj->value.integer.value));
+	obj->value.integer.value[channel] = val;
 }
 
 /**
  * \brief Set value to given data for a specified channel as an element of
  * integer64 type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \param[in] val Value for the channel.
  */ 
-void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj, unsigned int idx, long long val)
+void snd_ctl_elem_value_set_integer64(snd_ctl_elem_value_t *obj,
+				      unsigned int channel, long long val)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.integer64.value));
-	obj->value.integer64.value[idx] = val;
+	assert(channel < ARRAY_SIZE(obj->value.integer64.value));
+	obj->value.integer64.value[channel] = val;
 }
 
 /**
  * \brief Set value to given data for a specified channel as an element of
  * enumerated type.
  * \param[in] obj Data of an element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \param[in] val Value for the channel. This is an index of name set in the
  * element.
  */ 
-void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned int val)
+void snd_ctl_elem_value_set_enumerated(snd_ctl_elem_value_t *obj,
+				       unsigned int channel, unsigned int val)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.enumerated.item));
-	obj->value.enumerated.item[idx] = val;
+	assert(channel < ARRAY_SIZE(obj->value.enumerated.item));
+	obj->value.enumerated.item[channel] = val;
 }
 
 /**
  * \brief Set value to given data for a specified channel as an element of
  * bytes type.
  * \param[in] obj Data of the element.
- * \param[in] idx index of channel in the control element
+ * \param[in] channel Channel in the element.
  * \param[in] val Value for the channel.
  */ 
-void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, unsigned char val)
+void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj,
+				 unsigned int channel, unsigned char val)
 {
 	assert(obj);
-	assert(idx < ARRAY_SIZE(obj->value.bytes.data));
-	obj->value.bytes.data[idx] = val;
+	assert(channel < ARRAY_SIZE(obj->value.bytes.data));
+	obj->value.bytes.data[channel] = val;
 }
 
 /**
-- 
2.5.0
