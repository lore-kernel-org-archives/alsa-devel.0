From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: [PATCH] snd-sbxfi: set up the DAC at card
	initialization, regardless of duplex mode
Date: Sat, 18 Oct 2008 13:59:46 -0500
Message-ID: <20081018185158.BE88E77DF81@carpathia.dereferenced.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129]) by alsa0.perex.cz (Postfix) with ESMTP id E796F24544
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Oct 2008 21:04:14 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

We should bring up the DAC at card initialization even in half-duplex mode,
otherwise we have to deal with unfortunate glitches in the hardware.

Constantly resetting the DAC can cause serious state desyncs, resulting in
the driver eventually not working until a reboot occurs.

Signed-off-by: William Pitcock <nenolod@sacredspiral.co.uk>
---
 sound/pci/sbxfi/sbxfi.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
index d64d462..30ad25b 100644
--- a/sound/pci/sbxfi/sbxfi.c
+++ b/sound/pci/sbxfi/sbxfi.c
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(debug, "Debug flag: 0 = disable");
 /* continuous rate support */
 #undef XXX_CONT_RATE
 
-/* full-duplex support */
+/* full duplex support */
 #undef XXX_FULL_DUPLEX
 
 /* multi playback - not implemented */
@@ -1364,10 +1364,6 @@ static int sbxfi_playback_prepare(struct snd_pcm_substream *substream)
 	port->frag_count = runtime->period_size;
 	port->need_update = 0;
 
-#ifndef XXX_FULL_DUPLEX
-	sbxfi_init_dac(chip);
-	sbxfi_setup_i2s(chip);
-#endif
 	sbxfi_setup_play_pitch(chip, port);
 	sbxfi_setup_play_mixer(chip, port);
 	sbxfi_setup_play_mapper(chip, port);
@@ -1924,10 +1920,8 @@ static int sbxfi_init_hw(struct sbxfi *chip)
 
 	sbxfi_daoimap_clear(chip);
 
-#ifdef XXX_FULL_DUPLEX
 	sbxfi_init_dac(chip);
 	sbxfi_setup_i2s(chip);
-#endif
 
 	return 0;
 }
-- 
1.5.5.4
