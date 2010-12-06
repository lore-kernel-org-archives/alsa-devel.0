From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Fix swap of left and right channels
	for WM8993/4 speaker boost gain
Date: Mon,  6 Dec 2010 11:12:27 +0000
Message-ID: <1291633947-12997-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1291633947-12997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FBCB103875
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 12:12:23 +0100 (CET)
In-Reply-To: <1291633947-12997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Uk Kim <w0806.kim@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Uk Kim <w0806.kim@samsung.com>

SPKOUTL_BOOST start from third bit, SPKOUTLR_BOOST start from 0 bit.

Signed-off-by: Uk Kim <w0806.kim@samsung.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 19ca782..0e24092 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -293,7 +293,7 @@ SOC_DOUBLE_R("Speaker Switch",
 SOC_DOUBLE_R("Speaker ZC Switch",
 	     WM8993_SPEAKER_VOLUME_LEFT, WM8993_SPEAKER_VOLUME_RIGHT,
 	     7, 1, 0),
-SOC_DOUBLE_TLV("Speaker Boost Volume", WM8993_SPKOUT_BOOST, 0, 3, 7, 0,
+SOC_DOUBLE_TLV("Speaker Boost Volume", WM8993_SPKOUT_BOOST, 3, 0, 7, 0,
 	       spkboost_tlv),
 SOC_ENUM("Speaker Reference", speaker_ref),
 SOC_ENUM("Speaker Mode", speaker_mode),
-- 
1.7.2.3
