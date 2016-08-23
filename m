From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8810: fix compile warning in
	loopback switch control" to the asoc tree
Date: Tue, 23 Aug 2016 12:36:05 +0100
Message-ID: <E1bc9zx-0007Is-8T@debutante>
References: <1471939369-4835-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC2226640F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 13:36:15 +0200 (CEST)
In-Reply-To: <1471939369-4835-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: sfr@canb.auug.org.au, alsa-devel@alsa-project.org, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8810: fix compile warning in loopback switch control

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

>From 78822e36dca8fe8bc83e7847508891b59f3f8603 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 23 Aug 2016 16:02:49 +0800
Subject: [PATCH] ASoC: nau8810: fix compile warning in loopback switch control

Thank Stephen Rothwell for the message.
The patch is to fix the following compile error.

sound/soc/codecs/nau8810.c:441:3: error: initialization from incompatible
pointer type [-Werror=incompatible-pointer-types]
SND_SOC_DAPM_SWITCH("Digital Loopback", SND_SOC_NOPM, 0, 0,
&nau8810_loopback),
^
sound/soc/codecs/nau8810.c:441:3: note: (near initialization for
'nau8810_dapm_widgets[11].kcontrol_news')

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8810.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 7617ddad5601..f9bcdc33df84 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -391,10 +391,9 @@ static const struct snd_kcontrol_new nau8810_mic_boost_controls =
 		NAU8810_PMICBSTGAIN_SFT, 0x7, 0);
 
 /* Loopback Switch */
-static const struct snd_kcontrol_new nau8810_loopback[] = {
+static const struct snd_kcontrol_new nau8810_loopback =
 	SOC_DAPM_SINGLE("Switch", NAU8810_REG_COMP,
-		NAU8810_ADDAP_SFT, 1, 0),
-};
+		NAU8810_ADDAP_SFT, 1, 0);
 
 static int check_mclk_select_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
-- 
2.8.1
