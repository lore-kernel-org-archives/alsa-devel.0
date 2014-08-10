From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/ca0132 - Don't try loading firmware
	at resume when already failed
Date: Sun, 10 Aug 2014 13:38:00 +0200
Message-ID: <1407670680-420-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BC43C261B0A
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 13:38:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A03A9ABAE
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 11:38:00 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CA0132 driver tries to reload the firmware at resume.  Usually this
works since the firmware loader core caches the firmware contents by
itself.  However, if the driver failed to load the firmwares
(e.g. missing files), reloading the firmware at resume goes through
the actual file loading code path, and triggers a kernel WARNING like:

 WARNING: CPU: 10 PID:11371 at drivers/base/firmware_class.c:1105 _request_firmware+0x9ab/0x9d0()

For avoiding this situation, this patch makes CA0132 skipping the f/w
loading at resume when it failed at probe time.

Reported-and-tested-by: Janek Kozicki <cosurgi@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4f3aba78f720..5d8455e2dacd 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4376,6 +4376,9 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 	return; /* NOP */
 #endif
 
+	if (spec->dsp_state == DSP_DOWNLOAD_FAILED)
+		return; /* don't retry failures */
+
 	chipio_enable_clocks(codec);
 	spec->dsp_state = DSP_DOWNLOADING;
 	if (!ca0132_download_dsp_images(codec))
@@ -4552,7 +4555,8 @@ static int ca0132_init(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
-	spec->dsp_state = DSP_DOWNLOAD_INIT;
+	if (spec->dsp_state != DSP_DOWNLOAD_FAILED)
+		spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->curr_chip_addx = INVALID_CHIP_ADDRESS;
 
 	snd_hda_power_up(codec);
@@ -4663,6 +4667,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	codec->spec = spec;
 	spec->codec = codec;
 
+	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 	spec->mixers[0] = ca0132_mixer;
 
-- 
2.0.4
