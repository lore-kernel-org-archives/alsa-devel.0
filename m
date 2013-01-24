From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Add support for platform and CODEC
	drivers on same device
Date: Thu, 24 Jan 2013 09:49:11 +0000
Message-ID: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43F212615D0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:51:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently DAI playback and capture widgets are created during
soc_probe_codec and soc_probe_platform, using the device associated with
the DAI to check which widgets should be created. If a device registers
both a CODEC and platform driver this leads the CODEC playback and
capture widgets being overwritten by the widgets created by the platform
probe.

It is more sensible to retain the CODEC widgets as the most common use
case for registering both a CODEC and platform driver on the same chip
is a CODEC which contains a DSP for compressed playback. In this
situation it is more sensible to attach the routing information to the
CODEC and add a thin platform driver interface to link into the
compressed API.

So this patch will check for existing widgets during soc_probe_platform
and only create new widgets if no existing ones exist.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 04af2a6..53efe1d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1159,7 +1159,8 @@ static int soc_probe_platform(struct snd_soc_card *card,
 
 	/* Create DAPM widgets for each DAI stream */
 	list_for_each_entry(dai, &dai_list, list) {
-		if (dai->dev != platform->dev)
+		if (dai->dev != platform->dev ||
+		    dai->playback_widget || dai->capture_widget)
 			continue;
 
 		snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
-- 
1.7.2.5
