From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Enable 192khz in hw_params
	operation" to the asoc tree
Date: Mon, 06 Mar 2017 11:46:40 +0100
Message-ID: <E1ckqA4-0002T6-Kw@finisterre>
References: <20170224160104.29354-5-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E69B6266DAE
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:47:25 +0100 (CET)
In-Reply-To: <20170224160104.29354-5-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Romain Perier <romain.perier@collabora.com>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: Enable 192khz in hw_params operation

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

>From 2e589fdc35c281fe1b1abe8a70004022ca504cf7 Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@collabora.com>
Date: Wed, 1 Mar 2017 10:11:07 +0100
Subject: [PATCH] ASoC: rockchip: Enable 192khz in hw_params operation

As the sampling frequency is supported by es8328 in slave mode,
add support for it in the corresponding operation.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index b60abf322ce1..dbc53e48c52c 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -93,6 +93,9 @@ static int rk_hw_params(struct snd_pcm_substream *substream,
 	case 96000:
 		mclk = 12288000;
 		break;
+	case 192000:
+		mclk = 24576000;
+		break;
 	case 11025:
 	case 22050:
 	case 44100:
-- 
2.11.0
