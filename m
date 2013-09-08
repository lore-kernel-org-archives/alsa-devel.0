From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: sample rate detection
	workaround for Axe-Fx II
Date: Sun,  8 Sep 2013 18:35:19 +0200
Message-ID: <1378658119-31056-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 7711B26257D
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 18:35:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, joachim.gahl@web.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fractal Audio Systems Axe-Fx II and maybe other devices fail to return
their sample rate range descriptor when only asked for the first two
bytes.

Add a workaround and assume exactly one sample rate in this case, and
continue with the full descriptor fetch.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: Joachim Gahl <joachim.gahl@web.de>
---
 sound/usb/format.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3525231..d9de43d 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -297,13 +297,17 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 			      snd_usb_ctrl_intf(chip) | (clock << 8),
 			      tmp, sizeof(tmp));
 
-	if (ret < 0) {
-		snd_printk(KERN_ERR "%s(): unable to retrieve number of sample rates (clock %d)\n",
-				__func__, clock);
-		goto err;
-	}
+	/*
+	 * Some devices, including Fractal Audio Systems Axe-Fx II, fail to
+	 * return only a fraction of this descriptor. If that happens, assume
+	 * we have only one sample rate and continue. In case of any other
+	 * error, we will bail on the full descriptor fetch below.
+	 */
+	if (ret < 0)
+		nr_triplets = 1;
+	else
+		nr_triplets = combine_word(tmp);
 
-	nr_triplets = (tmp[1] << 8) | tmp[0];
 	data_size = 2 + 12 * nr_triplets;
 	data = kzalloc(data_size, GFP_KERNEL);
 	if (!data) {
@@ -319,8 +323,9 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 			      data, data_size);
 
 	if (ret < 0) {
-		snd_printk(KERN_ERR "%s(): unable to retrieve sample rate range (clock %d)\n",
-				__func__, clock);
+		snd_printk(KERN_ERR "%s(): unable to retrieve sample rate range "
+				    "(clock %d, nr_triplets %d)\n",
+				    __func__, clock, nr_triplets);
 		ret = -EINVAL;
 		goto err_free;
 	}
-- 
1.8.3.1
