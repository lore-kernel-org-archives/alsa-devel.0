From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Tue, 29 May 2012 19:05:30 +0200
Message-ID: <4FC501DA.3050900@ladisch.de>
References: <4FBFE0D5.8030501@mixxx.org> <4FC23123.8000702@ladisch.de>
	<4FC295AD.1030901@mixxx.org> <4FC3929F.4050304@ladisch.de>
	<4FC3E2AD.70802@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C1D5F24BA1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2012 19:06:00 +0200 (CEST)
In-Reply-To: <4FC3E2AD.70802@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sean M. Pappalardo - D.J. Pegasus wrote:
>>     firewire-request /dev/fwX write c007dedadada f100123456789abc
>
> no response (on both devices)

No error, which is good.

>>     firewire-request /dev/fwX read c007dedadada 4
>
> type error (on both devices)

This is supposed to be used to confirm that this is indeed a HSS1394 device.
In theory.  But we can just omit this check.  :)

New patch below (also with .1d support).


Regards,
Clemens


--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -33,4 +33,17 @@ config SND_ISIGHT
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-isight.

+config SND_SCS1X
+	tristate "Stanton Control System 1 MIDI"
+	select SND_PCM
+	select SND_RAWMIDI
+	select SND_FIREWIRE_LIB
+	help
+	  Say Y here to include support for the MIDI ports of the Stanton
+	  SCS.1d/SCS.1m DJ controllers.  (SCS.1m audio is still handled
+	  by FFADO.)
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-scs1x.
+
 endif # SND_FIREWIRE
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -2,7 +2,9 @@ snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp.o
 snd-firewire-speakers-objs := speakers.o
 snd-isight-objs := isight.o
+snd-scs1x-objs := scs1x.o

 obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
 obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
+obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
--- /dev/null
+++ b/sound/firewire/scs1x.c
@@ -0,0 +1,436 @@
+/*
+ * Stanton Control System 1 MIDI driver
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/device.h>
+#include <linux/firewire.h>
+#include <linux/firewire-constants.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
+#include "lib.h"
+
+#define OUI_STANTON	0x001260
+#define MODEL_SCS_1M	0x001000
+#define MODEL_SCS_1D	0x002000
+
+#define HSS1394_ADDRESS			0xc007dedadadaULL
+#define HSS1394_MAX_PACKET_SIZE		64
+
+#define HSS1394_TAG_USER_DATA		0x00
+#define HSS1394_TAG_CHANGE_ADDRESS	0xf1
+
+struct scs {
+	struct snd_card *card;
+	struct fw_unit *unit;
+	struct fw_address_handler hss_handler;
+	struct fw_transaction transaction;
+	bool transaction_running;
+	bool output_idle;
+	u8 midi_status;
+	u8 midi_bytes;
+	struct snd_rawmidi_substream *output;
+	struct snd_rawmidi_substream *input;
+	struct tasklet_struct tasklet;
+	wait_queue_head_t idle_wait;
+	u8 *buffer;
+};
+
+static int scs_output_open(struct snd_rawmidi_substream *stream)
+{
+	struct scs *scs = stream->rmidi->private_data;
+
+	scs->midi_status = 0;
+	scs->midi_bytes = 0;
+
+	return 0;
+}
+
+static int scs_output_close(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static void scs_output_trigger(struct snd_rawmidi_substream *stream, int up)
+{
+	struct scs *scs = stream->rmidi->private_data;
+
+	ACCESS_ONCE(scs->output) = up ? stream : NULL;
+	if (up) {
+		scs->output_idle = false;
+		tasklet_schedule(&scs->tasklet);
+	}
+}
+
+static void scs_write_callback(struct fw_card *card, int rcode,
+			       void *data, size_t length, void *callback_data)
+{
+	struct scs *scs = callback_data;
+
+	if (rcode == RCODE_GENERATION) {
+		/* TODO: retry this packet */
+	}
+
+	scs->transaction_running = false;
+	tasklet_schedule(&scs->tasklet);
+}
+
+static bool is_valid_running_status(u8 status)
+{
+	return status >= 0x80 && status <= 0xef;
+}
+
+static bool is_one_byte_cmd(u8 status)
+{
+	return status == 0xf6 ||
+	       status >= 0xf8;
+}
+
+static bool is_two_bytes_cmd(u8 status)
+{
+	return (status >= 0xc0 && status <= 0xdf) ||
+	       status == 0xf1 ||
+	       status == 0xf3;
+}
+
+static bool is_three_bytes_cmd(u8 status)
+{
+	return (status >= 0x80 && status <= 0xbf) ||
+	       (status >= 0xe0 && status <= 0xef) ||
+	       status == 0xf2;
+}
+
+static bool is_invalid_cmd(u8 status)
+{
+	return status == 0xf4 || status == 0xf5;
+}
+
+static void scs_output_tasklet(unsigned long data)
+{
+	struct scs *scs = (void *)data;
+	struct snd_rawmidi_substream *stream;
+	unsigned int i;
+	u8 byte;
+	struct fw_device *dev;
+	int generation;
+
+	if (scs->transaction_running)
+		return;
+
+	stream = ACCESS_ONCE(scs->output);
+	if (!stream) {
+		scs->output_idle = true;
+		wake_up(&scs->idle_wait);
+		return;
+	}
+
+	i = scs->midi_bytes;
+	for (;;) {
+		if (snd_rawmidi_transmit(stream, &byte, 1) != 1) {
+			scs->midi_bytes = i;
+			scs->output_idle = true;
+			wake_up(&scs->idle_wait);
+			return;
+		}
+		/*
+		 * Convert from real MIDI to what the device expects (no
+		 * running status, one command per packet).
+		 */
+		if (byte < 0x80) {
+			if (i == 0) {
+				if (!is_valid_running_status(scs->midi_status))
+					continue;
+				scs->buffer[++i] = scs->midi_status;
+			}
+			scs->buffer[++i] = byte;
+			if ((i == 2 && is_two_bytes_cmd(scs->midi_status)) ||
+			    (i == 3 && is_three_bytes_cmd(scs->midi_status)))
+				break;
+			if (i >= HSS1394_MAX_PACKET_SIZE - 1)
+				i = 0;
+		} else if (byte == 0xf7) {
+			if (i > 0 && scs->midi_status == 0xf0) {
+				scs->buffer[++i] = 0xf7;
+				break;
+			}
+		} else if (!is_invalid_cmd(byte) &&
+			   byte < 0xf8) {
+			i = 0;
+			scs->buffer[++i] = byte;
+			scs->midi_status = byte;
+			if (is_one_byte_cmd(byte))
+				break;
+		}
+	}
+	scs->midi_bytes = 0;
+
+	scs->transaction_running = true;
+	dev = fw_parent_device(scs->unit);
+	generation = dev->generation;
+	smp_rmb(); /* node_id vs. generation */
+	fw_send_request(dev->card, &scs->transaction, TCODE_WRITE_BLOCK_REQUEST,
+			dev->node_id, generation, dev->max_speed,
+			HSS1394_ADDRESS, scs->buffer, 1 + i,
+			scs_write_callback, scs);
+}
+
+static void scs_output_drain(struct snd_rawmidi_substream *stream)
+{
+	struct scs *scs = stream->rmidi->private_data;
+
+	wait_event(scs->idle_wait, scs->output_idle);
+}
+
+static struct snd_rawmidi_ops output_ops = {
+	.open    = scs_output_open,
+	.close   = scs_output_close,
+	.trigger = scs_output_trigger,
+	.drain   = scs_output_drain,
+};
+
+static int scs_input_open(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static int scs_input_close(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static void scs_input_trigger(struct snd_rawmidi_substream *stream, int up)
+{
+	struct scs *scs = stream->rmidi->private_data;
+
+	ACCESS_ONCE(scs->input) = up ? stream : NULL;
+}
+
+static struct snd_rawmidi_ops input_ops = {
+	.open    = scs_input_open,
+	.close   = scs_input_close,
+	.trigger = scs_input_trigger,
+};
+
+static int scs_create_midi(struct scs *scs)
+{
+	struct snd_rawmidi *rmidi;
+	int err;
+
+	err = snd_rawmidi_new(scs->card, "SCS.1x", 0, 1, 1, &rmidi);
+	if (err < 0)
+		return err;
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", scs->card->shortname);
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_OUTPUT |
+	                    SNDRV_RAWMIDI_INFO_INPUT |
+	                    SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->private_data = scs;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &output_ops);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &input_ops);
+
+	return 0;
+}
+
+static void handle_hss(struct fw_card *card, struct fw_request *request,
+		       int tcode, int destination, int source, int generation,
+		       unsigned long long offset, void *data, size_t length,
+		       void *callback_data)
+{
+	struct scs *scs = callback_data;
+	struct snd_rawmidi_substream *stream;
+
+	if (offset != scs->hss_handler.offset) {
+		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
+		return;
+	}
+	if (tcode != TCODE_WRITE_QUADLET_REQUEST &&
+	    tcode != TCODE_WRITE_BLOCK_REQUEST) {
+		fw_send_response(card, request, RCODE_TYPE_ERROR);
+		return;
+	}
+
+	if (length >= 1 && ((const u8 *)data)[0] == HSS1394_TAG_USER_DATA) {
+		stream = ACCESS_ONCE(scs->input);
+		if (stream)
+			snd_rawmidi_receive(stream, data + 1, length - 1);
+	}
+
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+static int scs_init_hss_address(struct scs *scs)
+{
+	u8 data[8];
+	int err;
+
+	*(__be64 *)data = cpu_to_be64(scs->hss_handler.offset);
+	data[0] = HSS1394_TAG_CHANGE_ADDRESS;
+	err = snd_fw_transaction(scs->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 HSS1394_ADDRESS, data, 8);
+	if (err < 0)
+		dev_err(&scs->unit->device, "HSS1394 communication failed\n");
+
+	return err;
+}
+
+static void scs_card_free(struct snd_card *card)
+{
+	struct scs *scs = card->private_data;
+
+	fw_core_remove_address_handler(&scs->hss_handler);
+	kfree(scs->buffer);
+}
+
+static int scs_probe(struct device *unit_dev)
+{
+	struct fw_unit *unit = fw_unit(unit_dev);
+	struct fw_device *fw_dev = fw_parent_device(unit);
+	struct snd_card *card;
+	struct scs *scs;
+	int err;
+
+	err = snd_card_create(-16, NULL, THIS_MODULE, sizeof(*scs), &card);
+	if (err < 0)
+		return err;
+	snd_card_set_dev(card, unit_dev);
+
+	scs = card->private_data;
+	scs->card = card;
+	scs->unit = unit;
+	tasklet_init(&scs->tasklet, scs_output_tasklet, (unsigned long)scs);
+	init_waitqueue_head(&scs->idle_wait);
+	scs->output_idle = true;
+
+	scs->buffer = kmalloc(HSS1394_MAX_PACKET_SIZE, GFP_KERNEL);
+	if (!scs->buffer)
+		goto err_card;
+	scs->buffer[0] = HSS1394_TAG_USER_DATA;
+
+	scs->hss_handler.length = HSS1394_MAX_PACKET_SIZE;
+	scs->hss_handler.address_callback = handle_hss;
+	scs->hss_handler.callback_data = scs;
+	err = fw_core_add_address_handler(&scs->hss_handler,
+					  &fw_high_memory_region);
+	if (err < 0)
+		goto err_buffer;
+
+	card->private_free = scs_card_free;
+
+	strcpy(card->driver, "SCS.1x");
+	strcpy(card->shortname, "SCS.1x");
+	fw_csr_string(unit->directory, CSR_MODEL,
+		      card->shortname, sizeof(card->shortname));
+	snprintf(card->longname, sizeof(card->longname),
+		 "Stanton DJ %s (GUID %08x%08x) at %s, S%d",
+		 card->shortname, fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&unit->device), 100 << fw_dev->max_speed);
+	strcpy(card->mixername, card->shortname);
+
+	err = scs_init_hss_address(scs);
+	if (err < 0)
+		goto err_card;
+
+	err = scs_create_midi(scs);
+	if (err < 0)
+		goto err_card;
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto err_card;
+
+	dev_set_drvdata(unit_dev, scs);
+
+	return 0;
+
+err_buffer:
+	kfree(scs->buffer);
+err_card:
+	snd_card_free(card);
+	return err;
+}
+
+static int scs_remove(struct device *dev)
+{
+	struct scs *scs = dev_get_drvdata(dev);
+
+	snd_card_disconnect(scs->card);
+
+	ACCESS_ONCE(scs->output) = NULL;
+	ACCESS_ONCE(scs->input) = NULL;
+
+	wait_event(scs->idle_wait, scs->output_idle);
+
+	tasklet_kill(&scs->tasklet);
+
+	snd_card_free_when_closed(scs->card);
+
+	return 0;
+}
+
+static void scs_update(struct fw_unit *unit)
+{
+	struct scs *scs = dev_get_drvdata(&unit->device);
+	int generation;
+	u8 data[8];
+
+	*(__be64 *)data = cpu_to_be64(scs->hss_handler.offset);
+	data[0] = HSS1394_TAG_CHANGE_ADDRESS;
+	generation = fw_parent_device(unit)->generation;
+	smp_rmb(); /* node_id vs. generation */
+	snd_fw_transaction(scs->unit, TCODE_WRITE_BLOCK_REQUEST,
+			   HSS1394_ADDRESS, data, 8);
+}
+
+static const struct ieee1394_device_id scs_id_table[] = {
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+		               IEEE1394_MATCH_MODEL_ID,
+		.vendor_id   = OUI_STANTON,
+		.model_id    = MODEL_SCS_1M,
+	},
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+		               IEEE1394_MATCH_MODEL_ID,
+		.vendor_id   = OUI_STANTON,
+		.model_id    = MODEL_SCS_1D,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, scs_id_table);
+
+MODULE_DESCRIPTION("SCS.1x MIDI driver");
+MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_LICENSE("GPL v2");
+
+static struct fw_driver scs_driver = {
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = KBUILD_MODNAME,
+		.bus    = &fw_bus_type,
+		.probe  = scs_probe,
+		.remove = scs_remove,
+	},
+	.update   = scs_update,
+	.id_table = scs_id_table,
+};
+
+static int __init alsa_scs1x_init(void)
+{
+	return driver_register(&scs_driver.driver);
+}
+
+static void __exit alsa_scs1x_exit(void)
+{
+	driver_unregister(&scs_driver.driver);
+}
+
+module_init(alsa_scs1x_init);
+module_exit(alsa_scs1x_exit);
