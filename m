From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3060: Rename output widgets" to the
	asoc tree
Date: Wed, 14 Nov 2018 00:37:59 +0000 (GMT)
Message-ID: <20181114003759.EAAEF440079@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF90F267AEE
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 01:38:11 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3060: Rename output widgets

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 933a95496e48bde40e366a79e6dd9f9740905573 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Mon, 12 Nov 2018 08:08:34 +0100
Subject: [PATCH] ASoC: pcm3060: Rename output widgets

In the initial commit [1], I added differential output of the codec as
separate `+` and `-` widgets:

OUTL+
OUTR+
OUTL-
OUTR-

Later, in the commit [2], I added a device tree property to configure the
output as single-ended or differential. Having this property, the `+` and
`-` separation in widgets seems for me confusing. There are no functional
benefits in such separation, so I find reasonable to get rid of it:

OUTL
OUTR

The new naming is more friendly for sound cards, and is better aligned with
other codec drivers in kernel.

Renaming the output widgets now should not be a problem from the backwards-
compatibility perspective, as the driver for PCM3060 is added into the
mainline very recently, and did not yet appear in any releases.

[1] commit 6ee47d4a8dac ("ASoC: pcm3060: Add codec driver")
[2] commit a78c62de00d5 ("ASoC: pcm3060: Add DT property for single-ended
    output")

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 494d9d662be8..771b46e1974b 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -198,20 +198,16 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("OUTL+"),
-	SND_SOC_DAPM_OUTPUT("OUTR+"),
-	SND_SOC_DAPM_OUTPUT("OUTL-"),
-	SND_SOC_DAPM_OUTPUT("OUTR-"),
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL+", NULL, "Playback" },
-	{ "OUTR+", NULL, "Playback" },
-	{ "OUTL-", NULL, "Playback" },
-	{ "OUTR-", NULL, "Playback" },
+	{ "OUTL", NULL, "Playback" },
+	{ "OUTR", NULL, "Playback" },
 
 	{ "Capture", NULL, "INL" },
 	{ "Capture", NULL, "INR" },
-- 
2.19.1
