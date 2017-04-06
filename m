From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: codec: wm8960: Stop when a matching
	PLL freq is found
Date: Thu, 6 Apr 2017 14:51:53 +0300
Message-ID: <1491479514-24862-2-git-send-email-daniel.baluta@nxp.com>
References: <1491479514-24862-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50065.outbound.protection.outlook.com [40.107.5.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8516E2672AE
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 13:52:08 +0200 (CEST)
In-Reply-To: <1491479514-24862-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, shengjiu.wang@nxp.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When a matching PLL freq is found, searching continues even this is
not necessary. The problem was introduced with the following refactoring
commit 84fdc00d519ffd ("ASoC: codec: wm9860: Refactor PLL out freq search)

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/codecs/wm8960.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 36c8454..ace69da 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -724,7 +724,11 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 					break;
 				}
 			}
+			if (k != ARRAY_SIZE(bclk_divs))
+				break;
 		}
+		if (j != ARRAY_SIZE(dac_divs))
+			break;
 	}
 
 	if (*bclk_idx != -1)
-- 
2.7.4
