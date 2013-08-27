From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] ASoC;
	wm8904: Remove unnecessary call to snd_soc_dapm_new_widgets()
Date: Tue, 27 Aug 2013 15:50:57 +0200
Message-ID: <1377611461-3638-4-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D4A260851
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:37 +0200 (CEST)
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

The core will call snd_soc_dapm_new_widgets() once all components of the card
have been initialized, so there is no need to do this manually in the driver.
Calling it earlier also might result in a partially instantiated system being
powered up which cause undesired side effects.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8904.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 91dfbfe..4dfa8dc 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1202,7 +1202,6 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 		break;
 	}
 
-	snd_soc_dapm_new_widgets(dapm);
 	return 0;
 }
 
-- 
1.8.0
