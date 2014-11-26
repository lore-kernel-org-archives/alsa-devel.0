From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: sigmadsp: uninitialized variable in
 sigmadsp_activate_ctrl()
Date: Thu, 27 Nov 2014 01:35:16 +0300
Message-ID: <20141126223516.GB443@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The "changed" variable should be set to false at the start.

Fixes: a35daac77a03 ('ASoC: sigmadsp: Add support for fw v2')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 34fdc40..d53680a 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -661,7 +661,8 @@ static void sigmadsp_activate_ctrl(struct sigmadsp *sigmadsp,
 	struct snd_card *card = sigmadsp->component->card->snd_card;
 	struct snd_kcontrol_volatile *vd;
 	struct snd_ctl_elem_id id;
-	bool active, changed;
+	bool active;
+	bool changed = false;
 
 	active = sigmadsp_samplerate_valid(ctrl->samplerates, samplerate_mask);
 
