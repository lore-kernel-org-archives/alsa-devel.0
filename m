From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH 2/3] ASoC: cs42xx8: allow IC master mode.
Date: Sat, 25 Feb 2017 16:03:13 +1100
Message-ID: <851a0a9ff20c077fc2d6ff84c1824ba462ce19ca.1487997974.git.flatmax@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta36p.bpe.bigpond.com (nsstlmta36p.bpe.bigpond.com
 [203.38.21.36]) by alsa0.perex.cz (Postfix) with ESMTP id 916472668C0
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 06:04:11 +0100 (CET)
In-Reply-To: <cover.1487997974.git.flatmax@flatmax.org>
In-Reply-To: <cover.1487997974.git.flatmax@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: flatmax@flatmax.org
Cc: hias@horus.com, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, broonie@kernel.org, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch allows the cs42xx8 to be put into slave mode when an IC
(between this codec and the SoC) is master.

It sets slave mode by treating SND_SOC_DAIFMT_IBM_IFM in the same way
it treats SND_SOC_DAIFMT_CBS_CFS.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/codecs/cs42xx8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index c1785bd..34f9adb 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -235,6 +235,7 @@ static int cs42xx8_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* Set master/slave audio interface */
 	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_IBM_IFM:
 		cs42xx8->slave_mode = true;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-- 
2.7.4
