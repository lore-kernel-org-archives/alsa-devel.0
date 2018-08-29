From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH v2 1/3] ASoC: cs4265: SOC_SINGLE register value
	error fix
Date: Thu, 30 Aug 2018 09:38:00 +1000
Message-ID: <20180829233802.22032-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEFF2676BD
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 01:39:31 +0200 (CEST)
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

The cs4265 driver declares the "MMTLR Data Switch" register setting with
a 0 register value rather then the 0x12 register (CS4265_SPDIF_CTL2).
This incorrect value causes alsamixer to fault with the output :
cannot load mixer controls: Input/output error

This patch corrects the register value. alsamixer now runs.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Identical to the original v1 patch, already acked and reviewed.
---
 sound/soc/codecs/cs4265.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 275677de..15b4ae04 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -157,8 +157,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
 	SOC_SINGLE("Validity Bit Control Switch", CS4265_SPDIF_CTL2,
 				3, 1, 0),
 	SOC_ENUM("SPDIF Mono/Stereo", spdif_mono_stereo_enum),
-	SOC_SINGLE("MMTLR Data Switch", 0,
-				1, 1, 0),
+	SOC_SINGLE("MMTLR Data Switch", CS4265_SPDIF_CTL2, 0, 1, 0),
 	SOC_ENUM("Mono Channel Select", spdif_mono_select_enum),
 	SND_SOC_BYTES("C Data Buffer", CS4265_C_DATA_BUFF, 24),
 };
-- 
2.17.1
