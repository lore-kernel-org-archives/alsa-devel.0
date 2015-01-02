From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 19/21] ALSA: sonicvibes: Remove always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:53 +0100
Message-ID: <1420197895-17696-20-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id BA298260578
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:23 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

snd_sonicvibes_pcm() take a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/sonicvibes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 313a732..34cee5c 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -880,8 +880,7 @@ static struct snd_pcm_ops snd_sonicvibes_capture_ops = {
 	.pointer =	snd_sonicvibes_capture_pointer,
 };
 
-static int snd_sonicvibes_pcm(struct sonicvibes *sonic, int device,
-			      struct snd_pcm **rpcm)
+static int snd_sonicvibes_pcm(struct sonicvibes *sonic, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -902,8 +901,6 @@ static int snd_sonicvibes_pcm(struct sonicvibes *sonic, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(sonic->pci), 64*1024, 128*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -1491,7 +1488,7 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		(unsigned long long)pci_resource_start(pci, 1),
 		sonic->irq);
 
-	if ((err = snd_sonicvibes_pcm(sonic, 0, NULL)) < 0) {
+	if ((err = snd_sonicvibes_pcm(sonic, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
1.8.0
