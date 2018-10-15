From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: AMD: Add SND_JACK_LINEOUT jack type
Date: Mon, 15 Oct 2018 12:24:44 +0530
Message-ID: <1539586502-12516-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0077.outbound.protection.outlook.com [104.47.42.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C1B82675CD
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 08:56:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

Some 3 pole connectors report impedance greater than threshold of
1000Ohm. Thus, da7219 reports them as LINEOUT.
Adding the SND_JACK_LINEOUT type so that we don't fail to detect
any 3 pole jack type.
Also, changing
SND_JACK_HEADPHONE | SND_JACK_MICROPHONE -> SND_JACK_HEADSET

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 0d97d00698a0..eced4820b0bc 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -75,7 +75,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				&cz_jack, NULL, 0);
-- 
2.16.4
