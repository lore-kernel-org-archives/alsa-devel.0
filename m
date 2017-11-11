From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: rawmidi: Use common error handling
 code in snd_rawmidi_new()
Date: Sat, 11 Nov 2017 12:12:13 +0100
Message-ID: <4f75ca87-05bb-d32c-0691-4b7d7a8ad3da@users.sourceforge.net>
References: <d4c89bda-5091-2d3c-ded1-ba2c3b061ff6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B331266A73
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 12:12:20 +0100 (CET)
In-Reply-To: <d4c89bda-5091-2d3c-ded1-ba2c3b061ff6@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Fabian Frederick <fabf@skynet.be>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 11:36:25 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/rawmidi.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index c17f173150e9..34686000ecce 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1560,10 +1560,8 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 					 ->streams[SNDRV_RAWMIDI_STREAM_INPUT],
 					 SNDRV_RAWMIDI_STREAM_INPUT,
 					 input_count);
-	if (err < 0) {
-		snd_rawmidi_free(rmidi);
-		return err;
-	}
+	if (err < 0)
+		goto free_midi;
 
 	err =
 	    snd_rawmidi_alloc_substreams(rmidi,
@@ -1571,19 +1569,20 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 					 ->streams[SNDRV_RAWMIDI_STREAM_OUTPUT],
 					 SNDRV_RAWMIDI_STREAM_OUTPUT,
 					 output_count);
-	if (err < 0) {
-		snd_rawmidi_free(rmidi);
-		return err;
-	}
+	if (err < 0)
+		goto free_midi;
 
 	err = snd_device_new(card, SNDRV_DEV_RAWMIDI, rmidi, &ops);
-	if (err < 0) {
-		snd_rawmidi_free(rmidi);
-		return err;
-	}
+	if (err < 0)
+		goto free_midi;
+
 	if (rrawmidi)
 		*rrawmidi = rmidi;
 	return 0;
+
+free_midi:
+	snd_rawmidi_free(rmidi);
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_new);
 
-- 
2.15.0
