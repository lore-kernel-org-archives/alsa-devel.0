From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ASoC: core: Fix use-after-free after deferred card registration
Date: Tue, 26 Mar 2019 10:23:38 -0700
Message-ID: <1553621018-8944-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

If snd_soc_register_card() fails because one of its links fails
to instantiate with -EPROBE_DEFER, and the to-be-registered link
is a legacy link, a subsequent retry will trigger a use-after-free
and quite often a system crash.

Example:

byt-max98090 byt-max98090: ASoC: failed to init link Baytrail Audio
byt-max98090 byt-max98090: snd_soc_register_card failed -517
....
BUG: KASAN: use-after-free in snd_soc_init_platform+0x233/0x312
Read of size 8 at addr ffff888067c43070 by task kworker/1:1/23

snd_soc_init_platform() allocates memory attached to the card device.
This memory is released when the card device is released. However,
the pointer to the memory (dai_link->platforms) is only cleared from
soc_cleanup_platform(), which is called from soc_cleanup_card_resources(),
but not if snd_soc_register_card() fails early.

Add the missing call to soc_cleanup_platform() in the error handling
code of snd_soc_register_card() to fix the problem.

Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
Cc: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..6bf9884d0863 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2799,6 +2799,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			soc_cleanup_platform(card);
 			mutex_unlock(&client_mutex);
 			return ret;
 		}
-- 
2.7.4
