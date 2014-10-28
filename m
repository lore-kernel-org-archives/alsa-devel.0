From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: au88x0: Kill the rest snd_print*()
Date: Tue, 28 Oct 2014 17:45:15 +0100
Message-ID: <1414514715-569-4-git-send-email-tiwai@suse.de>
References: <1414514715-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D1945261ABB
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:45:17 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 82ED7ACEF
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 16:45:17 +0000 (UTC)
In-Reply-To: <1414514715-569-1-git-send-email-tiwai@suse.de>
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

Use the standard dev_*() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index e9c3833f6d44..996369134ea8 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -314,7 +314,7 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	if (snd_seq_device_new(card, 1, SNDRV_SEQ_DEV_ID_VORTEX_SYNTH,
 			       sizeof(snd_vortex_synth_arg_t), &wave) < 0
 	    || wave == NULL) {
-		snd_printk(KERN_ERR "Can't initialize Aureal wavetable synth\n");
+		dev_err(card->dev, "Can't initialize Aureal wavetable synth\n");
 	} else {
 		snd_vortex_synth_arg_t *arg;
 
-- 
2.1.2
