From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2000: a couple harmless underflows"
	to the asoc tree
Date: Fri, 23 Oct 2015 08:09:15 +0900
Message-ID: <E1ZpOyx-0008Nw-Bp@finisterre>
References: <20151013071245.GI31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D592266B1A
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:30 +0200 (CEST)
In-Reply-To: <20151013071245.GI31537@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2000: a couple harmless underflows

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

>From 8444f59fd7bd8aa079609e575c0688669b85bfcc Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 13 Oct 2015 10:12:45 +0300
Subject: [PATCH] ASoC: wm2000: a couple harmless underflows

We want these to be zero or one, but by mistake we also accept negative
values.  It's harmless but we should still clean it up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 786abd0..a67ea10 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -620,7 +620,7 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
-	int anc_active = ucontrol->value.integer.value[0];
+	unsigned int anc_active = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (anc_active > 1)
@@ -653,7 +653,7 @@ static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
-	int val = ucontrol->value.integer.value[0];
+	unsigned int val = ucontrol->value.integer.value[0];
 	int ret;
 
 	if (val > 1)
-- 
2.6.1
