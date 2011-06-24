From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Change WM9081 speaker output enable to
	_OUT_DRV
Date: Fri, 24 Jun 2011 12:45:22 +0100
Message-ID: <1308915922-27465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13CE424438
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 13:45:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.cm>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

More for neatness than any actual performance improvement.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 91c6b39..a469132 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -727,7 +727,7 @@ SND_SOC_DAPM_MIXER_NAMED_CTL("Mixer", SND_SOC_NOPM, 0, 0,
 SND_SOC_DAPM_PGA("LINEOUT PGA", WM9081_POWER_MANAGEMENT, 4, 0, NULL, 0),
 
 SND_SOC_DAPM_PGA("Speaker PGA", WM9081_POWER_MANAGEMENT, 2, 0, NULL, 0),
-SND_SOC_DAPM_PGA("Speaker", WM9081_POWER_MANAGEMENT, 1, 0, NULL, 0),
+SND_SOC_DAPM_OUT_DRV("Speaker", WM9081_POWER_MANAGEMENT, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_OUTPUT("LINEOUT"),
 SND_SOC_DAPM_OUTPUT("SPKN"),
-- 
1.7.5.4
