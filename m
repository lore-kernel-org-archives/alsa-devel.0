From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2 1/3] ASoC: AMD: Use single dai for da7219
	playback and capture
Date: Mon, 19 Mar 2018 11:07:41 +0530
Message-ID: <1521437863-12389-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0064.outbound.protection.outlook.com [104.47.34.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 122F2267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 06:53:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

BT I2S is a bi-directional dai, we will use the same
cpu dai for playback and capture.

V2: reworded the commit message.

TEST=aplay -D hw:0,0 -vv <file>
arecord -D hw:0,0 -f dat -d 5 -vv <file>

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index bbe0f10..d07c2a1 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -124,8 +124,8 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
-		.name = "amd-da7219-play",
-		.stream_name = "Playback",
+		.name = "amd-da7219-play-cap",
+		.stream_name = "Playback and Capture",
 		.platform_name = "acp_audio_dma.0.auto",
 		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "da7219-hifi",
@@ -134,16 +134,6 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
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
1.9.1
