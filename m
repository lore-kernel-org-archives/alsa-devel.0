From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: Free the card's DAPM context
Date: Sat, 30 Apr 2011 19:45:47 +0200
Message-ID: <1304185550-12003-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-171.synserver.de
	[212.40.185.171]) by alsa0.perex.cz (Postfix) with SMTP id 4A981244EC
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 19:46:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Free the card's DAPM context when the card is removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a823654..6a3cb53 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2047,6 +2047,8 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	if (card->remove)
 		card->remove(card);
 
+	snd_soc_dapm_free(&card->dapm);
+
 	kfree(card->rtd);
 	snd_card_free(card->snd_card);
 	return 0;
-- 
1.7.2.5
