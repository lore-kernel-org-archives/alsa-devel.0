From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: i2c: Use common error handling code in
	two functions
Date: Sat, 11 Nov 2017 17:17:04 +0100
Message-ID: <1af701eb-c379-336f-aa00-28c30cd33d51@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A6B266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 17:17:10 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 17:10:24 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/i2c/i2c.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index ef2a9afe9e19..9292aa60f3a2 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -282,20 +282,22 @@ static int snd_i2c_bit_sendbytes(struct snd_i2c_device *device,
 		return -EIO;		/* not yet implemented */
 	snd_i2c_bit_start(bus);
 	err = snd_i2c_bit_sendbyte(bus, device->addr << 1);
-	if (err < 0) {
-		snd_i2c_bit_hw_stop(bus);
-		return err;
-	}
+	if (err < 0)
+		goto stop_bus;
+
 	while (count-- > 0) {
 		err = snd_i2c_bit_sendbyte(bus, *bytes++);
-		if (err < 0) {
-			snd_i2c_bit_hw_stop(bus);
-			return err;
-		}
+		if (err < 0)
+			goto stop_bus;
+
 		res++;
 	}
 	snd_i2c_bit_stop(bus);
 	return res;
+
+stop_bus:
+	snd_i2c_bit_hw_stop(bus);
+	return err;
 }
 
 static int snd_i2c_bit_readbytes(struct snd_i2c_device *device,
@@ -308,21 +310,23 @@ static int snd_i2c_bit_readbytes(struct snd_i2c_device *device,
 		return -EIO;		/* not yet implemented */
 	snd_i2c_bit_start(bus);
 	err = snd_i2c_bit_sendbyte(bus, (device->addr << 1) | 1);
-	if (err < 0) {
-		snd_i2c_bit_hw_stop(bus);
-		return err;
-	}
+	if (err < 0)
+		goto stop_bus;
+
 	while (count-- > 0) {
 		err = snd_i2c_bit_readbyte(bus, count == 0);
-		if (err < 0) {
-			snd_i2c_bit_hw_stop(bus);
-			return err;
-		}
+		if (err < 0)
+			goto stop_bus;
+
 		*bytes++ = (unsigned char)err;
 		res++;
 	}
 	snd_i2c_bit_stop(bus);
 	return res;
+
+stop_bus:
+	snd_i2c_bit_hw_stop(bus);
+	return err;
 }
 
 static int snd_i2c_bit_probeaddr(struct snd_i2c_bus *bus, unsigned short addr)
-- 
2.15.0
