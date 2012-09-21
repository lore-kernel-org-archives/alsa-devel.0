From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 09/10] ALSA: Update chipio functions and DSP
	write wait timeout
Date: Thu, 20 Sep 2012 20:29:20 -0700
Message-ID: <1348198161-9256-10-git-send-email-ian_minett@creativelabs.com>
References: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
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

Tidy up and condense chipio_write_address|addx() functions.
Improve dspio_write_wait() to use jiffies for timeout calc.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a7b216e..7a0425f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -460,8 +460,12 @@ static int chipio_send(struct hda_codec *codec,
 static int chipio_write_address(struct hda_codec *codec,
 				unsigned int chip_addx)
 {
+	struct ca0132_spec *spec = codec->spec;
 	int res;
 
+	if (spec->curr_chip_addx == chip_addx)
+			return 0;
+
 	/* send low 16 bits of the address */
 	res = chipio_send(codec, VENDOR_CHIPIO_ADDRESS_LOW,
 			  chip_addx & 0xffff);
@@ -472,37 +476,14 @@ static int chipio_write_address(struct hda_codec *codec,
 				  chip_addx >> 16);
 	}
 
+	spec->curr_chip_addx = (res < 0) ? ~0UL : chip_addx;
+
 	return res;
 }
 
-static int chipio_write_addx(struct hda_codec *codec, u32 chip_addx)
-{
-	struct ca0132_spec *spec = codec->spec;
-	int status;
-
-	if (spec->curr_chip_addx == chip_addx)
-		return 0;
-
-	/* send low 16 bits of the address */
-	status = chipio_send(codec, VENDOR_CHIPIO_ADDRESS_LOW,
-			  chip_addx & 0xffff);
-
-	if (status < 0)
-		return status;
-
-	/* send high 16 bits of the address */
-	status = chipio_send(codec, VENDOR_CHIPIO_ADDRESS_HIGH,
-			  chip_addx >> 16);
-
-	spec->curr_chip_addx = (status < 0) ? ~0UL : chip_addx;
-
-	return status;
-}
-
 /*
  * Write data through the vendor widget -- NOT protected by the Mutex!
  */
-
 static int chipio_write_data(struct hda_codec *codec, unsigned int data)
 {
 	int res;
@@ -604,7 +585,7 @@ static int chipio_write_multiple(struct hda_codec *codec,
 	int status;
 
 	mutex_lock(&spec->chipio_mutex);
-	status = chipio_write_addx(codec, chip_addx);
+	status = chipio_write_address(codec, chip_addx);
 	if (status < 0)
 		goto error;
 
@@ -742,18 +723,17 @@ static int dspio_send(struct hda_codec *codec, unsigned int reg,
  */
 static void dspio_write_wait(struct hda_codec *codec)
 {
-	int cur_val, prv_val;
-	int retry = 50;
+	int status;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
-	cur_val = 0;
 	do {
-		prv_val = cur_val;
-		msleep(20);
-		dspio_send(codec, VENDOR_DSPIO_SCP_POST_COUNT_QUERY, 1);
-		dspio_send(codec, VENDOR_DSPIO_STATUS, 0);
-		cur_val = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
-					   VENDOR_DSPIO_SCP_READ_COUNT, 0);
-	} while (cur_val && (cur_val == prv_val) && --retry);
+		status = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
+						VENDOR_DSPIO_STATUS, 0);
+		if ((status == VENDOR_STATUS_DSPIO_OK) ||
+		    (status == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY))
+			break;
+		msleep(1);
+	} while (time_before(jiffies, timeout));
 }
 
 /*
-- 
1.7.4.1
