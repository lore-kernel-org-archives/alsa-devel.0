From: linux@audioscience.com
Subject: [PATCH 13/21] Remove redundant struct members.
Date: Thu, 22 Dec 2011 13:38:43 +1300
Message-ID: <1324514331-22570-14-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 74B68103C30
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:14 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:29 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Structs hpi_adapter and snd_card_asihpi had members that
duplicate those in underlying hpi_adapter_obj or whose info
can be retrieved using hpi_adapter_get_info().

Print less info in probe function, it can be retrieved from /proc.

Avoid name redundancy: hpi_adapter_obj.adapter_type renamed to .type

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c  |  143 ++++++++++++++++++++------------------------
 sound/pci/asihpi/hpi6000.c |   59 +++++++++---------
 sound/pci/asihpi/hpi6205.c |    8 +--
 sound/pci/asihpi/hpicmn.c  |   20 +++---
 sound/pci/asihpi/hpicmn.h  |   11 ++-
 sound/pci/asihpi/hpioctl.c |   62 ++++++++-----------
 sound/pci/asihpi/hpios.h   |   14 ++---
 7 files changed, 147 insertions(+), 170 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 0c45638..da11e6d 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -25,6 +25,8 @@
 #include "hpi_internal.h"
 #include "hpimsginit.h"
 #include "hpioctl.h"
+#include "hpicmn.h"
+
 
 #include <linux/pci.h>
 #include <linux/init.h>
