From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hda - fix cs4210_spdif_automute()
Date: Sat, 25 Jul 2015 03:03:38 +0300
Message-ID: <20150725000337.GA14581@mwanda>
References: <s5hoaj1v89z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hoaj1v89z.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Smatch complains that we have nested checks for "spdif_present".  It
turns out the current behavior isn't correct, we should remove the first
check and keep the second.

Fixes: 1077a024812d ('ALSA: hda - Use generic parser for Cirrus codec driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 25ccf78..584a034 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -999,9 +999,7 @@ static void cs4210_spdif_automute(struct hda_codec *codec,
 
 	spec->spdif_present = spdif_present;
 	/* SPDIF TX on/off */
-	if (spdif_present)
-		snd_hda_set_pin_ctl(codec, spdif_pin,
-				    spdif_present ? PIN_OUT : 0);
+	snd_hda_set_pin_ctl(codec, spdif_pin, spdif_present ? PIN_OUT : 0);
 
 	cs_automute(codec);
 }
