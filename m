From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH 4/4] ALSA: oxygen: Updating jack implementation according new ALSA Jacks
Date: Fri, 26 Jul 2013 11:25:33 -0700
Message-ID: <1374863133-6745-5-git-send-email-eu@felipetonello.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, "Felipe F. Tonello" <eu@felipetonello.com>
List-Id: alsa-devel@alsa-project.org

From: "Felipe F. Tonello" <eu@felipetonello.com>

ALSA standard jacks already are implemented using ALSA KControl.
So there is no need implement that itself or to use snd_jack
for input events only.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 sound/pci/oxygen/xonar_wm87x6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index 6ce6860..d3816b1 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -286,7 +286,7 @@ static void xonar_ds_init(struct oxygen *chip)
 	xonar_enable_output(chip);
 
 	snd_jack_new(chip->card, "Headphone",
-		     SND_JACK_HEADPHONE, &data->hp_jack);
+	             SND_JACK_HEADPHONE, 0, &data->hp_jack);
 	xonar_ds_handle_hp_jack(chip);
 
 	snd_component_add(chip->card, "WM8776");
-- 
1.8.1.4
