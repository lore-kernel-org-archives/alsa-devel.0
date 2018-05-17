From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH] ALSA: usb: stream: fix potential memory leak
	during uac3 interface parsing
Date: Fri, 18 May 2018 01:08:59 +0300
Message-ID: <1526594939-21084-1-git-send-email-ruslan.bilovol@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BF27E266F44
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 00:10:07 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id h9-v6so11031699lfi.0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 15:10:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

UAC3 channel map is created during interface parsing,
and in some cases was not freed in failure paths.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index bce3152..d16e1c2 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -982,13 +982,16 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 
 	dev_err(&dev->dev, "%u:%d : bogus bTerminalLink %d\n",
 			iface_no, altno, as->bTerminalLink);
+	kfree(chmap);
 	return NULL;
 
 found_clock:
 	fp = audio_format_alloc_init(chip, alts, UAC_VERSION_3, iface_no,
 				     altset_idx, altno, num_channels, clock);
-	if (!fp)
+	if (!fp) {
+		kfree(chmap);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	fp->chmap = chmap;
 
@@ -1009,6 +1012,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 							       iface_no);
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
+			kfree(fp->chmap);
 			kfree(fp->rate_table);
 			kfree(fp);
 			return NULL;
-- 
1.9.1
