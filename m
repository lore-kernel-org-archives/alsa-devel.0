From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: ca0106: Delete an error message for a
 failed memory allocation in snd_ca0106_pcm_open_capture_channel()
Date: Sat, 12 Aug 2017 19:15:58 +0200
Message-ID: <73511244-b12e-9756-6a46-89d9c56c75dc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3241E26701A
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 19:16:05 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 19:09:23 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ca0106/ca0106_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 6165a57a94ae..b7783137af04 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -660,11 +660,9 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
 	int err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
-	if (epcm == NULL) {
-		dev_err(chip->card->dev,
-			"open_capture_channel: failed epcm alloc\n");
+	if (!epcm)
 		return -ENOMEM;
-        }
+
 	epcm->emu = chip;
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
-- 
2.14.0