@@ -119,12 +121,7 @@ struct clk_cache {
 struct snd_card_asihpi {
 	struct snd_card *card;
 	struct pci_dev *pci;
-	u16 adapter_index;
-	u32 serial_number;
-	u16 type;
-	u16 version;
-	u16 num_outstreams;
-	u16 num_instreams;
+	struct hpi_adapter *hpi;
 
 	u32 h_mixer;
 	struct clk_cache cc;
@@ -497,6 +494,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 
 		snd_printdd("stream_host_buffer_attach status 0x%x\n",
 				dpcm->hpi_buffer_attached);
+
 	}
 	bytes_per_sec = params_rate(params) * params_channels(params);
 	width = snd_pcm_format_width(params_format(params));
@@ -993,7 +991,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 
 	err =
-	    hpi_outstream_open(card->adapter_index,
+	    hpi_outstream_open(card->hpi->adapter->index,
 			      substream->number, &dpcm->h_stream);
 	hpi_handle_error(err);
 	if (err)
@@ -1174,10 +1172,10 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 
 	snd_printdd("capture open adapter %d stream %d\n",
-		   card->adapter_index, substream->number);
+			card->hpi->adapter->index, substream->number);
 
 	err = hpi_handle_error(
-	    hpi_instream_open(card->adapter_index,
+	    hpi_instream_open(card->hpi->adapter->index,
 			     substream->number, &dpcm->h_stream));
 	if (err)
 		kfree(dpcm);
@@ -1186,7 +1184,6 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	if (err)
 		return -EIO;
 
-
 	init_timer(&dpcm->timer);
 	dpcm->timer.data = (unsigned long) dpcm;
 	dpcm->timer.function = snd_card_asihpi_timer_function;
@@ -1243,15 +1240,20 @@ static struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
 	.pointer = snd_card_asihpi_capture_pointer,
 };
 
-static int __devinit snd_card_asihpi_pcm_new(struct snd_card_asihpi *asihpi,
-				      int device, int substreams)
+static int __devinit snd_card_asihpi_pcm_new(
+		struct snd_card_asihpi *asihpi, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
+	u16 num_instreams, num_outstreams, x16;
+	u32 x32;
+
+	err = hpi_adapter_get_info(asihpi->hpi->adapter->index,
+			&num_outstreams, &num_instreams,
+			&x16, &x32, &x16);
 
 	err = snd_pcm_new(asihpi->card, "Asihpi PCM", device,
-			 asihpi->num_outstreams, asihpi->num_instreams,
-			 &pcm);
+			num_outstreams,	num_instreams, &pcm);
 	if (err < 0)
 		return err;
 	/* pointer to ops struct is stored, dont change ops afterwards! */
@@ -2561,7 +2563,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 	strcpy(card->mixername, "Asihpi Mixer");
 
 	err =
-	    hpi_mixer_open(asihpi->adapter_index,
+	    hpi_mixer_open(asihpi->hpi->adapter->index,
 			  &asihpi->h_mixer);
 	hpi_handle_error(err);
 	if (err)
@@ -2679,24 +2681,33 @@ snd_asihpi_proc_read(struct snd_info_entry *entry,
 			struct snd_info_buffer *buffer)
 {
 	struct snd_card_asihpi *asihpi = entry->private_data;
-	u16 version;
 	u32 h_control;
 	u32 rate = 0;
 	u16 source = 0;
+
+	u16 num_outstreams;
+	u16 num_instreams;
+	u16 version;
+	u32 serial_number;
+	u16 type;
+
 	int err;
 
 	snd_iprintf(buffer, "ASIHPI driver proc file\n");
+
+	hpi_handle_error(hpi_adapter_get_info(asihpi->hpi->adapter->index,
+			&num_outstreams, &num_instreams,
+			&version, &serial_number, &type));
+
 	snd_iprintf(buffer,
-		"adapter ID=%4X\n_index=%d\n"
-		"num_outstreams=%d\n_num_instreams=%d\n",
-		asihpi->type, asihpi->adapter_index,
-		asihpi->num_outstreams, asihpi->num_instreams);
+			"Adapter type ASI%4X\nHardware Index %d\n"
+			"%d outstreams\n%d instreams\n",
+			type, asihpi->hpi->adapter->index,
+			num_outstreams, num_instreams);
 
-	version = asihpi->version;
 	snd_iprintf(buffer,
-		"serial#=%d\n_hw version %c%d\nDSP code version %03d\n",
-		asihpi->serial_number, ((version >> 3) & 0xf) + 'A',
-		version & 0x7,
+		"Serial#%d\nHardware version %c%d\nDSP code version %03d\n",
+		serial_number, ((version >> 3) & 0xf) + 'A', version & 0x7,
 		((version >> 13) * 100) + ((version >> 7) & 0x3f));
 
 	err = hpi_mixer_get_control(asihpi->h_mixer,
@@ -2704,18 +2715,15 @@ snd_asihpi_proc_read(struct snd_info_entry *entry,
 				  HPI_CONTROL_SAMPLECLOCK, &h_control);
 
 	if (!err) {
-		err = hpi_sample_clock_get_sample_rate(
-					h_control, &rate);
+		err = hpi_sample_clock_get_sample_rate(h_control, &rate);
 		err += hpi_sample_clock_get_source(h_control, &source);
 
 		if (!err)
-			snd_iprintf(buffer, "sample_clock=%d_hz, source %s\n",
+			snd_iprintf(buffer, "Sample Clock %dHz, source %s\n",
 			rate, sampleclock_sources[source]);
 	}
-
 }
 
-
 static void __devinit snd_asihpi_proc_init(struct snd_card_asihpi *asihpi)
 {
 	struct snd_info_entry *entry;
@@ -2787,35 +2795,34 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 				       const struct pci_device_id *pci_id)
 {
 	int err;
-
-	u16 version;
-	int pcm_substreams;
-
-	struct hpi_adapter *hpi_card;
+	struct hpi_adapter *hpi;
 	struct snd_card *card;
 	struct snd_card_asihpi *asihpi;
 
 	u32 h_control;
 	u32 h_stream;
+	u32 adapter_index;
 
 	static int dev;
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 
-	/* Should this be enable[hpi_card->index] ? */
+	/* Should this be enable[hpi->index] ? */
 	if (!enable[dev]) {
 		dev++;
 		return -ENOENT;
 	}
 
+	/* Initialise low-level HPI driver */
 	err = asihpi_adapter_probe(pci_dev, pci_id);
 	if (err < 0)
 		return err;
 
-	hpi_card = pci_get_drvdata(pci_dev);
+	hpi = pci_get_drvdata(pci_dev);
+	adapter_index = hpi->adapter->index;
 	/* first try to give the card the same index as its hardware index */
-	err = snd_card_create(hpi_card->index,
-			      id[hpi_card->index], THIS_MODULE,
+	err = snd_card_create(adapter_index,
+			      id[adapter_index], THIS_MODULE,
 			      sizeof(struct snd_card_asihpi),
 			      &card);
 	if (err < 0) {
@@ -2829,50 +2836,32 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 			return err;
 		snd_printk(KERN_WARNING
 			"**** WARNING **** Adapter index %d->ALSA index %d\n",
-			hpi_card->index, card->number);
+			adapter_index, card->number);
 	}
 
 	snd_card_set_dev(card, &pci_dev->dev);
 
-	asihpi = (struct snd_card_asihpi *) card->private_data;
+	asihpi = card->private_data;
 	asihpi->card = card;
 	asihpi->pci = pci_dev;
-	asihpi->adapter_index = hpi_card->index;
-	hpi_handle_error(hpi_adapter_get_info(
-				 asihpi->adapter_index,
-				 &asihpi->num_outstreams,
-				 &asihpi->num_instreams,
-				 &asihpi->version,
-				 &asihpi->serial_number, &asihpi->type));
-
-	version = asihpi->version;
-	snd_printk(KERN_INFO "adapter ID=%4X index=%d num_outstreams=%d "
-			"num_instreams=%d S/N=%d\n"
-			"Hw Version %c%d DSP code version %03d\n",
-			asihpi->type, asihpi->adapter_index,
-			asihpi->num_outstreams,
-			asihpi->num_instreams, asihpi->serial_number,
-			((version >> 3) & 0xf) + 'A',
-			version & 0x7,
-			((version >> 13) * 100) + ((version >> 7) & 0x3f));
-
-	pcm_substreams = asihpi->num_outstreams;
-	if (pcm_substreams < asihpi->num_instreams)
-		pcm_substreams = asihpi->num_instreams;
-
-	err = hpi_adapter_get_property(asihpi->adapter_index,
+	asihpi->hpi = hpi;
+
+	snd_printk(KERN_INFO "adapter ID=%4X index=%d\n",
+			asihpi->hpi->adapter->type, adapter_index);
+
+	err = hpi_adapter_get_property(adapter_index,
 		HPI_ADAPTER_PROPERTY_CAPS1,
 		NULL, &asihpi->support_grouping);
 	if (err)
 		asihpi->support_grouping = 0;
 
-	err = hpi_adapter_get_property(asihpi->adapter_index,
+	err = hpi_adapter_get_property(adapter_index,
 		HPI_ADAPTER_PROPERTY_CAPS2,
 		&asihpi->support_mrx, NULL);
 	if (err)
 		asihpi->support_mrx = 0;
 
-	err = hpi_adapter_get_property(asihpi->adapter_index,
+	err = hpi_adapter_get_property(adapter_index,
 		HPI_ADAPTER_PROPERTY_INTERVAL,
 		NULL, &asihpi->update_interval_frames);
 	if (err)
@@ -2881,7 +2870,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (!asihpi->can_dma)
 		asihpi->update_interval_frames *= 2;
 
-	hpi_handle_error(hpi_instream_open(asihpi->adapter_index,
+	hpi_handle_error(hpi_instream_open(adapter_index,
 			     0, &h_stream));
 
 	err = hpi_instream_host_buffer_free(h_stream);
@@ -2889,7 +2878,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 
 	hpi_handle_error(hpi_instream_close(h_stream));
 
-	err = hpi_adapter_get_property(asihpi->adapter_index,
+	err = hpi_adapter_get_property(adapter_index,
 		HPI_ADAPTER_PROPERTY_CURCHANNELS,
 		&asihpi->in_max_chans, &asihpi->out_max_chans);
 	if (err) {
@@ -2906,13 +2895,13 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->in_min_chans = 1;
 	}
 
-	snd_printk(KERN_INFO "has dma:%d, grouping:%d, mrx:%d\n",
+	snd_printk(KERN_INFO "Has dma:%d, grouping:%d, mrx:%d\n",
 			asihpi->can_dma,
 			asihpi->support_grouping,
 			asihpi->support_mrx
 	      );
 
-	err = snd_card_asihpi_pcm_new(asihpi, 0, pcm_substreams);
+	err = snd_card_asihpi_pcm_new(asihpi, 0);
 	if (err < 0) {
 		snd_printk(KERN_ERR "pcm_new failed\n");
 		goto __nodev;
@@ -2939,13 +2928,14 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 
 	strcpy(card->driver, "ASIHPI");
 
-	sprintf(card->shortname, "AudioScience ASI%4X", asihpi->type);
+	sprintf(card->shortname, "AudioScience ASI%4X",
+			asihpi->hpi->adapter->type);
 	sprintf(card->longname, "%s %i",
-			card->shortname, asihpi->adapter_index);
+			card->shortname, adapter_index);
 	err = snd_card_register(card);
 
 	if (!err) {
-		hpi_card->snd_card_asihpi = card;
+		hpi->snd_card = card;
 		dev++;
 		return 0;
 	}
@@ -2958,10 +2948,9 @@ __nodev:
 
 static void __devexit snd_asihpi_remove(struct pci_dev *pci_dev)
 {
-	struct hpi_adapter *hpi_card = pci_get_drvdata(pci_dev);
-
-	snd_card_free(hpi_card->snd_card_asihpi);
-	hpi_card->snd_card_asihpi = NULL;
+	struct hpi_adapter *hpi = pci_get_drvdata(pci_dev);
+	snd_card_free(hpi->snd_card);
+	hpi->snd_card = NULL;
 	asihpi_adapter_remove(pci_dev);
 }
 
diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index 278bec8..2414d7a 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -231,6 +231,8 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr)
 static void control_message(struct hpi_adapter_obj *pao,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
+	struct hpi_hw_obj *phw = pao->priv;
+
 	switch (phm->function) {
 	case HPI_CONTROL_GET_STATE:
 		if (pao->has_control_cache) {
@@ -248,17 +250,14 @@ static void control_message(struct hpi_adapter_obj *pao,
 				break;
 			}
 
-			if (hpi_check_control_cache(((struct hpi_hw_obj *)
-						pao->priv)->p_cache, phm,
-					phr))
+			if (hpi_check_control_cache(phw->p_cache, phm, phr))
 				break;
 		}
 		hw_message(pao, phm, phr);
 		break;
 	case HPI_CONTROL_SET_STATE:
 		hw_message(pao, phm, phr);
-		hpi_cmn_control_cache_sync_to_msg(((struct hpi_hw_obj *)pao->
-				priv)->p_cache, phm, phr);
+		hpi_cmn_control_cache_sync_to_msg(phw->p_cache, phm, phr);
 		break;
 
 	case HPI_CONTROL_GET_INFO:
@@ -451,11 +450,11 @@ static void subsys_create_adapter(struct hpi_message *phm,
 	}
 
 	for (dsp_index = 0; dsp_index < MAX_DSPS; dsp_index++) {
-		struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+		struct hpi_hw_obj *phw = pao->priv;
 		phw->ado[dsp_index].pa_parent_adapter = pao;
 	}
 
-	phr->u.s.adapter_type = ao.adapter_type;
+	phr->u.s.adapter_type = ao.type;
 	phr->u.s.adapter_index = ao.index;
 	phr->error = 0;
 }
@@ -476,7 +475,7 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 	u32 dsp_index = 0;
 	u32 control_cache_size = 0;
 	u32 control_cache_count = 0;
-	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+	struct hpi_hw_obj *phw = pao->priv;
 
 	/* The PCI2040 has the following address map */
 	/* BAR0 - 4K = HPI control and status registers on PCI2040 (HPI CSR) */
@@ -559,7 +558,7 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 			if (error)
 				return error;
 		}
-		pao->adapter_type = hr0.u.ax.info.adapter_type;
+		pao->type = hr0.u.ax.info.adapter_type;
 		pao->index = hr0.u.ax.info.adapter_index;
 	}
 
@@ -584,9 +583,8 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 			pao->has_control_cache = 1;
 	}
 
-	HPI_DEBUG_LOG(DEBUG, "get adapter info ASI%04X index %d\n",
-		pao->adapter_type, pao->index);
-	pao->open = 0;	/* upon creation the adapter is closed */
+	HPI_DEBUG_LOG(DEBUG, "get adapter info ASI%04X index %d\n", pao->type,
+		pao->index);
 
 	if (phw->p_cache)
 		phw->p_cache->adap_idx = pao->index;
@@ -596,7 +594,7 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 
 static void delete_adapter_obj(struct hpi_adapter_obj *pao)
 {
-	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+	struct hpi_hw_obj *phw = pao->priv;
 
 	if (pao->has_control_cache)
 		hpi_free_control_cache(phw->p_cache);
@@ -639,7 +637,7 @@ static void adapter_get_asserts(struct hpi_adapter_obj *pao,
 static short hpi6000_adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	u32 *pos_error_code)
 {
-	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+	struct hpi_hw_obj *phw = pao->priv;
 	short error;
 	u32 timeout;
 	u32 read = 0;
@@ -1220,8 +1218,8 @@ static void hpi_read_block(struct dsp_obj *pdo, u32 address, u32 *pdata,
 static u16 hpi6000_dsp_block_write32(struct hpi_adapter_obj *pao,
 	u16 dsp_index, u32 hpi_address, u32 *source, u32 count)
 {
-	struct dsp_obj *pdo =
-		&(*(struct hpi_hw_obj *)pao->priv).ado[dsp_index];
+	struct hpi_hw_obj *phw = pao->priv;
+	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 time_out = PCI_TIMEOUT;
 	int c6711_burst_size = 128;
 	u32 local_hpi_address = hpi_address;
@@ -1258,8 +1256,8 @@ static u16 hpi6000_dsp_block_write32(struct hpi_adapter_obj *pao,
 static u16 hpi6000_dsp_block_read32(struct hpi_adapter_obj *pao,
 	u16 dsp_index, u32 hpi_address, u32 *dest, u32 count)
 {
-	struct dsp_obj *pdo =
-		&(*(struct hpi_hw_obj *)pao->priv).ado[dsp_index];
+	struct hpi_hw_obj *phw = pao->priv;
+	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 time_out = PCI_TIMEOUT;
 	int c6711_burst_size = 16;
 	u32 local_hpi_address = hpi_address;
@@ -1298,7 +1296,7 @@ static u16 hpi6000_dsp_block_read32(struct hpi_adapter_obj *pao,
 static short hpi6000_message_response_sequence(struct hpi_adapter_obj *pao,
 	u16 dsp_index, struct hpi_message *phm, struct hpi_response *phr)
 {
-	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+	struct hpi_hw_obj *phw = pao->priv;
 	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 timeout;
 	u16 ack;
@@ -1414,8 +1412,8 @@ static short hpi6000_send_data_check_adr(u32 address, u32 length_in_dwords)
 static short hpi6000_send_data(struct hpi_adapter_obj *pao, u16 dsp_index,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
-	struct dsp_obj *pdo =
-		&(*(struct hpi_hw_obj *)pao->priv).ado[dsp_index];
+	struct hpi_hw_obj *phw = pao->priv;
+	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 data_sent = 0;
 	u16 ack;
 	u32 length, address;
@@ -1487,8 +1485,8 @@ static short hpi6000_send_data(struct hpi_adapter_obj *pao, u16 dsp_index,
 static short hpi6000_get_data(struct hpi_adapter_obj *pao, u16 dsp_index,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
-	struct dsp_obj *pdo =
-		&(*(struct hpi_hw_obj *)pao->priv).ado[dsp_index];
+	struct hpi_hw_obj *phw = pao->priv;
+	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 data_got = 0;
 	u16 ack;
 	u32 length, address;
@@ -1551,8 +1549,8 @@ static void hpi6000_send_dsp_interrupt(struct dsp_obj *pdo)
 static short hpi6000_send_host_command(struct hpi_adapter_obj *pao,
 	u16 dsp_index, u32 host_cmd)
 {
-	struct dsp_obj *pdo =
-		&(*(struct hpi_hw_obj *)pao->priv).ado[dsp_index];
+	struct hpi_hw_obj *phw = pao->priv;
+	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 timeout = TIMEOUT;
 
 	/* set command */
@@ -1577,7 +1575,7 @@ static short hpi6000_check_PCI2040_error_flag(struct hpi_adapter_obj *pao,
 {
 	u32 hPI_error;
 
-	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+	struct hpi_hw_obj *phw = pao->priv;
 
 	/* read the error bits from the PCI2040 */
 	hPI_error = ioread32(phw->dw2040_HPICSR + HPI_ERROR_REPORT);
@@ -1597,8 +1595,8 @@ static short hpi6000_check_PCI2040_error_flag(struct hpi_adapter_obj *pao,
 static short hpi6000_wait_dsp_ack(struct hpi_adapter_obj *pao, u16 dsp_index,
 	u32 ack_value)
 {
-	struct dsp_obj *pdo =
-		&(*(struct hpi_hw_obj *)pao->priv).ado[dsp_index];
+	struct hpi_hw_obj *phw = pao->priv;
+	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 ack = 0L;
 	u32 timeout;
 	u32 hPIC = 0L;
@@ -1640,7 +1638,7 @@ static short hpi6000_update_control_cache(struct hpi_adapter_obj *pao,
 	struct hpi_message *phm)
 {
 	const u16 dsp_index = 0;
-	struct hpi_hw_obj *phw = (struct hpi_hw_obj *)pao->priv;
+	struct hpi_hw_obj *phw = pao->priv;
 	struct dsp_obj *pdo = &phw->ado[dsp_index];
 	u32 timeout;
 	u32 cache_dirty_flag;
@@ -1740,7 +1738,8 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 {
 	u16 error = 0;
 	u16 dsp_index = 0;
-	u16 num_dsp = ((struct hpi_hw_obj *)pao->priv)->num_dsp;
+	struct hpi_hw_obj *phw = pao->priv;
+	u16 num_dsp = phw->num_dsp;
 
 	if (num_dsp < 2)
 		dsp_index = 0;
diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 95d1cd5..e3d0f55 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -488,7 +488,7 @@ static void subsys_create_adapter(struct hpi_message *phm,
 		return;
 	}
 
-	phr->u.s.adapter_type = ao.adapter_type;
+	phr->u.s.adapter_type = ao.type;
 	phr->u.s.adapter_index = ao.index;
 	phr->error = 0;
 }
@@ -503,7 +503,7 @@ static void adapter_delete(struct hpi_adapter_obj *pao,
 		phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
 		return;
 	}
-	phw = (struct hpi_hw_obj *)pao->priv;
+	phw = pao->priv;
 	/* reset adapter h/w */
 	/* Reset C6713 #1 */
 	boot_loader_write_mem32(pao, 0, C6205_BAR0_TIMER1_CTL, 0);
@@ -652,7 +652,7 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 		if (hr.error)
 			return hr.error;
 
-		pao->adapter_type = hr.u.ax.info.adapter_type;
+		pao->type = hr.u.ax.info.adapter_type;
 		pao->index = hr.u.ax.info.adapter_index;
 
 		max_streams =
@@ -665,8 +665,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 			hr.u.ax.info.serial_number);
 	}
 
-	pao->open = 0;	/* upon creation the adapter is closed */
-
 	if (phw->p_cache)
 		phw->p_cache->adap_idx = pao->index;
 
diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index 358853a..c54a49f 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -68,7 +68,7 @@ u16 hpi_validate_response(struct hpi_message *phm, struct hpi_response *phr)
 u16 hpi_add_adapter(struct hpi_adapter_obj *pao)
 {
 	u16 retval = 0;
-	/*HPI_ASSERT(pao->wAdapterType); */
+	/*HPI_ASSERT(pao->type); */
 
 	hpios_alistlock_lock(&adapters);
 
@@ -77,13 +77,13 @@ u16 hpi_add_adapter(struct hpi_adapter_obj *pao)
 		goto unlock;
 	}
 
-	if (adapters.adapter[pao->index].adapter_type) {
+	if (adapters.adapter[pao->index].type) {
 		int a;
 		for (a = HPI_MAX_ADAPTERS - 1; a >= 0; a--) {
-			if (!adapters.adapter[a].adapter_type) {
+			if (!adapters.adapter[a].type) {
 				HPI_DEBUG_LOG(WARNING,
 					"ASI%X duplicate index %d moved to %d\n",
-					pao->adapter_type, pao->index, a);
+					pao->type, pao->index, a);
 				pao->index = a;
 				break;
 			}
@@ -104,13 +104,13 @@ unlock:
 
 void hpi_delete_adapter(struct hpi_adapter_obj *pao)
 {
-	if (!pao->adapter_type) {
+	if (!pao->type) {
 		HPI_DEBUG_LOG(ERROR, "removing null adapter?\n");
 		return;
 	}
 
 	hpios_alistlock_lock(&adapters);
-	if (adapters.adapter[pao->index].adapter_type)
+	if (adapters.adapter[pao->index].type)
 		adapters.gw_num_adapters--;
 	memset(&adapters.adapter[pao->index], 0, sizeof(adapters.adapter[0]));
 	hpios_alistlock_unlock(&adapters);
@@ -132,7 +132,7 @@ struct hpi_adapter_obj *hpi_find_adapter(u16 adapter_index)
 	}
 
 	pao = &adapters.adapter[adapter_index];
-	if (pao->adapter_type != 0) {
+	if (pao->type != 0) {
 		/*
 		   HPI_DEBUG_LOG(VERBOSE, "Found adapter index %d\n",
 		   wAdapterIndex);
@@ -165,7 +165,7 @@ static void subsys_get_adapter(struct hpi_message *phm,
 
 	/* find the nCount'th nonzero adapter in array */
 	for (index = 0; index < HPI_MAX_ADAPTERS; index++) {
-		if (adapters.adapter[index].adapter_type) {
+		if (adapters.adapter[index].type) {
 			if (!count)
 				break;
 			count--;
@@ -174,11 +174,11 @@ static void subsys_get_adapter(struct hpi_message *phm,
 
 	if (index < HPI_MAX_ADAPTERS) {
 		phr->u.s.adapter_index = adapters.adapter[index].index;
-		phr->u.s.adapter_type = adapters.adapter[index].adapter_type;
+		phr->u.s.adapter_type = adapters.adapter[index].type;
 	} else {
 		phr->u.s.adapter_index = 0;
 		phr->u.s.adapter_type = 0;
-		phr->error = HPI_ERROR_BAD_ADAPTER_NUMBER;
+		phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
 	}
 }
 
diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
index 67cc1b0..e441212 100644
--- a/sound/pci/asihpi/hpicmn.h
+++ b/sound/pci/asihpi/hpicmn.h
@@ -18,12 +18,15 @@
 
 */
 
+struct hpi_adapter_obj;
+
+/* a function that takes an adapter obj and returns an int */
+typedef int adapter_int_func(struct hpi_adapter_obj *pao);
+
 struct hpi_adapter_obj {
 	struct hpi_pci pci;	/* PCI info - bus#,dev#,address etc */
-	u16 adapter_type;	/* ASI6701 etc */
-	u16 index;		/* */
-	u16 open;		/* =1 when adapter open */
-	u16 mixer_open;
+	u16 type;		/* 0x6644 == ASI6644 etc */
+	u16 index;
 
 	struct hpios_spinlock dsp_lock;
 
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 75f7a2d..6091562 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -66,9 +66,7 @@ static struct hpi_adapter adapters[HPI_MAX_ADAPTERS];
 static void hpi_send_recv_f(struct hpi_message *phm, struct hpi_response *phr,
 	struct file *file)
 {
-	int adapter = phm->adapter_index;
-
-	if ((adapter >= HPI_MAX_ADAPTERS || adapter < 0)
+	if ((phm->adapter_index >= HPI_MAX_ADAPTERS)
 		&& (phm->object != HPI_OBJ_SUBSYSTEM))
 		phr->error = HPI_ERROR_INVALID_OBJ_INDEX;
 	else
@@ -179,19 +177,14 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	} else {
 		u16 __user *ptr = NULL;
 		u32 size = 0;
-		u32 adapter_present;
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
-		struct hpi_adapter *pa;
+		struct hpi_adapter *pa = NULL;
 
-		if (hm->h.adapter_index < HPI_MAX_ADAPTERS) {
+		if (hm->h.adapter_index < ARRAY_SIZE(adapters))
 			pa = &adapters[hm->h.adapter_index];
-			adapter_present = pa->type;
-		} else {
-			adapter_present = 0;
-		}
 
-		if (!adapter_present) {
+		if (!pa || !pa->adapter || !pa->adapter->type) {
 			hpi_init_response(&hr->r0, hm->h.object,
 				hm->h.function, HPI_ERROR_BAD_ADAPTER_NUMBER);
 
@@ -318,6 +311,7 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 	const struct pci_device_id *pci_id)
 {
 	int idx, nm;
+	int adapter_index;
 	unsigned int memlen;
 	struct hpi_message hm;
 	struct hpi_response hr;
@@ -346,8 +340,6 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 
 	hm.adapter_index = HPI_ADAPTER_INDEX_INVALID;
 
-	adapter.pci = pci_dev;
-
 	nm = HPI_MAX_ADAPTER_MEM_SPACES;
 
 	for (idx = 0; idx < nm; idx++) {
@@ -356,18 +348,16 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 
 		if (pci_resource_flags(pci_dev, idx) & IORESOURCE_MEM) {
 			memlen = pci_resource_len(pci_dev, idx);
-			adapter.ap_remapped_mem_base[idx] =
+			pci.ap_mem_base[idx] =
 				ioremap(pci_resource_start(pci_dev, idx),
 				memlen);
-			if (!adapter.ap_remapped_mem_base[idx]) {
+			if (!pci.ap_mem_base[idx]) {
 				HPI_DEBUG_LOG(ERROR,
 					"ioremap failed, aborting\n");
 				/* unmap previously mapped pci mem space */
 				goto err;
 			}
 		}
-
-		pci.ap_mem_base[idx] = adapter.ap_remapped_mem_base[idx];
 	}
 
 	pci.pci_dev = pci_dev;
@@ -379,6 +369,9 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 	if (hr.error)
 		goto err;
 
+	adapter_index = hr.u.s.adapter_index;
+	adapter.adapter = hpi_find_adapter(adapter_index);
+
 	if (prealloc_stream_buf) {
 		adapter.p_buffer = vmalloc(prealloc_stream_buf);
 		if (!adapter.p_buffer) {
@@ -390,36 +383,32 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 		}
 	}
 
-	adapter.index = hr.u.s.adapter_index;
-	adapter.type = hr.u.s.adapter_type;
-
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
 		HPI_ADAPTER_OPEN);
-	hm.adapter_index = adapter.index;
+	hm.adapter_index = adapter.adapter->index;
 	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
 
 	if (hr.error)
 		goto err;
 
-	adapter.snd_card_asihpi = NULL;
 	/* WARNING can't init mutex in 'adapter'
 	 * and then copy it to adapters[] ?!?!
 	 */
-	adapters[adapter.index] = adapter;
-	mutex_init(&adapters[adapter.index].mutex);
-	pci_set_drvdata(pci_dev, &adapters[adapter.index]);
+	adapters[adapter_index] = adapter;
+	mutex_init(&adapters[adapter_index].mutex);
+	pci_set_drvdata(pci_dev, &adapters[adapter_index]);
 
 	dev_printk(KERN_INFO, &pci_dev->dev,
-		"probe succeeded for ASI%04X HPI index %d\n", adapter.type,
-		adapter.index);
+		"probe succeeded for ASI%04X HPI index %d\n",
+		adapter.adapter->type, adapter_index);
 
 	return 0;
 
 err:
 	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; idx++) {
-		if (adapter.ap_remapped_mem_base[idx]) {
-			iounmap(adapter.ap_remapped_mem_base[idx]);
-			adapter.ap_remapped_mem_base[idx] = NULL;
+		if (pci.ap_mem_base[idx]) {
+			iounmap(pci.ap_mem_base[idx]);
+			pci.ap_mem_base[idx] = NULL;
 		}
 	}
 
@@ -438,19 +427,20 @@ void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
 	struct hpi_message hm;
 	struct hpi_response hr;
 	struct hpi_adapter *pa;
+	struct hpi_pci pci;
+
 	pa = pci_get_drvdata(pci_dev);
+	pci = pa->adapter->pci;
 
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
 		HPI_ADAPTER_DELETE);
-	hm.adapter_index = pa->index;
+	hm.adapter_index = pa->adapter->index;
 	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
 
 	/* unmap PCI memory space, mapped during device init. */
 	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; idx++) {
-		if (pa->ap_remapped_mem_base[idx]) {
-			iounmap(pa->ap_remapped_mem_base[idx]);
-			pa->ap_remapped_mem_base[idx] = NULL;
-		}
+		if (pci.ap_mem_base[idx])
+			iounmap(pci.ap_mem_base[idx]);
 	}
 
 	if (pa->p_buffer)
@@ -462,7 +452,7 @@ void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
 			"remove %04x:%04x,%04x:%04x,%04x," " HPI index %d.\n",
 			pci_dev->vendor, pci_dev->device,
 			pci_dev->subsystem_vendor, pci_dev->subsystem_device,
-			pci_dev->devfn, pa->index);
+			pci_dev->devfn, pa->adapter->index);
 
 	memset(pa, 0, sizeof(*pa));
 }
diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index d59a059..c5cef11 100644
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -149,20 +149,18 @@ static inline void cond_unlock(struct hpios_spinlock *l)
 #define hpios_alistlock_lock(obj) spin_lock(&((obj)->list_lock.lock))
 #define hpios_alistlock_unlock(obj) spin_unlock(&((obj)->list_lock.lock))
 
+struct snd_card;
+
+/** pci drvdata points to an instance of this struct */
 struct hpi_adapter {
+	struct hpi_adapter_obj *adapter;
+	struct snd_card *snd_card;
+
 	/* mutex prevents contention for one card
 	   between multiple user programs (via ioctl) */
 	struct mutex mutex;
-	u16 index;
-	u16 type;
-
-	/* ALSA card structure */
-	void *snd_card_asihpi;
-
 	char *p_buffer;
 	size_t buffer_size;
-	struct pci_dev *pci;
-	void __iomem *ap_remapped_mem_base[HPI_MAX_ADAPTER_MEM_SPACES];
 };
 
 #endif
-- 
1.7.0.4
