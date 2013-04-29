From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH,
	for-next] ALSA: usb-audio: caiaq: fix endianness bug in
	snd_usb_caiaq_maschine_dispatch
Date: Mon, 29 Apr 2013 21:15:46 +0200
Message-ID: <1367262946-8980-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DAA626165E
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 21:15:54 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id y7so1826003bkt.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 12:15:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Current code does this:

  be16_to_cpu(buf[i * 2] << 8 | buf[(i * 2) + 1])

Which is effectively (neglecting the index):

  be16_to_cpu(be16_to_cpu(*((u16 *) buf)))

This means the int16 in the buffer is not converted at all.

Daniel Mack confirmed that the driver works on little endian
CPUs, leading to the conclusion that the device-side structure
is actually little endian.
This changes the code to use le16_to_cpu().

Caught by sparse.

Acked-by: Daniel Mack <zonque@gmail.com>
Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/caiaq/input.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index efc70ae..4b3fb91 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -488,13 +488,13 @@ static void snd_usb_caiaq_maschine_dispatch(struct snd_usb_caiaqdev *cdev,
 					unsigned int len)
 {
 	unsigned int i, pad_id;
-	uint16_t pressure;
+	__le16 *pressure = (__le16 *) buf;
 
 	for (i = 0; i < MASCHINE_PADS; i++) {
-		pressure = be16_to_cpu(buf[i * 2] << 8 | buf[(i * 2) + 1]);
-		pad_id = pressure >> 12;
-
-		input_report_abs(cdev->input_dev, MASCHINE_PAD(pad_id), pressure & 0xfff);
+		pad_id = le16_to_cpu(*pressure) >> 12;
+		input_report_abs(cdev->input_dev, MASCHINE_PAD(pad_id),
+				 le16_to_cpu(*pressure) & 0xfff);
+		pressure++;
 	}
 
 	input_sync(cdev->input_dev);
-- 
1.8.1.5
