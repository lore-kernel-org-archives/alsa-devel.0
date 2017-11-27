From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016-sbc: Map BTN_0 to
	KEY_PLAYPAUSE" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:28 +0000
Message-ID: <E1eJOX2-0007In-4g@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CCB426762A
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:53:29 +0100 (CET)
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

   ASoC: qcom: apq8016-sbc: Map BTN_0 to KEY_PLAYPAUSE

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

>From 5f6d1df8ced6bb52453149f96d9b7005058641b6 Mon Sep 17 00:00:00 2001
From: Benson Leung <bleung@chromium.org>
Date: Wed, 22 Nov 2017 12:56:43 -0800
Subject: [PATCH] ASoC: qcom: apq8016-sbc: Map BTN_0 to KEY_PLAYPAUSE

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
 sound/soc/qcom/apq8016_sbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d49adc822a11..03851fedd1e2 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -92,7 +92,7 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 		jack = pdata->jack.jack;
 
-		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_MEDIA);
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
 		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
 		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
-- 
2.15.0
