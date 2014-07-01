From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/2] ALSA: trident: Remove unused variable in
	trident_main.c
Date: Tue,  1 Jul 2014 10:10:29 +0530
Message-ID: <1404189630-5795-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D98E7261B31
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 06:43:59 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id eu11so9904436pac.11
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 21:43:58 -0700 (PDT)
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
Cc: tiwai@suse.de, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

'private_data' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/pci/trident/trident_main.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 1272c18a2544..da875dced2ef 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3880,14 +3880,12 @@ void snd_trident_free_voice(struct snd_trident * trident, struct snd_trident_voi
 {
 	unsigned long flags;
 	void (*private_free)(struct snd_trident_voice *);
-	void *private_data;
 
 	if (voice == NULL || !voice->use)
 		return;
 	snd_trident_clear_voices(trident, voice->number, voice->number);
 	spin_lock_irqsave(&trident->voice_alloc, flags);
 	private_free = voice->private_free;
-	private_data = voice->private_data;
 	voice->private_free = NULL;
 	voice->private_data = NULL;
 	if (voice->pcm)
-- 
1.7.9.5
