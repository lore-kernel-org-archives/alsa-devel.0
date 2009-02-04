From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Added stac378x digital slave out struct
Date: Wed, 04 Feb 2009 17:49:41 -0500
Message-ID: <498A1B85.1050901@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 379AA24407
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 23:49:56 +0100 (CET)
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

Added the ADATOut nid to a slave digital outs struct to allow output
via the DigOut pin.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
 sound/pci/hda/patch_sigmatel.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a7df81e..58a10ed 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -404,6 +404,10 @@ static hda_nid_t stac922x_mux_nids[2] = {
         0x12, 0x13,
 };
 
+static hda_nid_t stac927x_slave_dig_outs[2] = {
+	0x1f, 0,
+};
+
 static hda_nid_t stac927x_adc_nids[3] = {
         0x07, 0x08, 0x09
 };
@@ -5218,6 +5222,7 @@ static int patch_stac927x(struct hda_codec *codec)
 		return -ENOMEM;
 
 	codec->spec = spec;
+	codec->slave_dig_outs = stac927x_slave_dig_outs;
 	spec->num_pins = ARRAY_SIZE(stac927x_pin_nids);
 	spec->pin_nids = stac927x_pin_nids;
 	spec->board_config = snd_hda_check_board_config(codec, STAC_927X_MODELS,
-- 
1.5.6.3
