From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcsp: Fix the order of input device
	unregistration
Date: Thu, 14 Nov 2013 15:49:59 +0100
Message-ID: <1384440599-29274-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BC36D26519F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 15:49:59 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9B208A79B1
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 15:49:59 +0100 (CET)
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

The current code may access to the already freed object.  The input
device must be accessed and unregistered before freeing the top level
sound object.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/pcsp/pcsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index f664bae3b9b0..328bd29264ce 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -188,8 +188,8 @@ static int pcsp_probe(struct platform_device *dev)
 static int pcsp_remove(struct platform_device *dev)
 {
 	struct snd_pcsp *chip = platform_get_drvdata(dev);
-	alsa_card_pcsp_exit(chip);
 	pcspkr_input_remove(chip->input_dev);
+	alsa_card_pcsp_exit(chip);
 	return 0;
 }
 
-- 
1.8.4.2
