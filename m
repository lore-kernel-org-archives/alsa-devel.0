From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 1/1] ALSA: CA0132 - Ensure SCP packet is
	little-endian format
Date: Wed, 26 Sep 2012 18:23:59 -0700
Message-ID: <1348709039-4210-1-git-send-email-ian_minett@creativelabs.com>
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

Hi Takashi,
Great - good to hear the previous DSP loader patches are now living in the 
hda-ca0132-dsp branch. This patch is based on that branch, and addresses 
the SCP packet endianness.

>> The firmware does need to be reloaded when the chip loses power, so it 
>> doesn't survive S3.
>OK, we need suspend/resume hooks, too.

Do we need to do anything specific to handle this? The firmware is already 
restored upon S3 by the current caching code.

Thanks,
- Ian

---

The DSP firmware expects the SCP data to be in little-endian
format regardless of the host architecture.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

---
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2fd3121..4d7cda4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <asm/unaligned.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -701,9 +702,13 @@ static int dspio_send(struct hda_codec *codec, unsigned int reg,
 	unsigned int res;
 	int retry = 50;
 
+	/* Handling for Big Endian machine */
+	unsigned int val;
+	put_unaligned_le32(data, &val);
+
 	/* send bits of data specified by reg to dsp */
 	do {
-		res = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0, reg, data);
+		res = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0, reg, val);
 		if ((res >= 0) && (res != VENDOR_STATUS_DSPIO_BUSY))
 			return res;
 	} while (--retry);
-- 
1.7.4.1
