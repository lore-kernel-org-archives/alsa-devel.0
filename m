From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: fm801: Rename a jump label in
 snd_card_fm801_probe()
Date: Wed, 15 Nov 2017 13:48:50 +0100
Message-ID: <1b7adfba-c554-7032-0d38-6008c9c1951e@users.sourceforge.net>
References: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F9D8266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 13:49:29 +0100 (CET)
In-Reply-To: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 13:30:07 +0100

Adjust a jump label according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/fm801.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index e4c0fa8db5f6..0eaf3297400c 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1344,7 +1344,7 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 		card->shortname, chip->port, chip->irq);
 
 	if (chip->tea575x_tuner & TUNER_ONLY)
-		goto __fm801_tuner_only;
+		goto register_card;
 
 	err = snd_fm801_pcm(chip, 0);
 	if (err < 0)
@@ -1371,7 +1371,7 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 	if (err < 0)
 		goto free_card;
 
-      __fm801_tuner_only:
+register_card:
 	err = snd_card_register(card);
 	if (err < 0)
 		goto free_card;
-- 
2.15.0
