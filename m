From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8985: Use the correct macro for the
	kcontrol defined
Date: Mon, 27 Sep 2010 11:16:30 +0100
Message-ID: <1285582590-30770-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB1D624368
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 12:16:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Since we are using custom get/put handlers
use SOC_ENUM_SINGLE_EXT_DECL instead of the original SOC_ENUM_SINGLE_DECL
macro.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8985.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index b94af96..09660b3 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -185,8 +185,8 @@ static const SOC_ENUM_SINGLE_DECL(filter_mode, WM8985_ADC_CONTROL, 7,
 
 static const char *eq_bw_text[] = { "Narrow", "Wide" };
 static const char *eqmode_text[] = { "Capture", "Playback" };
-static const SOC_ENUM_SINGLE_DECL(eqmode, WM8985_EQ1_LOW_SHELF, 8,
-				  eqmode_text);
+static const SOC_ENUM_SINGLE_EXT_DECL(eqmode, eqmode_text);
+
 static const char *eq1_cutoff_text[] = {
 	"80Hz", "105Hz", "135Hz", "175Hz"
 };
-- 
1.7.3
