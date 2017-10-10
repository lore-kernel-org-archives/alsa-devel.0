From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ASoC: dapm: mark 'snd_soc_dapm_free_kcontrol' as static
Date: Tue, 10 Oct 2017 11:20:11 +0200
Message-ID: <20171010092052.2551973-2-arnd@arndb.de>
References: <20171010092052.2551973-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010092052.2551973-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, anish kumar <yesanishhere@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The newly introduced function is declared as globally visible,
but is not declared in a header, causing a warning 'make W=1'
or 'make C=1':

sound/soc/soc-dapm.c:3782:1: warning: symbol 'snd_soc_dapm_free_kcontrol' was not declared. Should it be static?

The suggestion to make it static seems appropriate here, so let's
do that.

Fixes: 19ad683abc85 ("ASoC: dapm: Avoid creating kcontrol for params")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 19babdae1a06..a10b21cfc31e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3778,7 +3778,7 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-void
+static void
 snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
 			unsigned long *private_value,
 			int num_params,
-- 
2.9.0
