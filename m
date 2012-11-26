From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Support higher clock rates
Date: Mon, 26 Nov 2012 16:02:06 +0000
Message-ID: <1353945726-12328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B8B32650CC
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 17:07:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some devices support higher clock rates, allow users to select these.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 909b9b2..1bc6f25 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -380,6 +380,18 @@ int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	case 49152000:
 		val |= 3 << ARIZONA_SYSCLK_FREQ_SHIFT;
 		break;
+	case 67737600:
+	case 73728000:
+		val |= 4 << ARIZONA_SYSCLK_FREQ_SHIFT;
+		break;
+	case 90316800:
+	case 98304000:
+		val |= 5 << ARIZONA_SYSCLK_FREQ_SHIFT;
+		break;
+	case 135475200:
+	case 147456000:
+		val |= 6 << ARIZONA_SYSCLK_FREQ_SHIFT;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.10.4
