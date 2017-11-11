From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: hal2: Use common error handling code
 in hal2_probe()
Date: Sat, 11 Nov 2017 19:11:55 +0100
Message-ID: <efebe781-a78c-5bec-f519-752d46661687@users.sourceforge.net>
References: <118a96d5-c52a-fd22-23d5-28f20de7ff22@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 569D9266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 19:12:02 +0100 (CET)
In-Reply-To: <118a96d5-c52a-fd22-23d5-28f20de7ff22@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 18:26:06 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/mips/hal2.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 37d378a26a50..30563d9aa5c8 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -887,21 +887,16 @@ static int hal2_probe(struct platform_device *pdev)
 		return err;
 
 	err = hal2_create(card, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	err = hal2_pcm_create(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = hal2_mixer_create(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "SGI HAL2 Audio");
 	strcpy(card->shortname, "SGI HAL2 Audio");
@@ -910,12 +905,15 @@ static int hal2_probe(struct platform_device *pdev)
 		SGI_HPCDMA_IRQ);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	platform_set_drvdata(pdev, card);
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static int hal2_remove(struct platform_device *pdev)
-- 
2.15.0
