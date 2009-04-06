From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] Add VREF powerdown sequence for another board
Date: Mon, 06 Apr 2009 09:30:46 -0400
Message-ID: <49DA0406.8030209@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 9604D2434F
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 15:30:56 +0200 (CEST)
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

Add powerdown sequence for VREF using a shared jack when the headphone is present and
the microphone isn't on.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
 sound/pci/hda/patch_sigmatel.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index b5e108a..a6fc257 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4413,6 +4413,22 @@ static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
 		if (spec->num_pwrs > 0)
 			stac92xx_pin_sense(codec, event->nid);
 		stac92xx_report_jack(codec, event->nid);
+
+		switch (codec->subsystem_id) {
+		case 0x103c308f:
+			if (event->nid == 0xb) {
+				int pin = AC_PINCTL_IN_EN;
+
+				if (get_pin_presence(codec, 0xa)
+						&& get_pin_presence(codec, 0xb))
+					pin |= AC_PINCTL_VREF_80;
+				if (!get_pin_presence(codec, 0xb))
+					pin |= AC_PINCTL_VREF_80;
+
+				/* toggle VREF state based on mic + hp pin status */
+				stac92xx_auto_set_pinctl(codec, 0x0a, pin);
+			}
+		}
 		break;
 	case STAC_VREF_EVENT:
 		data = snd_hda_codec_read(codec, codec->afg, 0,
-- 
1.5.6.3
