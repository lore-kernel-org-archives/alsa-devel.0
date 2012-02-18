From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm5100: Add DRC coefficient
	configuration
Date: Fri, 17 Feb 2012 16:49:52 -0800
Message-ID: <1329526192-6747-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120218004909.GA6712@opensource.wolfsonmicro.com>
	<1329526192-6747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2422104037
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 01:50:11 +0100 (CET)
In-Reply-To: <1329526192-6747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 74e9372..7fbcd6d 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -744,6 +744,8 @@ WM5100_MIXER_CONTROLS("EQ4", WM5100_EQ4MIX_INPUT_1_SOURCE),
 
 WM5100_MIXER_CONTROLS("DRC1L", WM5100_DRC1LMIX_INPUT_1_SOURCE),
 WM5100_MIXER_CONTROLS("DRC1R", WM5100_DRC1RMIX_INPUT_1_SOURCE),
+SND_SOC_BYTES_MASK("DRC", WM5100_DRC1_CTRL1, 5,
+		   WM5100_DRCL_ENA | WM5100_DRCR_ENA),
 
 WM5100_MIXER_CONTROLS("LHPF1", WM5100_HPLP1MIX_INPUT_1_SOURCE),
 WM5100_MIXER_CONTROLS("LHPF2", WM5100_HPLP2MIX_INPUT_1_SOURCE),
-- 
1.7.9
