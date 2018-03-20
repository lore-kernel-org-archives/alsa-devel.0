From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Use single dai for da7219 playback
	and capture" to the asoc tree
Date: Tue, 20 Mar 2018 01:21:45 +0000 (GMT)
Message-ID: <20180320012145.9442E44007A@finisterre.ee.mobilebroadband>
References: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E0042672B2
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 02:21:49 +0100 (CET)
In-Reply-To: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Use single dai for da7219 playback and capture

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

>From f155181d23608acd3fb46d0d6b1507b68ffa436b Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 19 Mar 2018 11:07:41 +0530
Subject: [PATCH] ASoC: amd: Use single dai for da7219 playback and capture

BT I2S is a bi-directional dai, we will use the same
cpu dai for playback and capture.

TEST=aplay -D hw:0,0 -vv <file>
arecord -D hw:0,0 -f dat -d 5 -vv <file>

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index bbe0f103e6a8..d07c2a1d5d9e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -124,8 +124,8 @@ static struct snd_soc_ops cz_da7219_cap_ops = {
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
-		.name = "amd-da7219-play",
-		.stream_name = "Playback",
+		.name = "amd-da7219-play-cap",
+		.stream_name = "Playback and Capture",
 		.platform_name = "acp_audio_dma.0.auto",
 		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "da7219-hifi",
@@ -134,16 +134,6 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
-	},
-	{
-		.name = "amd-da7219-cap",
-		.stream_name = "Capture",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.4.auto",
-		.codec_dai_name = "da7219-hifi",
-		.codec_name = "i2c-DLGS7219:00",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_da7219_cap_ops,
 	},
-- 
2.16.2
