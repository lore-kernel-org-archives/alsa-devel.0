From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] ice1724: Fix surround on Chaintech AV-710
Date: Fri, 09 Oct 2009 22:08:58 -0600
Message-ID: <4AD008DA.2060109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id E01392439A
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 06:09:10 +0200 (CEST)
Received: by ywh33 with SMTP id 33so1654120ywh.23
	for <alsa-devel@alsa-project.org>; Fri, 09 Oct 2009 21:09:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fix the num_total_dacs setting for Chaintech AV710. The existing comment
that only PSDOUT0 is connected is correct, but since the card is using
packed AC97 mode to send 6 channels to the codec, num_total_dacs should be
set to 6 and not 2. This allows 6-channel surround to work. Also clarify
a comment regarding the additional WM8728 codec on this card (it's connected
to the SPDIF output and always receives the same data).

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/sound/pci/ice1712/amp.c b/sound/pci/ice1712/amp.c
index 3756430..bfcf989 100644
--- a/sound/pci/ice1712/amp.c
+++ b/sound/pci/ice1712/amp.c
@@ -52,11 +52,13 @@ static int __devinit snd_vt1724_amp_init(struct snd_ice1712 *ice)
 
 	/* only use basic functionality for now */
 
-	ice->num_total_dacs = 2;	/* only PSDOUT0 is connected */
+	/* VT1616 6ch codec connected to PSDOUT0 using packed mode */
+	ice->num_total_dacs = 6;
 	ice->num_total_adcs = 2;
 
-	/* Chaintech AV-710 has another codecs, which need initialization */
-	/* initialize WM8728 codec */
+	/* Chaintech AV-710 has another WM8728 codec connected to PSDOUT4
+	   (shared with the SPDIF output). Mixer control for this codec
+	   is not yet supported. */
 	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_AV710) {
 		for (i = 0; i < ARRAY_SIZE(wm_inits); i += 2)
 			wm_put(ice, wm_inits[i], wm_inits[i+1]);
