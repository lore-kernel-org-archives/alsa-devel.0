From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opl3sa2 fix irq releasing and short name of
	card
Date: Fri, 27 Feb 2009 21:41:40 +0100
Message-ID: <20090227214140.78b37fcf.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 617831037EB
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2009 21:36:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Two simple fixes:

1. Use the same pointer for the free_irq() and
   the request_irq() calls.

2. A short name of card is appended with '2' or '3'
   character depending on a detected chip. Remove 
   the '2' character from the short name.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The short name without the patch is "OPL3-SA23"
for opl3-sa3.

 sound/isa/opl3sa2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 58c972b..9a53ab4 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -613,7 +613,7 @@ static void snd_opl3sa2_free(struct snd_card *card)
 {
 	struct snd_opl3sa2 *chip = card->private_data;
 	if (chip->irq >= 0)
-		free_irq(chip->irq, (void *)chip);
+		free_irq(chip->irq, card);
 	release_and_free_resource(chip->res_port);
 }
 
@@ -626,7 +626,7 @@ static struct snd_card *snd_opl3sa2_card_new(int dev)
 	if (card == NULL)
 		return NULL;
 	strcpy(card->driver, "OPL3SA2");
-	strcpy(card->shortname, "Yamaha OPL3-SA2");
+	strcpy(card->shortname, "Yamaha OPL3-SA");
 	chip = card->private_data;
 	spin_lock_init(&chip->reg_lock);
 	chip->irq = -1;
-- 
1.5.2.2



----------------------------------------------------------------------
169 stacji TV! Naziemne i satelitarne!
Sprawdz program TV w kilka sekund >> http://link.interia.pl/f2050
