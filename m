From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: es1968: Use common error handling
 code in snd_es1968_capture_open()
Date: Wed, 15 Nov 2017 10:30:37 +0100
Message-ID: <28d6e644-fe54-ecd9-6a2a-efc855299faa@users.sourceforge.net>
References: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 25773266E67
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 10:30:42 +0100 (CET)
In-Reply-To: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 09:30:00 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/es1968.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 7777ec583e20..fc45fab258c1 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1589,23 +1589,20 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct esschan *es;
-	int apu1, apu2;
+	int apu1, apu2, rc;
 
 	apu1 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_CAPTURE);
 	if (apu1 < 0)
 		return apu1;
 	apu2 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_RATECONV);
 	if (apu2 < 0) {
-		snd_es1968_free_apu_pair(chip, apu1);
-		return apu2;
+		rc = apu2;
+		goto free_first_pair;
 	}
 	
 	es = kzalloc(sizeof(*es), GFP_KERNEL);
-	if (!es) {
-		snd_es1968_free_apu_pair(chip, apu1);
-		snd_es1968_free_apu_pair(chip, apu2);
-		return -ENOMEM;
-	}
+	if (!es)
+		goto e_nomem;
 
 	es->apu[0] = apu1;
 	es->apu[1] = apu1 + 1;
@@ -1621,12 +1618,9 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 
 	/* get mixbuffer */
 	es->mixbuf = snd_es1968_new_memory(chip, ESM_MIXBUF_SIZE);
-	if (!es->mixbuf) {
-		snd_es1968_free_apu_pair(chip, apu1);
-		snd_es1968_free_apu_pair(chip, apu2);
-		kfree(es);
-                return -ENOMEM;
-        }
+	if (!es->mixbuf)
+		goto free_data;
+
 	memset(es->mixbuf->buf.area, 0, ESM_MIXBUF_SIZE);
 
 	runtime->private_data = es;
@@ -1640,6 +1634,15 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	spin_unlock_irq(&chip->substream_lock);
 
 	return 0;
+
+free_data:
+	kfree(es);
+e_nomem:
+	rc = -ENOMEM;
+	snd_es1968_free_apu_pair(chip, apu2);
+free_first_pair:
+	snd_es1968_free_apu_pair(chip, apu1);
+	return rc;
 }
 
 static int snd_es1968_playback_close(struct snd_pcm_substream *substream)
-- 
2.15.0
