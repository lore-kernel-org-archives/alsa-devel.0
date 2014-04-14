From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/17] ASoC: arizona: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:30:58 +0200
Message-ID: <1397503872-20864-4-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D6A2656B0
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:21 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAPM_VALUE_MUX and SOC_DAPM_VALUE_ENUM are deprecated and merely an
alias for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so
we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/arizona.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 16df0f9..05ae17f 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -107,7 +107,7 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
 #define ARIZONA_MUX_CTL_DECL(name) \
 	const struct snd_kcontrol_new name##_mux =	\
-		SOC_DAPM_VALUE_ENUM("Route", name##_enum)
+		SOC_DAPM_ENUM("Route", name##_enum)
 
 #define ARIZONA_MUX_ENUMS(name, base_reg) \
 	static ARIZONA_MUX_ENUM_DECL(name##_enum, base_reg);      \
@@ -128,7 +128,7 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MUX_ENUMS(name##_aux6, base_reg + 40)
 
 #define ARIZONA_MUX(name, ctrl) \
-	SND_SOC_DAPM_VALUE_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
+	SND_SOC_DAPM_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
 
 #define ARIZONA_MUX_WIDGETS(name, name_str) \
 	ARIZONA_MUX(name_str " Input", &name##_mux)
-- 
1.8.0
