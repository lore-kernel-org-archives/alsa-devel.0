From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8731: harmless underflow in
	wm8731_put_deemph()" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:29 +0900
Message-ID: <E1ZpOzB-0008QJ-IK@finisterre>
References: <20151013070857.GC31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34D34266B22
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:40 +0200 (CEST)
In-Reply-To: <20151013070857.GC31537@mwanda>
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

   ASoC: wm8731: harmless underflow in wm8731_put_deemph()

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

>From 523bade22428d4c6742dd7bfb4c0259a23bb9ec3 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 13 Oct 2015 10:08:57 +0300
Subject: [PATCH] ASoC: wm8731: harmless underflow in wm8731_put_deemph()

The code tries to verify that "deemph" is zero or one, but it fails to
account for that it can be negative.  It's harmless because negatives
are treated the same as one, but we should fix it just to silence the
static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8731.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index ace8645..07cf1bd 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -132,7 +132,7 @@ static int wm8731_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.integer.value[0];
+	unsigned int deemph = ucontrol->value.integer.value[0];
 	int ret = 0;
 
 	if (deemph > 1)
-- 
2.6.1
