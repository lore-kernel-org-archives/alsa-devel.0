From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Support clearing clocks
Date: Mon, 21 Jan 2013 17:32:31 +0900
Message-ID: <1358757151-31263-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71441264F24
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 07:41:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <Liam.R.Girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some systems may wish to support switching between telephony and CD audio
clock rates but this is restricted by enforcement of constraints on the
current DAI clock. Support setting clocks to zero and don't enforce any
constraints in that case in order to facilitate this use case.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 4c2b626..8c56488 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -585,6 +585,10 @@ int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	case 147456000:
 		val |= 6 << ARIZONA_SYSCLK_FREQ_SHIFT;
 		break;
+	case 0:
+		dev_dbg(arizona->dev, "%s cleared\n", name);
+		*clk = freq;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -803,6 +807,9 @@ static int arizona_startup(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
+	if (base_rate == 0)
+		return 0;
+
 	if (base_rate % 8000)
 		constraint = &arizona_44k1_constraint;
 	else
-- 
1.7.10.4
