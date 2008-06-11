From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/10] ASoC: Fix WM9713 voice PCM slave mode
	configuration
Date: Wed, 11 Jun 2008 13:47:11 +0100
Message-ID: <1213188435-1986-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E29E24830
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:18 +0200 (CEST)
In-Reply-To: <1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Reported-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 4f516a5..aba3301 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -876,7 +876,7 @@ static int wm9713_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 		gpio |= 0x0018;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		reg |= 0x0200;
+		reg |= 0x2000;
 		gpio |= 0x001a;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-- 
1.5.5.3
