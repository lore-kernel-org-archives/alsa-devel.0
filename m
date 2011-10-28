From: Hong Xu <hong.xu@atmel.com>
Subject: [PATCH] ASoC: WM8904: Set `invert' bit for Capture
	Switch
Date: Fri, 28 Oct 2011 15:36:39 +0800
Message-ID: <1319787399-18750-1-git-send-email-hong.xu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id B2325247B5
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Oct 2011 09:37:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Hong Xu <hong.xu@atmel.com>
List-Id: alsa-devel@alsa-project.org

Set `invert' bit for Capture Switch. Otherwise analogue is muted when
Capture Switch is ON.

Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 sound/soc/codecs/wm8904.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index b085575..cbba0b1 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -868,7 +868,7 @@ SOC_ENUM("Right Capture Mode", rin_mode),
 SOC_DOUBLE_R("Capture Volume", WM8904_ANALOGUE_LEFT_INPUT_0,
 	     WM8904_ANALOGUE_RIGHT_INPUT_0, 0, 31, 0),
 SOC_DOUBLE_R("Capture Switch", WM8904_ANALOGUE_LEFT_INPUT_0,
-	     WM8904_ANALOGUE_RIGHT_INPUT_0, 7, 1, 0),
+	     WM8904_ANALOGUE_RIGHT_INPUT_0, 7, 1, 1),
 
 SOC_SINGLE("High Pass Filter Switch", WM8904_ADC_DIGITAL_0, 4, 1, 0),
 SOC_ENUM("High Pass Filter Mode", hpf_mode),
-- 
1.7.3.3
