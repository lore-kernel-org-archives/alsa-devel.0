From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 3/7] ALSA: CA0132: Handle incoming response
	data from DSP
Date: Fri, 7 Dec 2012 21:35:59 -0800
Message-ID: <1354944963-4654-4-git-send-email-ian_minett@creativelabs.com>
References: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>


Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7856133..b971a9d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1164,6 +1164,59 @@ static int dspio_write_multiple(struct hda_codec *codec,
 	return status;
 }
 
+static int dspio_read(struct hda_codec *codec, unsigned int *data)
+{
+	int status;
+
+	status = dspio_send(codec, VENDOR_DSPIO_SCP_POST_READ_DATA, 0);
+	if (status == -EIO)
+		return status;
+
+	status = dspio_send(codec, VENDOR_DSPIO_STATUS, 0);
+	if (status == -EIO ||
+	    status == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY)
+		return -EIO;
+
+	*data = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
+				   VENDOR_DSPIO_SCP_READ_DATA, 0);
+
+	return 0;
+}
+
+static int dspio_read_multiple(struct hda_codec *codec, unsigned int *buffer,
+			       unsigned int *buf_size, unsigned int size_count)
+{
+	int status = 0;
+	unsigned int size = *buf_size;
+	unsigned int count;
+	unsigned int skip_count;
+	unsigned int dummy;
+
+	if ((buffer == NULL))
+		return -1;
+
+	count = 0;
+	while (count < size && count < size_count) {
+		status = dspio_read(codec, buffer++);
+		if (status != 0)
+			break;
+		count++;
+	}
+
+	skip_count = count;
+	if (status == 0) {
+		while (skip_count < size) {
+			status = dspio_read(codec, &dummy);
+			if (status != 0)
+				break;
+			skip_count++;
+		}
+	}
+	*buf_size = count;
+
+	return status;
+}
+
 /*
  * Construct the SCP header using corresponding fields
  */
@@ -1223,6 +1276,38 @@ struct scp_msg {
 	unsigned int data[SCP_MAX_DATA_WORDS];
 };
 
+static void dspio_clear_response_queue(struct hda_codec *codec)
+{
+	unsigned int dummy = 0;
+	int status = -1;
+
+	/* clear all from the response queue */
+	do {
+		status = dspio_read(codec, &dummy);
+	} while (status == 0);
+}
+
+static int dspio_get_response_data(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int data = 0;
+	unsigned int count;
+
+	if (dspio_read(codec, &data) < 0)
+		return -EIO;
+
+	if ((data & 0x00ffffff) == spec->wait_scp_header) {
+		spec->scp_resp_header = data;
+		spec->scp_resp_count = data >> 27;
+		count = spec->wait_num_data;
+		dspio_read_multiple(codec, spec->scp_resp_data,
+				    &spec->scp_resp_count, count);
+		return 0;
+	}
+
+	return -EIO;
+}
+
 /*
  * Send SCP message to DSP
  */
@@ -4118,6 +4203,47 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 		ca0132_set_dsp_msr(codec, true);
 }
 
+static void ca0132_process_dsp_response(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	snd_printdd(KERN_INFO "ca0132_process_dsp_response\n");
+	if (spec->wait_scp) {
+		if (dspio_get_response_data(codec) >= 0)
+			spec->wait_scp = 0;
+	}
+
+	dspio_clear_response_queue(codec);
+}
+
+static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	snd_printdd(KERN_INFO "ca0132_unsol_event: 0x%x\n", res);
+
+
+	if (((res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f) == UNSOL_TAG_DSP) {
+		ca0132_process_dsp_response(codec);
+	} else {
+		res = snd_hda_jack_get_action(codec,
+				(res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f);
+
+		snd_printdd(KERN_INFO "snd_hda_jack_get_action: 0x%x\n", res);
+
+		switch (res) {
+		case UNSOL_TAG_HP:
+			ca0132_select_out(codec);
+			snd_hda_jack_report_sync(codec);
+			break;
+		case UNSOL_TAG_AMIC1:
+			ca0132_select_mic(codec);
+			snd_hda_jack_report_sync(codec);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static int ca0132_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -4182,6 +4308,7 @@ static struct hda_codec_ops ca0132_patch_ops = {
 	.build_pcms = ca0132_build_pcms,
 	.init = ca0132_init,
 	.free = ca0132_free,
+	.unsol_event = ca0132_unsol_event,
 };
 
 
-- 
1.7.4.1
