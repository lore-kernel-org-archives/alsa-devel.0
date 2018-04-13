From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8350: remove snd_soc_codec" to the
	asoc tree
Date: Fri, 13 Apr 2018 12:24:43 +0100
Message-ID: <E1f6wot-0000Ld-PB@debutante>
References: <87tvt13psj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC25267636
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:24:48 +0200 (CEST)
In-Reply-To: <87tvt13psj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8350: remove snd_soc_codec

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

>From d00ef703065abc8d1efe5e548daa923f5411b042 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 02:22:07 +0000
Subject: [PATCH] ASoC: wm8350: remove snd_soc_codec

codec is replace to component.
It seems no-one is using it, Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mfd/wm8350/audio.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/mfd/wm8350/audio.h b/include/linux/mfd/wm8350/audio.h
index bd581c6fa085..0bc41c4c0429 100644
--- a/include/linux/mfd/wm8350/audio.h
+++ b/include/linux/mfd/wm8350/audio.h
@@ -617,11 +617,8 @@ struct wm8350_audio_platform_data {
 	u32 codec_current_charge:2;	/* codec current @ vmid charge */
 };
 
-struct snd_soc_codec;
-
 struct wm8350_codec {
 	struct platform_device *pdev;
-	struct snd_soc_codec *codec;
 	struct wm8350_audio_platform_data *platform_data;
 };
 
-- 
2.17.0
