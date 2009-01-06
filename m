From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Use snd_soc_dapm_nc_pin() in
	at91sam9g20ek
Date: Tue,  6 Jan 2009 15:00:03 +0000
Message-ID: <1231254004-13002-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090106145837.GB12803@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB96210380C
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 16:00:05 +0100 (CET)
In-Reply-To: <20090106145837.GB12803@rakim.wolfsonmicro.main>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 1fb59a9..6ea04be 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -221,8 +221,8 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
 
 	/* not connected */
-	snd_soc_dapm_disable_pin(codec, "RLINEIN");
-	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+	snd_soc_dapm_nc_pin(codec, "RLINEIN");
+	snd_soc_dapm_nc_pin(codec, "LLINEIN");
 
 	/* always connected */
 	snd_soc_dapm_enable_pin(codec, "Int Mic");
-- 
1.5.6.5
