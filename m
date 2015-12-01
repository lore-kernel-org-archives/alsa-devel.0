From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra_alc5632: check return value" to
	the asoc tree
Date: Tue, 01 Dec 2015 22:59:44 +0000
Message-ID: <E1a3ttg-0006PG-Cv@debutante>
References: <1448966391-13996-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B352E266464
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:55 +0100 (CET)
In-Reply-To: <1448966391-13996-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra_alc5632: check return value

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

>From 319c32597fc22a58b946a6146f2be1fd208582e0 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 1 Dec 2015 16:09:51 +0530
Subject: [PATCH] ASoC: tegra_alc5632: check return value

We have been returning success even if snd_soc_card_jack_new() fails.
Lets check the return value and return error if it fails.

Fixes: 12cc6d1dca4d ("ASoC: tegra_alc5632: Register jacks at the card level")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_alc5632.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index ba272e21a6fa..deb597f7c302 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -101,12 +101,16 @@ static const struct snd_kcontrol_new tegra_alc5632_controls[] = {
 
 static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
+	int ret;
 	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
 
-	snd_soc_card_jack_new(rtd->card, "Headset Jack", SND_JACK_HEADSET,
-			      &tegra_alc5632_hs_jack,
-			      tegra_alc5632_hs_jack_pins,
-			      ARRAY_SIZE(tegra_alc5632_hs_jack_pins));
+	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+				    SND_JACK_HEADSET,
+				    &tegra_alc5632_hs_jack,
+				    tegra_alc5632_hs_jack_pins,
+				    ARRAY_SIZE(tegra_alc5632_hs_jack_pins));
+	if (ret)
+		return ret;
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
 		tegra_alc5632_hp_jack_gpio.gpio = machine->gpio_hp_det;
-- 
2.6.2
