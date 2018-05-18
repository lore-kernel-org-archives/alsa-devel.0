From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2200,
	wm5100: fix spelling mistake: "Coefficeints" -> "Coefficients"" to
	the asoc tree
Date: Fri, 18 May 2018 10:22:03 +0100
Message-ID: <E1fJbaN-0007u5-5s@debutante>
References: <20180518091327.17705-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 016B1266F44
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 11:22:22 +0200 (CEST)
In-Reply-To: <20180518091327.17705-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2200,wm5100: fix spelling mistake: "Coefficeints" -> "Coefficients"

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

>From 57b70db28bd373039027b31d5c6a9af5369eb3e6 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 18 May 2018 10:13:27 +0100
Subject: [PATCH] ASoC: wm2200,wm5100: fix spelling mistake: "Coefficeints" ->
 "Coefficients"

Trivial fix to spelling mistakes in SND_SOC_BYTES literal strings

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2200.c | 4 ++--
 sound/soc/codecs/wm5100.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index d5f4bbf27182..3663b9fd4d65 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1155,8 +1155,8 @@ SOC_DOUBLE_R_TLV("IN3 Digital Volume", WM2200_ADC_DIGITAL_VOLUME_3L,
 SND_SOC_BYTES_MASK("EQL Coefficients", WM2200_EQL_1, 20, WM2200_EQL_ENA),
 SND_SOC_BYTES_MASK("EQR Coefficients", WM2200_EQR_1, 20, WM2200_EQR_ENA),
 
-SND_SOC_BYTES("LHPF1 Coefficeints", WM2200_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficeints", WM2200_HPLPF2_2, 1),
+SND_SOC_BYTES("LHPF1 Coefficients", WM2200_HPLPF1_2, 1),
+SND_SOC_BYTES("LHPF2 Coefficients", WM2200_HPLPF2_2, 1),
 
 SOC_SINGLE("OUT1 High Performance Switch", WM2200_DAC_DIGITAL_VOLUME_1L,
 	   WM2200_OUT1_OSR_SHIFT, 1, 0),
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 87f9a99ce978..ba89d9d711f7 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -573,10 +573,10 @@ SND_SOC_BYTES_MASK("EQ4 Coefficients", WM5100_EQ4_1, 20, WM5100_EQ4_ENA),
 SND_SOC_BYTES_MASK("DRC Coefficients", WM5100_DRC1_CTRL1, 5,
 		   WM5100_DRCL_ENA | WM5100_DRCR_ENA),
 
-SND_SOC_BYTES("LHPF1 Coefficeints", WM5100_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficeints", WM5100_HPLPF2_2, 1),
-SND_SOC_BYTES("LHPF3 Coefficeints", WM5100_HPLPF3_2, 1),
-SND_SOC_BYTES("LHPF4 Coefficeints", WM5100_HPLPF4_2, 1),
+SND_SOC_BYTES("LHPF1 Coefficients", WM5100_HPLPF1_2, 1),
+SND_SOC_BYTES("LHPF2 Coefficients", WM5100_HPLPF2_2, 1),
+SND_SOC_BYTES("LHPF3 Coefficients", WM5100_HPLPF3_2, 1),
+SND_SOC_BYTES("LHPF4 Coefficients", WM5100_HPLPF4_2, 1),
 
 SOC_SINGLE("HPOUT1 High Performance Switch", WM5100_OUT_VOLUME_1L,
 	   WM5100_OUT1_OSR_SHIFT, 1, 0),
-- 
2.17.0
