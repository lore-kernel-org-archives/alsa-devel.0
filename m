From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Support headset button on Stoney
	DA7219" to the asoc tree
Date: Mon, 16 Apr 2018 13:00:11 +0100
Message-ID: <E1f82nr-00008V-TO@debutante>
References: <1523527031-6132-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0762E2673F2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 14:00:15 +0200 (CEST)
In-Reply-To: <1523527031-6132-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com, broonie@kernel.org, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Support headset button on Stoney DA7219

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

>From 923859e3f6b281cc280214854a44dfd04cb7f65d Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Thu, 12 Apr 2018 17:57:11 +0800
Subject: [PATCH] ASoC: AMD: Support headset button on Stoney DA7219

Adds headset button support.

TEST=Tested Volume UP/Down, Play/Pause functionality

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c782e494..d281c227d64c 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/acpi.h>
 
 #include "../codecs/da7219.h"
@@ -80,6 +81,11 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+
 	da7219_aad_jack_det(component, &cz_jack);
 
 	return 0;
-- 
2.17.0
