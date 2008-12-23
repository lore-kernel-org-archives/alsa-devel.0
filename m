From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Add missing terminators in
	patch_sigmatel.c
Date: Tue, 23 Dec 2008 16:53:00 -0200
Message-ID: <200812231653.01240.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (unknown [200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E4EB103831
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 19:53:26 +0100 (CET)
Content-Disposition: inline
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

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 71d3a77..35b83dc 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -841,6 +841,7 @@ static struct hda_verb stac92hd83xxx_core_init[] = {
 
 	/* power state controls amps */
 	{ 0x01, AC_VERB_SET_EAPD, 1 << 2},
+	{}
 };
 
 static struct hda_verb stac92hd71bxx_core_init[] = {
@@ -850,6 +851,7 @@ static struct hda_verb stac92hd71bxx_core_init[] = {
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{}
 };
 
 #define HD_DISABLE_PORTF 2
@@ -1681,6 +1683,7 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
+	{} /* terminator */
 };
 
 static unsigned int ref92hd71bxx_pin_configs[11] = {
