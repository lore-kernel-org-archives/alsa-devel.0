From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rk3399_gru_sound: Map BTN_0 to
	KEY_PLAYPAUSE" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:30 +0000
Message-ID: <E1eJOX4-0007JX-76@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C8D267631
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:53:31 +0100 (CET)
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
To: Benson Leung <bleung@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rk3399_gru_sound: Map BTN_0 to KEY_PLAYPAUSE

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

>From af1b1cefd735c919d3185ce06b549c2b121067ba Mon Sep 17 00:00:00 2001
From: Benson Leung <bleung@chromium.org>
Date: Wed, 22 Nov 2017 12:56:42 -0800
Subject: [PATCH] ASoC: rk3399_gru_sound: Map BTN_0 to KEY_PLAYPAUSE

The Android 3.5mm Headset jack specification mentions that BTN_0 should
be mapped to KEY_MEDIA, but this is less logical than KEY_PLAYPAUSE,
which has much broader userspace support.

For example, the Chrome OS userspace now supports KEY_PLAYPAUSE to toggle
play/pause of videos and audio, but does not handle KEY_MEDIA.

Furthermore, Android itself now supports KEY_PLAYPAUSE equivalently, as the
new USB headset spec requires KEY_PLAYPAUSE for BTN_0.
https://source.android.com/devices/accessories/headset/usb-headset-spec

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index d64fbbd50544..fa6cd1de828b 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -206,7 +206,8 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	snd_jack_set_key(rockchip_sound_jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(
+		rockchip_sound_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
 	snd_jack_set_key(
 		rockchip_sound_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
 	snd_jack_set_key(
-- 
2.15.0
