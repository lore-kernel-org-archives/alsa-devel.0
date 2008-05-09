From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH v2.6.26-rc1] ASoC: Fix TLV320AIC3X mono line
	output interconnect
Date: Fri,  9 May 2008 13:13:38 +0100
Message-ID: <1210335218-15832-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41EE724464
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 14:13:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

There is no endpoint called MONOLOUT but MONO_LOUT.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6e4bc69..957996e 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -553,8 +553,8 @@ static const char *intercon[][3] = {
 	{"HPRCOM", NULL, "Right HP Com"},
 
 	/* Mono Output */
-	{"MONOLOUT", NULL, "Mono Out"},
-	{"MONOLOUT", NULL, "Mono Out"},
+	{"MONO_LOUT", NULL, "Mono Out"},
+	{"MONO_LOUT", NULL, "Mono Out"},
 
 	/* Left Input */
 	{"Left Line1L Mux", "single-ended", "LINE1L"},
-- 
1.5.5.1
