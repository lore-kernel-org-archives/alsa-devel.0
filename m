From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: sn95031: Fix control-less DAPM routes
Date: Fri, 27 Feb 2015 14:13:04 +0100
Message-ID: <1425042784-727-3-git-send-email-lars@metafoo.de>
References: <1425042784-727-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-153.synserver.de
 [212.40.185.153])
 by alsa0.perex.cz (Postfix) with ESMTP id AA42E26508C
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 14:13:09 +0100 (CET)
In-Reply-To: <1425042784-727-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Routes without a control must use NULL for the control name. The sn95031
driver uses "NULL" instead in a few places. Previous to commit 5fe5b767dc6f
("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
the DAPM core silently ignored non-NULL controls on non-mixer and non-mux
routes. But starting with that commit it will complain and not add the
route breaking the sn95031 driver in the process.

This patch replaces the incorrect "NULL" control name with NULL to fix the
issue.

Fixes: 5fe5b767dc6f ("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sn95031.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 47b257e..82095d6 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -538,8 +538,8 @@ static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	/* speaker map */
 	{ "IHFOUTL", NULL, "Speaker Rail"},
 	{ "IHFOUTR", NULL, "Speaker Rail"},
-	{ "IHFOUTL", "NULL", "Speaker Left Playback"},
-	{ "IHFOUTR", "NULL", "Speaker Right Playback"},
+	{ "IHFOUTL", NULL, "Speaker Left Playback"},
+	{ "IHFOUTR", NULL, "Speaker Right Playback"},
 	{ "Speaker Left Playback", NULL, "Speaker Left Filter"},
 	{ "Speaker Right Playback", NULL, "Speaker Right Filter"},
 	{ "Speaker Left Filter", NULL, "IHFDAC Left"},
-- 
1.8.0
