From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: Do a warm reset after cold when
	resetting the WM9713
Date: Thu, 30 Oct 2008 15:58:27 +0000
Message-ID: <1225382309-1827-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030155718.GA1418@rakim.wolfsonmicro.main>
	<1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C418024493
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:58:31 +0100 (CET)
In-Reply-To: <1225382309-1827-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The WM9713 comes out of cold reset in low power mode so always requires
a warm reset to bring up the AC97 link after a cold reset.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index aba402b..3214aa5 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1097,6 +1097,8 @@ int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 	}
 
 	soc_ac97_ops.reset(codec->ac97);
+	if (soc_ac97_ops.warm_reset)
+		soc_ac97_ops.warm_reset(codec->ac97);
 	if (ac97_read(codec, 0) != wm9713_reg[0])
 		return -EIO;
 	return 0;
-- 
1.5.6.5
