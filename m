From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] sb16: request_region failure ignored in
	snd_sb16_isa_probe1()
Date: Mon, 21 Sep 2009 12:03:47 +0200
Message-ID: <4AB74F83.4030606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E81B103812
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Sep 2009 11:56:23 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so608172eye.16
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2009 02:56:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

request_region() may fail. clean up if it does,
also a release region later on was missing.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with sed: http://kernelnewbies.org/roelkluin

build, sparse and checkpatch tested.

diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 519c363..f50ed6f 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -502,6 +502,11 @@ static int __devinit snd_sb16_isa_probe1(int dev, struct device *pdev)
 	fm_port[dev] = port[dev];
 	/* block the 0x388 port to avoid PnP conflicts */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
+	if (acard->fm_res == NULL) {
+		snd_card_free(card);
+		return -ENOMEM;
+	}
+
 #ifdef SNDRV_SBAWE_EMU8000
 	/* non-PnP AWE port address is hardwired with base port address */
 	awe_port[dev] = port[dev] + 0x400;
@@ -509,6 +514,7 @@ static int __devinit snd_sb16_isa_probe1(int dev, struct device *pdev)
 
 	snd_card_set_dev(card, pdev);
 	if ((err = snd_sb16_probe(card, dev)) < 0) {
+		release_region(0x388, 4);
 		snd_card_free(card);
 		return err;
 	}
