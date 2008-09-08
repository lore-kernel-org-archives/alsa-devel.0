From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: SPDIF mux name change
Date: Mon, 08 Sep 2008 11:36:59 -0400
Message-ID: <48C5469B.5080206@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 21629243C0
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 17:37:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Changed the mux naming scheme from "IEC9258 Mux" to "IEC958 Playback Source" to match
the coding style.

---
Signed-by-off: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index ee24a0d..173515d 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1047,7 +1047,7 @@ static struct snd_kcontrol_new stac_dmux_mixer = {

 static struct snd_kcontrol_new stac_smux_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "IEC958 Mux",
+	.name = "IEC958 Playback Source",
 	/* count set later */
 	.info = stac92xx_smux_enum_info,
 	.get = stac92xx_smux_enum_get,
