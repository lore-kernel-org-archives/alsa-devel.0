From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Make WM8510 microphone input a DAPM
	mixer
Date: Wed,  8 Oct 2008 10:38:00 +0100
Message-ID: <1223458680-9506-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
	<1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A746244C5
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:15 +0200 (CEST)
In-Reply-To: <1223458680-9506-7-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The WM8510 microphone input PGA was represented as a DAPM PGA but in
DAPM terms the functionality is that of a mixer since it takes three
switchable inputs and produces one output. Representing it as an input
was causing its controls to be misinterpreted as gain controls and
would cause some required DAPM updates to be missed.

Reported-by: Jukka Hynninen <ext-jukka.hynninen@vaisala.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 94cab49..ea524c4 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -227,9 +227,9 @@ SND_SOC_DAPM_PGA("SpkN Out", WM8510_POWER3, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA("SpkP Out", WM8510_POWER3, 6, 0, NULL, 0),
 SND_SOC_DAPM_PGA("Mono Out", WM8510_POWER3, 7, 0, NULL, 0),
 
-SND_SOC_DAPM_PGA("Mic PGA", WM8510_POWER2, 2, 0,
-		 &wm8510_micpga_controls[0],
-		 ARRAY_SIZE(wm8510_micpga_controls)),
+SND_SOC_DAPM_MIXER("Mic PGA", WM8510_POWER2, 2, 0,
+		   &wm8510_micpga_controls[0],
+		   ARRAY_SIZE(wm8510_micpga_controls)),
 SND_SOC_DAPM_MIXER("Boost Mixer", WM8510_POWER2, 4, 0,
 	&wm8510_boost_controls[0],
 	ARRAY_SIZE(wm8510_boost_controls)),
-- 
1.5.6.5
