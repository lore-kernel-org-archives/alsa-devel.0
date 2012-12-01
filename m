From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 1/1 v2] ALSA: CA0132 - Handle endianness of SCP
	buffer data
Date: Fri, 30 Nov 2012 20:22:48 -0800
Message-ID: <1354335768-2288-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Thanks for the info - we've changed the previous unaligned access calls to 
use cpu_to_le32() and le32_to_cpu() instead for the swapping operations.

- Ian

-- 
Handle endianness of the SCP buffer being sent to or from the
DSP chip on big-endian host architectures.
The SCP buffer is prepared in dspio_scp(), and bytes are swapped 
before being transferred by the codec in dspio_send().

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2fd3121..fa19219 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -701,11 +701,15 @@ static int dspio_send(struct hda_codec *codec, unsigned int reg,
 	unsigned int res;
 	int retry = 50;
 
+	/* Handling for Big Endian machine */
+	unsigned int val = cpu_to_le32(data);
+
 	/* send bits of data specified by reg to dsp */
 	do {
-		res = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0, reg, data);
-		if ((res >= 0) && (res != VENDOR_STATUS_DSPIO_BUSY))
-			return res;
+		res = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0, reg, val);
+		val = le32_to_cpu(res);
+		if ((val >= 0) && (val != VENDOR_STATUS_DSPIO_BUSY))
+			return val;
 	} while (--retry);
 
 	return -EIO;
@@ -719,11 +723,15 @@ static void dspio_write_wait(struct hda_codec *codec)
 	int status;
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
+	/* Handling for Big Endian machine */
+	unsigned int val;
+
 	do {
 		status = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
 						VENDOR_DSPIO_STATUS, 0);
-		if ((status == VENDOR_STATUS_DSPIO_OK) ||
-		    (status == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY))
+		val = le32_to_cpu(status);
+		if ((val == VENDOR_STATUS_DSPIO_OK) ||
+		    (val == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY))
 			break;
 		msleep(1);
 	} while (time_before(jiffies, timeout));
@@ -736,6 +744,8 @@ static int dspio_write(struct hda_codec *codec, unsigned int scp_data)
 {
 	struct ca0132_spec *spec = codec->spec;
 	int status;
+	/* Handling for Big Endian machine */
+	unsigned int val = 0;
 
 	dspio_write_wait(codec);
 
@@ -751,8 +761,10 @@ static int dspio_write(struct hda_codec *codec, unsigned int scp_data)
 		goto error;
 
 	/* OK, now check if the write itself has executed*/
-	status = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
+	val = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
 				    VENDOR_DSPIO_STATUS, 0);
+	status = le32_to_cpu(val);
+
 error:
 	mutex_unlock(&spec->chipio_mutex);
 
-- 
1.7.4.1
