From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/24] usb: gadget: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:40 +0100
Message-ID: <1392201340-27113-25-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D042265051
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BCFD8AC9C
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/f_midi.c | 7 +++----
 drivers/usb/gadget/f_uac2.c | 4 +---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/f_midi.c b/drivers/usb/gadget/f_midi.c
index 36d4bb23087f..807b31c0edc3 100644
--- a/drivers/usb/gadget/f_midi.c
+++ b/drivers/usb/gadget/f_midi.c
@@ -664,9 +664,10 @@ static int f_midi_register_card(struct f_midi *midi)
 		.dev_free = f_midi_snd_free,
 	};
 
-	err = snd_card_create(midi->index, midi->id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&midi->gadget->dev, midi->index, midi->id,
+			   THIS_MODULE, 0, &card);
 	if (err < 0) {
-		ERROR(midi, "snd_card_create() failed\n");
+		ERROR(midi, "snd_card_new() failed\n");
 		goto fail;
 	}
 	midi->card = card;
@@ -703,8 +704,6 @@ static int f_midi_register_card(struct f_midi *midi)
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &gmidi_in_ops);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &gmidi_out_ops);
 
-	snd_card_set_dev(card, &midi->gadget->dev);
-
 	/* register it - we're ready to go */
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/drivers/usb/gadget/f_uac2.c b/drivers/usb/gadget/f_uac2.c
index 2f23566e53d8..bc23040c7790 100644
--- a/drivers/usb/gadget/f_uac2.c
+++ b/drivers/usb/gadget/f_uac2.c
@@ -394,7 +394,7 @@ static int snd_uac2_probe(struct platform_device *pdev)
 	int err;
 
 	/* Choose any slot, with no id */
-	err = snd_card_create(-1, NULL, THIS_MODULE, 0, &card);
+	err = snd_card_new(&pdev->dev, -1, NULL, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -421,8 +421,6 @@ static int snd_uac2_probe(struct platform_device *pdev)
 	strcpy(card->shortname, "UAC2_Gadget");
 	sprintf(card->longname, "UAC2_Gadget %i", pdev->id);
 
-	snd_card_set_dev(card, &pdev->dev);
-
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 		snd_dma_continuous_data(GFP_KERNEL), 0, BUFF_SIZE_MAX);
 
-- 
1.8.5.2
