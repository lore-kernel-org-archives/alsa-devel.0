From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dio2125: use gpiod_set_value_cansleep"
	to the asoc tree
Date: Tue, 07 Mar 2017 15:21:37 +0100
Message-ID: <E1clFzd-0006ga-4n@finisterre>
References: <20170307131222.23907-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17259266FA1
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 15:21:50 +0100 (CET)
In-Reply-To: <20170307131222.23907-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dio2125: use gpiod_set_value_cansleep

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ea2a2ad17ca1e9dbb01ac935f1b1b53f99f73b13 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 7 Mar 2017 14:12:22 +0100
Subject: [PATCH] ASoC: dio2125: use gpiod_set_value_cansleep

Use the "cansleep" variant of gpiod_set_value so the driver can be used
with slow gpio controllers as well.

Fixes: 85825d5e8869 ("ASoC: dio2125: add dio2125 amp driver")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dio2125.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/dio2125.c b/sound/soc/codecs/dio2125.c
index 015e310556d3..09451cd44f9b 100644
--- a/sound/soc/codecs/dio2125.c
+++ b/sound/soc/codecs/dio2125.c
@@ -46,7 +46,7 @@ static int drv_event(struct snd_soc_dapm_widget *w,
 		return -EINVAL;
 	}
 
-	gpiod_set_value(priv->gpiod_enable, val);
+	gpiod_set_value_cansleep(priv->gpiod_enable, val);
 
 	return 0;
 }
-- 
2.11.0
