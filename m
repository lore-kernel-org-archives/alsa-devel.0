From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: sigmadsp: Add support for fw v2
Date: Wed, 19 Nov 2014 18:29:06 +0100
Message-ID: <1416418148-14803-5-git-send-email-lars@metafoo.de>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-042.synserver.de (smtp-out-042.synserver.de
 [212.40.185.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D1EF26067C
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 18:29:13 +0100 (CET)
In-Reply-To: <1416418148-14803-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds support for the v2 version of the SigmaDSP firmware file
format. The new format has support for having different program and
parameter settings for different samplerates. In addition it stores metadata
describing the firmware. This metadata includes the set of supported
samplerates which will be used to restrict the samplerates that can be
selected by userspace. Also included is information about the modifiable
parameters. Those will be exposed as ALSA controls so they can be changed at
runtime.

The new format is based on a binary type-length-value structure that makes
it both forward and backwards compatible.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sigmadsp-i2c.c    |  29 +++
 sound/soc/codecs/sigmadsp-regmap.c |   8 +
 sound/soc/codecs/sigmadsp.c        | 463 ++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/sigmadsp.h        |   6 +
 4 files changed, 504 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp-i2c.c b/sound/soc/codecs/sigmadsp-i2c.c
index bf6a2be..21ca3a5 100644
--- a/sound/soc/codecs/sigmadsp-i2c.c
+++ b/sound/soc/codecs/sigmadsp-i2c.c
@@ -34,6 +34,34 @@ static int sigmadsp_write_i2c(void *control_data,
 	return ret;
 }
 
+static int sigmadsp_read_i2c(void *control_data,
+	unsigned int addr, uint8_t data[], size_t len)
+{
+	struct i2c_client *client = control_data;
+	struct i2c_msg msgs[2];
+	uint8_t buf[2];
+	int ret;
+
+	put_unaligned_be16(addr, buf);
+
+	msgs[0].addr = client->addr;
+	msgs[0].len = sizeof(buf);
+	msgs[0].buf = buf;
+	msgs[0].flags = 0;
+
+	msgs[1].addr = client->addr;
+	msgs[1].len = len;
+	msgs[1].buf = data;
+	msgs[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	else if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+	return 0;
+}
+
 /**
  * devm_sigmadsp_init_i2c() - Initialize SigmaDSP instance
  * @client: The parent I2C device
@@ -55,6 +83,7 @@ struct sigmadsp *devm_sigmadsp_init_i2c(struct i2c_client *client,
 
 	sigmadsp->control_data = client;
 	sigmadsp->write = sigmadsp_write_i2c;
+	sigmadsp->read = sigmadsp_read_i2c;
 
 	return sigmadsp;
 }
diff --git a/sound/soc/codecs/sigmadsp-regmap.c b/sound/soc/codecs/sigmadsp-regmap.c
index cdc5dda..912861b 100644
--- a/sound/soc/codecs/sigmadsp-regmap.c
+++ b/sound/soc/codecs/sigmadsp-regmap.c
@@ -19,6 +19,13 @@ static int sigmadsp_write_regmap(void *control_data,
 		data, len);
 }
 
+static int sigmadsp_read_regmap(void *control_data,
+	unsigned int addr, uint8_t data[], size_t len)
+{
+	return regmap_raw_read(control_data, addr,
+		data, len);
+}
+
 /**
  * devm_sigmadsp_init_i2c() - Initialize SigmaDSP instance
  * @dev: The parent device
@@ -42,6 +49,7 @@ struct sigmadsp *devm_sigmadsp_init_regmap(struct device *dev,
 
 	sigmadsp->control_data = regmap;
 	sigmadsp->write = sigmadsp_write_regmap;
+	sigmadsp->read = sigmadsp_read_regmap;
 
 	return sigmadsp;
 }
diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 34e63b5..55af596 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -14,19 +14,61 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <sound/control.h>
 #include <sound/soc.h>
 
 #include "sigmadsp.h"
 
 #define SIGMA_MAGIC "ADISIGM"
 
+#define SIGMA_FW_CHUNK_TYPE_DATA 0
+#define SIGMA_FW_CHUNK_TYPE_CONTROL 1
+#define SIGMA_FW_CHUNK_TYPE_SAMPLERATES 2
+
+struct sigmadsp_control {
+	struct list_head head;
+	uint32_t samplerates;
+	unsigned int addr;
+	unsigned int num_bytes;
+	const char *name;
+	struct snd_kcontrol *kcontrol;
+	bool cached;
+	uint8_t cache[];
+};
+
 struct sigmadsp_data {
 	struct list_head head;
+	uint32_t samplerates;
 	unsigned int addr;
 	unsigned int length;
 	uint8_t data[];
 };
 
+struct sigma_fw_chunk {
+	__le32 length;
+	__le32 tag;
+	__le32 samplerates;
+} __packed;
+
+struct sigma_fw_chunk_data {
+	struct sigma_fw_chunk chunk;
+	__le16 addr;
+	uint8_t data[];
+} __packed;
+
+struct sigma_fw_chunk_control {
+	struct sigma_fw_chunk chunk;
+	__le16 type;
+	__le16 addr;
+	__le16 num_bytes;
+	const char name[];
+} __packed;
+
+struct sigma_fw_chunk_samplerate {
+	struct sigma_fw_chunk chunk;
+	__le32 samplerates[];
+} __packed;
+
 struct sigma_firmware_header {
 	unsigned char magic[7];
 	u8 version;
@@ -54,6 +96,269 @@ static int sigmadsp_write(struct sigmadsp *sigmadsp, unsigned int addr,
 	return sigmadsp->write(sigmadsp->control_data, addr, data, len);
 }
 
+static int sigmadsp_read(struct sigmadsp *sigmadsp, unsigned int addr,
+	uint8_t data[], size_t len)
+{
+	return sigmadsp->read(sigmadsp->control_data, addr, data, len);
+}
+
+static int sigmadsp_ctrl_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *info)
+{
+	struct sigmadsp_control *ctrl = (void *)kcontrol->private_value;
+
+	info->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	info->count = ctrl->num_bytes;
+
+	return 0;
+}
+
+static int sigmadsp_ctrl_write(struct sigmadsp *sigmadsp,
+	struct sigmadsp_control *ctrl, void *data)
+{
+	/* safeload loads up to 20 bytes in a atomic operation */
+	if (ctrl->num_bytes > 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
+	    sigmadsp->ops->safeload)
+		return sigmadsp->ops->safeload(sigmadsp, ctrl->addr, data,
+			ctrl->num_bytes);
+	else
+		return sigmadsp_write(sigmadsp, ctrl->addr, data,
+			ctrl->num_bytes);
+}
+
+static int sigmadsp_ctrl_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct sigmadsp_control *ctrl = (void *)kcontrol->private_value;
+	struct sigmadsp *sigmadsp = snd_kcontrol_chip(kcontrol);
+	uint8_t *data;
+	int ret = 0;
+
+	mutex_lock(&sigmadsp->lock);
+
+	data = ucontrol->value.bytes.data;
+
+	if (!(kcontrol->vd[0].access & SNDRV_CTL_ELEM_ACCESS_INACTIVE))
+		ret = sigmadsp_ctrl_write(sigmadsp, ctrl, data);
+
+	if (ret == 0) {
+		memcpy(ctrl->cache, data, ctrl->num_bytes);
+		ctrl->cached = true;
+	}
+
+	mutex_unlock(&sigmadsp->lock);
+
+	return ret;
+}
+
+static int sigmadsp_ctrl_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct sigmadsp_control *ctrl = (void *)kcontrol->private_value;
+	struct sigmadsp *sigmadsp = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	mutex_lock(&sigmadsp->lock);
+
+	if (!ctrl->cached) {
+		ret = sigmadsp_read(sigmadsp, ctrl->addr, ctrl->cache,
+			ctrl->num_bytes);
+	}
+
+	if (ret == 0) {
+		ctrl->cached = true;
+		memcpy(ucontrol->value.bytes.data, ctrl->cache,
+			ctrl->num_bytes);
+	}
+
+	mutex_unlock(&sigmadsp->lock);
+
+	return ret;
+}
+
+static void sigmadsp_control_free(struct snd_kcontrol *kcontrol)
+{
+	struct sigmadsp_control *ctrl = (void *)kcontrol->private_value;
+
+	ctrl->kcontrol = NULL;
+}
+
+static bool sigma_fw_validate_control_name(const char *name, unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++) {
+		/* Normal ASCII characters are valid */
+		if (name[i] < ' ' || name[i] > '~')
+			return false;
+	}
+
+	return true;
+}
+
+static int sigma_fw_load_control(struct sigmadsp *sigmadsp,
+	const struct sigma_fw_chunk *chunk, unsigned int length)
+{
+	const struct sigma_fw_chunk_control *ctrl_chunk;
+	struct sigmadsp_control *ctrl;
+	unsigned int num_bytes;
+	size_t name_len;
+	char *name;
+	int ret;
+
+	if (length <= sizeof(*ctrl_chunk))
+		return -EINVAL;
+
+	ctrl_chunk = (const struct sigma_fw_chunk_control *)chunk;
+
+	name_len = length - sizeof(*ctrl_chunk);
+	if (name_len >= SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+		name_len = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1;
+
+	/* Make sure there are no non-displayable characaters in the string */
+	if (!sigma_fw_validate_control_name(ctrl_chunk->name, name_len))
+		return -EINVAL;
+
+	num_bytes = le16_to_cpu(ctrl_chunk->num_bytes);
+	ctrl = kzalloc(sizeof(*ctrl) + num_bytes, GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	name = kzalloc(name_len + 1, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto err_free_ctrl;
+	}
+	memcpy(name, ctrl_chunk->name, name_len);
+	name[name_len] = '\0';
+	ctrl->name = name;
+
+	ctrl->addr = le16_to_cpu(ctrl_chunk->addr);
+	ctrl->num_bytes = num_bytes;
+	ctrl->samplerates = chunk->samplerates;
+
+	list_add_tail(&ctrl->head, &sigmadsp->ctrl_list);
+
+	return 0;
+
+err_free_ctrl:
+	kfree(ctrl);
+
+	return ret;
+}
+
+static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
+	const struct sigma_fw_chunk *chunk, unsigned int length)
+{
+	const struct sigma_fw_chunk_data *data_chunk;
+	struct sigmadsp_data *data;
+
+	if (length <= sizeof(*data_chunk))
+		return -EINVAL;
+
+	data_chunk = (struct sigma_fw_chunk_data *)chunk;
+
+	length -= sizeof(*data_chunk);
+
+	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->addr = le16_to_cpu(data_chunk->addr);
+	data->length = length;
+	data->samplerates = chunk->samplerates;
+	memcpy(data->data, data_chunk->data, length);
+	list_add_tail(&data->head, &sigmadsp->data_list);
+
+	return 0;
+}
+
+static int sigma_fw_load_samplerates(struct sigmadsp *sigmadsp,
+	const struct sigma_fw_chunk *chunk, unsigned int length)
+{
+	const struct sigma_fw_chunk_samplerate *rate_chunk;
+	unsigned int num_rates;
+	unsigned int *rates;
+	unsigned int i;
+
+	rate_chunk = (const struct sigma_fw_chunk_samplerate *)chunk;
+
+	num_rates = (length - sizeof(*rate_chunk)) / sizeof(__le32);
+
+	if (num_rates > 32 || num_rates == 0)
+		return -EINVAL;
+
+	/* We only allow one samplerates block per file */
+	if (sigmadsp->rate_constraints.count)
+		return -EINVAL;
+
+	rates = kcalloc(num_rates, sizeof(*rates), GFP_KERNEL);
+	if (!rates)
+		return -ENOMEM;
+
+	for (i = 0; i < num_rates; i++)
+		rates[i] = le32_to_cpu(rate_chunk->samplerates[i]);
+
+	sigmadsp->rate_constraints.count = num_rates;
+	sigmadsp->rate_constraints.list = rates;
+
+	return 0;
+}
+
+static int sigmadsp_fw_load_v2(struct sigmadsp *sigmadsp,
+	const struct firmware *fw)
+{
+	struct sigma_fw_chunk *chunk;
+	unsigned int length, pos;
+	int ret;
+
+	/*
+	 * Make sure that there is at least one chunk to avoid integer
+	 * underflows later on. Empty firmware is still valid though.
+	 */
+	if (fw->size < sizeof(*chunk) + sizeof(struct sigma_firmware_header))
+		return 0;
+
+	pos = sizeof(struct sigma_firmware_header);
+
+	while (pos < fw->size - sizeof(*chunk)) {
+		chunk = (struct sigma_fw_chunk *)(fw->data + pos);
+
+		length = le32_to_cpu(chunk->length);
+
+		if (length > fw->size - pos || length < sizeof(*chunk))
+			return -EINVAL;
+
+		switch (chunk->tag) {
+		case SIGMA_FW_CHUNK_TYPE_DATA:
+			ret = sigma_fw_load_data(sigmadsp, chunk, length);
+			break;
+		case SIGMA_FW_CHUNK_TYPE_CONTROL:
+			ret = sigma_fw_load_control(sigmadsp, chunk, length);
+			break;
+		case SIGMA_FW_CHUNK_TYPE_SAMPLERATES:
+			ret = sigma_fw_load_samplerates(sigmadsp, chunk, length);
+			break;
+		default:
+			dev_warn(sigmadsp->dev, "Unknown chunk type: %d\n",
+				chunk->tag);
+			ret = 0;
+			break;
+		}
+
+		if (ret)
+			return ret;
+
+		/*
+		 * This can not overflow since if length is larger than the
+		 * maximum firmware size (0x4000000) we'll error out earilier.
+		 */
+		pos += ALIGN(length, sizeof(__le32));
+	}
+
+	return 0;
+}
+
 static inline u32 sigma_action_len(struct sigma_action *sa)
 {
 	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
@@ -149,11 +454,18 @@ static int sigmadsp_fw_load_v1(struct sigmadsp *sigmadsp,
 
 static void sigmadsp_firmware_release(struct sigmadsp *sigmadsp)
 {
+	struct sigmadsp_control *ctrl, *_ctrl;
 	struct sigmadsp_data *data, *_data;
 
+	list_for_each_entry_safe(ctrl, _ctrl, &sigmadsp->ctrl_list, head) {
+		kfree(ctrl->name);
+		kfree(ctrl);
+	}
+
 	list_for_each_entry_safe(data, _data, &sigmadsp->data_list, head)
 		kfree(data);
 
+	INIT_LIST_HEAD(&sigmadsp->ctrl_list);
 	INIT_LIST_HEAD(&sigmadsp->data_list);
 }
 
@@ -209,9 +521,12 @@ static int sigmadsp_firmware_load(struct sigmadsp *sigmadsp, const char *name)
 	case 1:
 		ret = sigmadsp_fw_load_v1(sigmadsp, fw);
 		break;
+	case 2:
+		ret = sigmadsp_fw_load_v2(sigmadsp, fw);
+		break;
 	default:
 		dev_err(sigmadsp->dev,
-			"Failed to load firmware: Invalid version %d. Supported firmware versions: 1\n",
+			"Failed to load firmware: Invalid version %d. Supported firmware versions: 1, 2\n",
 			ssfw_head->version);
 		ret = -EINVAL;
 		break;
@@ -232,7 +547,9 @@ static int sigmadsp_init(struct sigmadsp *sigmadsp, struct device *dev,
 	sigmadsp->ops = ops;
 	sigmadsp->dev = dev;
 
+	INIT_LIST_HEAD(&sigmadsp->ctrl_list);
 	INIT_LIST_HEAD(&sigmadsp->data_list);
+	mutex_init(&sigmadsp->lock);
 
 	return sigmadsp_firmware_load(sigmadsp, firmware_name);
 }
@@ -270,6 +587,114 @@ struct sigmadsp *devm_sigmadsp_init(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_sigmadsp_init);
 
+static int sigmadsp_rate_to_index(struct sigmadsp *sigmadsp, unsigned int rate)
+{
+	unsigned int i;
+
+	for (i = 0; i < sigmadsp->rate_constraints.count; i++) {
+		if (sigmadsp->rate_constraints.list[i] == rate)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static unsigned int sigmadsp_get_samplerate_mask(struct sigmadsp *sigmadsp,
+	unsigned int samplerate)
+{
+	int samplerate_index;
+
+	if (samplerate == 0)
+		return 0;
+
+	if (sigmadsp->rate_constraints.count) {
+		samplerate_index = sigmadsp_rate_to_index(sigmadsp, samplerate);
+		if (samplerate_index < 0)
+			return 0;
+
+		return BIT(samplerate_index);
+	} else {
+		return ~0;
+	}
+}
+
+static bool sigmadsp_samplerate_valid(unsigned int supported,
+	unsigned int requested)
+{
+	/* All samplerates are supported */
+	if (!supported)
+		return true;
+
+	return supported & requested;
+}
+
+static int sigmadsp_alloc_control(struct sigmadsp *sigmadsp,
+	struct sigmadsp_control *ctrl, unsigned int samplerate_mask)
+{
+	struct snd_kcontrol_new template;
+	struct snd_kcontrol *kcontrol;
+	int ret;
+
+	memset(&template, 0, sizeof(template));
+	template.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	template.name = ctrl->name;
+	template.info = sigmadsp_ctrl_info;
+	template.get = sigmadsp_ctrl_get;
+	template.put = sigmadsp_ctrl_put;
+	template.private_value = (unsigned long)ctrl;
+	template.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	if (!sigmadsp_samplerate_valid(ctrl->samplerates, samplerate_mask))
+		template.access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+
+	kcontrol = snd_ctl_new1(&template, sigmadsp);
+	if (!kcontrol)
+		return -ENOMEM;
+
+	kcontrol->private_free = sigmadsp_control_free;
+	ctrl->kcontrol = kcontrol;
+
+	ret = snd_ctl_add(sigmadsp->component->card->snd_card, kcontrol);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void sigmadsp_activate_ctrl(struct sigmadsp *sigmadsp,
+	struct sigmadsp_control *ctrl, unsigned int samplerate_mask)
+{
+	struct snd_card *card = sigmadsp->component->card->snd_card;
+	struct snd_kcontrol_volatile *vd;
+	struct snd_ctl_elem_id id;
+	bool active, changed;
+
+	active = sigmadsp_samplerate_valid(ctrl->samplerates, samplerate_mask);
+
+	down_write(&card->controls_rwsem);
+	if (!ctrl->kcontrol) {
+		up_write(&card->controls_rwsem);
+		return;
+	}
+
+	id = ctrl->kcontrol->id;
+	vd = &ctrl->kcontrol->vd[0];
+	if (active == (bool)(vd->access & SNDRV_CTL_ELEM_ACCESS_INACTIVE)) {
+		vd->access ^= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+		changed = true;
+	}
+	up_write(&card->controls_rwsem);
+
+	if (active && changed) {
+		mutex_lock(&sigmadsp->lock);
+		if (ctrl->cached)
+			sigmadsp_ctrl_write(sigmadsp, ctrl, ctrl->cache);
+		mutex_unlock(&sigmadsp->lock);
+	}
+
+	if (changed)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &id);
+}
+
 /**
  * sigmadsp_attach() - Attach a sigmadsp instance to a ASoC component
  * @sigmadsp: The sigmadsp instance to attach
@@ -284,8 +709,21 @@ EXPORT_SYMBOL_GPL(devm_sigmadsp_init);
 int sigmadsp_attach(struct sigmadsp *sigmadsp,
 	struct snd_soc_component *component)
 {
+	struct sigmadsp_control *ctrl;
+	unsigned int samplerate_mask;
+	int ret;
+
 	sigmadsp->component = component;
 
+	samplerate_mask = sigmadsp_get_samplerate_mask(sigmadsp,
+		sigmadsp->current_samplerate);
+
+	list_for_each_entry(ctrl, &sigmadsp->ctrl_list, head) {
+		ret = sigmadsp_alloc_control(sigmadsp, ctrl, samplerate_mask);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sigmadsp_attach);
@@ -303,19 +741,31 @@ EXPORT_SYMBOL_GPL(sigmadsp_attach);
  */
 int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int samplerate)
 {
+	struct sigmadsp_control *ctrl;
+	unsigned int samplerate_mask;
 	struct sigmadsp_data *data;
 	int ret;
 
 	if (sigmadsp->current_samplerate == samplerate)
 		return 0;
 
+	samplerate_mask = sigmadsp_get_samplerate_mask(sigmadsp, samplerate);
+	if (samplerate_mask == 0)
+		return -EINVAL;
+
 	list_for_each_entry(data, &sigmadsp->data_list, head) {
+		if (!sigmadsp_samplerate_valid(data->samplerates,
+		    samplerate_mask))
+			continue;
 		ret = sigmadsp_write(sigmadsp, data->addr, data->data,
 			data->length);
 		if (ret)
 			goto err;
 	}
 
+	list_for_each_entry(ctrl, &sigmadsp->ctrl_list, head)
+		sigmadsp_activate_ctrl(sigmadsp, ctrl, samplerate_mask);
+
 	sigmadsp->current_samplerate = samplerate;
 
 	return 0;
@@ -335,6 +785,11 @@ EXPORT_SYMBOL_GPL(sigmadsp_setup);
  */
 void sigmadsp_reset(struct sigmadsp *sigmadsp)
 {
+	struct sigmadsp_control *ctrl;
+
+	list_for_each_entry(ctrl, &sigmadsp->ctrl_list, head)
+		sigmadsp_activate_ctrl(sigmadsp, ctrl, false);
+
 	sigmadsp->current_samplerate = 0;
 }
 EXPORT_SYMBOL_GPL(sigmadsp_reset);
@@ -352,7 +807,11 @@ EXPORT_SYMBOL_GPL(sigmadsp_reset);
 int sigmadsp_restrict_params(struct sigmadsp *sigmadsp,
 	struct snd_pcm_substream *substream)
 {
-	return 0;
+	if (sigmadsp->rate_constraints.count == 0)
+		return 0;
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+		SNDRV_PCM_HW_PARAM_RATE, &sigmadsp->rate_constraints);
 }
 EXPORT_SYMBOL_GPL(sigmadsp_restrict_params);
 
diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index a6be91a..614475c 100644
--- a/sound/soc/codecs/sigmadsp.h
+++ b/sound/soc/codecs/sigmadsp.h
@@ -27,14 +27,20 @@ struct sigmadsp_ops {
 struct sigmadsp {
 	const struct sigmadsp_ops *ops;
 
+	struct list_head ctrl_list;
 	struct list_head data_list;
 
+	struct snd_pcm_hw_constraint_list rate_constraints;
+
 	unsigned int current_samplerate;
 	struct snd_soc_component *component;
 	struct device *dev;
 
+	struct mutex lock;
+
 	void *control_data;
 	int (*write)(void *, unsigned int, const uint8_t *, size_t);
+	int (*read)(void *, unsigned int, uint8_t *, size_t);
 };
 
 struct sigmadsp *devm_sigmadsp_init(struct device *dev,
-- 
1.8.0
