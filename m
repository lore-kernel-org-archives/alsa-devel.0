From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: No need to update_bits when
	writing AEC clock control" to the asoc tree
Date: Tue, 26 Apr 2016 19:24:50 +0100
Message-ID: <E1av7fG-0007v4-Bu@debutante>
References: <1461686780-22885-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3ABDA26589A
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 20:25:02 +0200 (CEST)
In-Reply-To: <1461686780-22885-3-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: No need to update_bits when writing AEC clock control

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

>From 2ab8e744a437d39619b323d7303fa2e6513274b2 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 26 Apr 2016 17:06:20 +0100
Subject: [PATCH] ASoC: arizona: No need to update_bits when writing AEC clock
 control

The bits in the ARIZONA_CLOCK_CONTROL register only respond to writes of
a '1', a write of '0' is ignored. So there's no need to use update_bits.
We can do a simple write to set bits.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0caecc6f78df..0239639823b1 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1124,7 +1124,6 @@ int arizona_anc_ev(struct snd_soc_dapm_widget *w,
 		   int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	unsigned int mask = 0x3 << w->shift;
 	unsigned int val;
 
 	switch (event) {
@@ -1138,7 +1137,7 @@ int arizona_anc_ev(struct snd_soc_dapm_widget *w,
 		return 0;
 	}
 
-	snd_soc_update_bits(codec, ARIZONA_CLOCK_CONTROL, mask, val);
+	snd_soc_write(codec, ARIZONA_CLOCK_CONTROL, val);
 
 	return 0;
 }
-- 
2.8.0.rc3
