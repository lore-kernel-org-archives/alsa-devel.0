From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/11] ASoC: Rename AT91SAMG20-EK for
	applications
Date: Wed, 18 Feb 2009 12:02:30 +0000
Message-ID: <1234958553-16049-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8B631038AC
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:18:19 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is a bit more idiomatic and makes identifying a configuration
based on the board type work better.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index ab32514..aa52423 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -273,7 +273,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 };
 
 static struct snd_soc_card snd_soc_at91sam9g20ek = {
-	.name = "WM8731",
+	.name = "AT91SAMG20-EK",
 	.platform = &atmel_soc_platform,
 	.dai_link = &at91sam9g20ek_dai,
 	.num_links = 1,
-- 
1.5.6.3
