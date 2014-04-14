From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/17] ASoC: wm5100: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:04 +0200
Message-ID: <1397503872-20864-10-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB702656BA
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:27 +0200 (CEST)
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
 sound/soc/codecs/wm5100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index eca983f..91a9ea2 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -390,7 +390,7 @@ static int wm5100_mixer_values[] = {
 
 #define WM5100_MUX_CTL_DECL(name) \
 	const struct snd_kcontrol_new name##_mux =	\
-		SOC_DAPM_VALUE_ENUM("Route", name##_enum)
+		SOC_DAPM_ENUM("Route", name##_enum)
 
 #define WM5100_MIXER_ENUMS(name, base_reg) \
 	static WM5100_MUX_ENUM_DECL(name##_in1_enum, base_reg);	     \
@@ -448,7 +448,7 @@ WM5100_MIXER_ENUMS(LHPF3, WM5100_HPLP3MIX_INPUT_1_SOURCE);
 WM5100_MIXER_ENUMS(LHPF4, WM5100_HPLP4MIX_INPUT_1_SOURCE);
 
 #define WM5100_MUX(name, ctrl) \
-	SND_SOC_DAPM_VALUE_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
+	SND_SOC_DAPM_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
 
 #define WM5100_MIXER_WIDGETS(name, name_str)	\
 	WM5100_MUX(name_str " Input 1", &name##_in1_mux), \
-- 
1.8.0
