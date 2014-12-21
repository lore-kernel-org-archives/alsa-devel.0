From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: dapm: Don't mark MICBIAS widgets as
	auto non-connected
Date: Sun, 21 Dec 2014 11:05:43 +0100
Message-ID: <1419156344-25472-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-115.synserver.de (smtp-out-117.synserver.de
 [212.40.185.117])
 by alsa0.perex.cz (Postfix) with ESMTP id BB03226058D
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 11:05:48 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

The connected flag of a widget only affects widgets that are either a source
or a sink. The MICBIAS widget is a simple pass-through widget though and
hence its behavior is the same regardless of whether the connected flag is
set or not.

Hence there is not much point in trying to automatically mark MICBIAS
widgets as non-connected, so just remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5136bb..b8eba93 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3880,7 +3880,6 @@ void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card)
 		switch (w->id) {
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
-		case snd_soc_dapm_micbias:
 			dev_dbg(card->dev, "ASoC: Auto NC: Checking widget %s\n",
 				w->name);
 			if (!snd_soc_dapm_widget_in_card_paths(card, w)) {
-- 
1.8.0
