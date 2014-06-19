From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: cs42xx8: Make of match table static
Date: Thu, 19 Jun 2014 09:40:28 +0200
Message-ID: <1403163631-26215-3-git-send-email-lars@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 0584A265272
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 09:40:45 +0200 (CEST)
In-Reply-To: <1403163631-26215-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The cs42xx8_of_match table is not used outside of the driver, hence it can and
should be made static.

Fixes the following warning from sparse:
	sound/soc/codecs/cs42xx8.c:425:27: warning: symbol 'cs42xx8_of_match' was
	not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs42xx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index a25bc60..ec53ffc 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -422,7 +422,7 @@ const struct cs42xx8_driver_data cs42888_data = {
 };
 EXPORT_SYMBOL_GPL(cs42888_data);
 
-const struct of_device_id cs42xx8_of_match[] = {
+static const struct of_device_id cs42xx8_of_match[] = {
 	{ .compatible = "cirrus,cs42448", .data = &cs42448_data, },
 	{ .compatible = "cirrus,cs42888", .data = &cs42888_data, },
 	{ /* sentinel */ }
-- 
1.8.0
