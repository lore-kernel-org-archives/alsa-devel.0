From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_nau8824: Fix jack_type
	to include SND_JACK_MICROPHONE" to the asoc tree
Date: Wed, 23 May 2018 09:38:16 +0100
Message-ID: <E1fLPHk-0000hK-EP@debutante>
References: <20180521124251.10535-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CCC4B266F88
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 10:38:26 +0200 (CEST)
In-Reply-To: <20180521124251.10535-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_nau8824: Fix jack_type to include SND_JACK_MICROPHONE

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

>From 5aff078ac81a3be58f7a2e2be0f33bc9ce062bac Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 21 May 2018 14:42:51 +0200
Subject: [PATCH] ASoC: Intel: cht_bsw_nau8824: Fix jack_type to include
 SND_JACK_MICROPHONE

The nau8824 codec can detect whether a headset or plain headphones is
inserted (as well as button presses on the headset) as such the jack_type
passed to snd_soc_card_jack_new() should include SND_JACK_MICROPHONE.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 072e94b69e57..30c46977d53c 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -120,7 +120,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	 * KEY_VOLUMEUP
 	 * KEY_VOLUMEDOWN
 	 */
-	jack_type = SND_JACK_HEADPHONE | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+	jack_type = SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 		SND_JACK_BTN_2 | SND_JACK_BTN_3;
 	ret = snd_soc_card_jack_new(runtime->card, "Headset", jack_type, jack,
 		cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));
-- 
2.17.0
