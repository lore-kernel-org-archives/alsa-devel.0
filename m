From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH v2 3/3] ASoC: cs4265: Add a SPDIF enable switch
Date: Thu, 30 Aug 2018 09:38:02 +1000
Message-ID: <20180829233802.22032-3-flatmax@flatmax.org>
References: <20180829233802.22032-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 36CE1267837
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 01:39:32 +0200 (CEST)
In-Reply-To: <20180829233802.22032-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, ckeepax@opensource.cirrus.com
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

This patch adds a SPDIF enable switch as a SOC_SINGLE.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---

v2:
- Changed to a SOC_SINGLE call
---
 sound/soc/codecs/cs4265.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 17d7e6f0..d9eebf6a 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -154,6 +154,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
 	SOC_SINGLE("E to F Buffer Disable Switch", CS4265_SPDIF_CTL1,
 				6, 1, 0),
 	SOC_ENUM("C Data Access", cam_mode_enum),
+	SOC_SINGLE("SPDIF Switch", CS4265_SPDIF_CTL2, 5, 1, 1),
 	SOC_SINGLE("Validity Bit Control Switch", CS4265_SPDIF_CTL2,
 				3, 1, 0),
 	SOC_ENUM("SPDIF Mono/Stereo", spdif_mono_stereo_enum),
-- 
2.17.1
