From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] ASoC: jack: Remove unnecessary call to
	snd_soc_dapm_new_widgets()
Date: Tue, 27 Aug 2013 15:50:58 +0200
Message-ID: <1377611461-3638-5-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B60F260856
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:38 +0200 (CEST)
In-Reply-To: <1377611461-3638-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

snd_soc_jack_add_pins() does not create any new DAPM widgets, so there is no
need to call snd_soc_dapm_new_widgets().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-jack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7aa26b5..71358e3 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -183,8 +183,6 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 		list_add(&(pins[i].list), &jack->pins);
 	}
 
-	snd_soc_dapm_new_widgets(&jack->codec->card->dapm);
-
 	/* Update to reflect the last reported status; canned jack
 	 * implementations are likely to set their state before the
 	 * card has an opportunity to associate pins.
-- 
1.8.0
