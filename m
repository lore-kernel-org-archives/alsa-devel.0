From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: arizona: add defines for
	single-input gain control
Date: Tue, 21 Apr 2015 13:33:50 +0100
Message-ID: <1429619636-25478-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7461266085
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 14:33:28 +0200 (CEST)
In-Reply-To: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Adds convenience defines for declaring a gain control that
has an input mux. These block are functionally equivalent to
the existing mixer blocks but only have a single input.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 11ff899..6559ca0 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -92,6 +92,11 @@ extern const unsigned int arizona_mixer_tlv[];
 extern const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
 extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
+#define ARIZONA_GAINMUX_CONTROLS(name, base) \
+	SOC_SINGLE_RANGE_TLV(name " Input Volume", base + 1,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv)
+
 #define ARIZONA_MIXER_CONTROLS(name, base) \
 	SOC_SINGLE_RANGE_TLV(name " Input 1 Volume", base + 1,		\
 			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
-- 
1.7.2.5
