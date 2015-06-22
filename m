From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH asoc] ASoC: gtm601_dai can be static
Date: Mon, 22 Jun 2015 23:48:25 +0800
Message-ID: <20150622154825.GA64261@lkp-sb04.intel.com>
References: <201506222333.SOsGGlVC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201506222333.SOsGGlVC%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 gtm601.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 1b77ff2..305452e 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -33,7 +33,7 @@ static const struct snd_soc_dapm_route gtm601_dapm_routes[] = {
 	{ "Capture", NULL, "AIN" },
 };
 
-struct snd_soc_dai_driver gtm601_dai = {
+static struct snd_soc_dai_driver gtm601_dai = {
 	.name = "gtm601",
 	.playback = {
 		.stream_name = "Playback",
