From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] AMD Au1x00: fix DMA init/cleanup
Date: Tue, 21 Mar 2006 03:59:23 +0300
Message-ID: <441F4FEB.6060806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080900060407000702020209"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080900060407000702020209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Reposting with signoff which I constantly forget about... :-/

    AMD Au1x00 ALSA driver causes kernel oops in au1000_init() by trying to
set DMA channel to -1 in yet unallocated audio streams. Here's the patch that
staightens up DMA init/cleanup code.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080900060407000702020209
Content-Type: text/plain;
 name="Au1x00-ALSA-fix-DMA-init-and-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1x00-ALSA-fix-DMA-init-and-cleanup.patch"

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 6d8f8b3..a7a221a 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -610,14 +610,17 @@ snd_au1000_free(struct snd_card *card)
 		release_and_free_resource(au1000->ac97_res_port);
 	}
 
-	if (au1000->stream[PLAYBACK]->dma >= 0)
-		free_au1000_dma(au1000->stream[PLAYBACK]->dma);
-
-	if (au1000->stream[CAPTURE]->dma >= 0)
-		free_au1000_dma(au1000->stream[CAPTURE]->dma);
+	if (au1000->stream[PLAYBACK]) {
+	  	if (au1000->stream[PLAYBACK]->dma >= 0)
+			free_au1000_dma(au1000->stream[PLAYBACK]->dma);
+		kfree(au1000->stream[PLAYBACK]);
+	}
 
-	kfree(au1000->stream[PLAYBACK]);
-	kfree(au1000->stream[CAPTURE]);
+	if (au1000->stream[CAPTURE]) {
+		if (au1000->stream[CAPTURE]->dma >= 0)
+			free_au1000_dma(au1000->stream[CAPTURE]->dma);
+		kfree(au1000->stream[CAPTURE]);
+	}
 }
 
 
@@ -636,15 +630,19 @@ au1000_init(void)
 
 	card->private_free = snd_au1000_free;
 	au1000 = card->private_data;
-	/* so that snd_au1000_free will work as intended */
 	au1000->card = card;
-	au1000->stream[PLAYBACK]->dma = -1;
-	au1000->stream[CAPTURE]->dma = -1;
- 	au1000->ac97_res_port = NULL;
+
 	au1000->stream[PLAYBACK] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
-	au1000->stream[CAPTURE] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
+	au1000->stream[CAPTURE ] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
+	/* so that snd_au1000_free will work as intended */
+ 	au1000->ac97_res_port = NULL;
+	if (au1000->stream[PLAYBACK])
+		au1000->stream[PLAYBACK]->dma = -1;
+	if (au1000->stream[CAPTURE ])
+		au1000->stream[CAPTURE ]->dma = -1;
+
 	if (au1000->stream[PLAYBACK] == NULL ||
-	    au1000->stream[CAPTURE] == NULL) {
+	    au1000->stream[CAPTURE ] == NULL) {
 		snd_card_free(card);
 		return -ENOMEM;
 	}




--------------080900060407000702020209--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
