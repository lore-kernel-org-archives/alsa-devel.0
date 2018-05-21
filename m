From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_nau8824: Fix jack_type to
	include SND_JACK_MICROPHONE
Date: Mon, 21 May 2018 14:42:51 +0200
Message-ID: <20180521124251.10535-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 20DB026738C
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 14:42:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

The nau8824 codec can detect whether a headset or plain headphones is
inserted (as well as button presses on the headset) as such the jack_type
passed to snd_soc_card_jack_new() should include SND_JACK_MICROPHONE.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
