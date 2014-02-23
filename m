From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] ASoC: max98090: Use
	SOC_ENUM_SINGLE_VIRT_DECL()
Date: Sun, 23 Feb 2014 16:10:16 +0100
Message-ID: <1393168221-23018-7-git-send-email-lars@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AE0265182
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 16:10:08 +0100 (CET)
In-Reply-To: <1393168221-23018-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

For the upcoming consolidation for MUXs and virtual MUXs we need to mark virtual
enums as such.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index a75752f..f363de1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -872,7 +872,7 @@ static const struct snd_kcontrol_new max98090_mic2_mux =
 
 static const char *dmic_mux_text[] = { "ADC", "DMIC" };
 
-static SOC_ENUM_SINGLE_EXT_DECL(dmic_mux_enum, dmic_mux_text);
+static SOC_ENUM_SINGLE_VIRT_DECL(dmic_mux_enum, dmic_mux_text);
 
 static const struct snd_kcontrol_new max98090_dmic_mux =
 	SOC_DAPM_ENUM_VIRT("DMIC Mux", dmic_mux_enum);
-- 
1.8.0
