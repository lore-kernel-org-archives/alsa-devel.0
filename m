From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] ASoC: mc13783: Use
	SOC_ENUM_SINGLE_VIRT_DECL()
Date: Sun, 23 Feb 2014 16:10:17 +0100
Message-ID: <1393168221-23018-8-git-send-email-lars@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id A2320265184
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 16:10:10 +0100 (CET)
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
 sound/soc/codecs/mc13783.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index c605036..ec89b8f 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -408,8 +408,7 @@ static const char * const adcl_enum_text[] = {
 	"MC1L", "RXINL",
 };
 
-static SOC_ENUM_SINGLE_DECL(adcl_enum,
-			    0, 0, adcl_enum_text);
+static SOC_ENUM_SINGLE_VIRT_DECL(adcl_enum, adcl_enum_text);
 
 static const struct snd_kcontrol_new left_input_mux =
 	SOC_DAPM_ENUM_VIRT("Route", adcl_enum);
@@ -418,8 +417,7 @@ static const char * const adcr_enum_text[] = {
 	"MC1R", "MC2", "RXINR", "TXIN",
 };
 
-static SOC_ENUM_SINGLE_DECL(adcr_enum,
-			    0, 0, adcr_enum_text);
+static SOC_ENUM_SINGLE_VIRT_DECL(adcr_enum, adcr_enum_text);
 
 static const struct snd_kcontrol_new right_input_mux =
 	SOC_DAPM_ENUM_VIRT("Route", adcr_enum);
-- 
1.8.0
