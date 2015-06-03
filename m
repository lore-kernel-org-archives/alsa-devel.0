From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: usb-audio: fix missing input volume
	controls in MAYA44	USB(+)
Date: Wed, 03 Jun 2015 11:36:51 +0200
Message-ID: <556ECAB3.907@ladisch.de>
References: <CAKfvqMUuD4ywuKktwko4DxgKpX1+vTCYHkngPXxKBjHNnmt_iw@mail.gmail.com>	<5552F162.8000309@googlemail.com>	<CAKfvqMVEWGDUUh4e0i9fEsbhBQyYPuzqs3xAQKA_FuZYtPuigg@mail.gmail.com>	<CAKfvqMVQHt157QmE5Fx=NV_U0i_JdH6UKtNXfcGaNvJNEW9M4Q@mail.gmail.com>	<CAKfvqMW9P-_fzx86c=bM_cD0sd93hsnaLuGwWRgKmPpEFLP7Ww@mail.gmail.com>	<CAKfvqMUJ+JDJoSWL5WjLugMoSN3FFbD0AFTJJ2-nW-dsgjLtdg@mail.gmail.com>	<5559AD0A.6060709@googlemail.com>	<CAKfvqMUA=CvfEETYWEESWs7xh3GiDgbjXHaAnx0UkpUxpBn_NA@mail.gmail.com>	<CAKfvqMV0xm0_fGs7=qEmjyE6p4Wf-xO0r3x7BuRbzo15h+pjew@mail.gmail.com>	<555C4A38.7030005@googlemail.com>	<CAKfvqMUPGMiukizZqSN5nY_OR3_ur6FF44GVcGmiQWNTMc8-1A@mail.gmail.com>	<555D840D.1060000@googlemail.com>	<CAKfvqMXWFNK3XvK8A9JY5xFnyQqw4C77D61JZb6xOqT92yDpug@mail.gmail.com>	<CAKfvqMUf7ET5KLAvYXNU2haLyeyBL
 Wd+3O_O2_O_84HUV+zgkg@mail.gmail.com>	<555EDCB4.8040507@googlemail.com>
 <CAKfvqMWBgeJb_sMJdmb0cYcq2qD8UocfEyGY1B-BKERjAXpY7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BFF30260418
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 11:36:51 +0200 (CEST)
In-Reply-To: <CAKfvqMWBgeJb_sMJdmb0cYcq2qD8UocfEyGY1B-BKERjAXpY7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, nightmixes <nightmixes@gmail.com>
List-Id: alsa-devel@alsa-project.org

The driver worked around an error in the MAYA44 USB(+)'s mixer unit
descriptor by aborting before parsing the missing field.  However,
aborting parsing too early prevented parsing of the other units
connected to this unit, so the capture mixer controls would be missing.

Fix this by moving the check for this descriptor error after the parsing
of the unit's input pins.

Reported-by: nightmixes <nightmixes@gmail.com>
Tested-by: nightmixes <nightmixes@gmail.com>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1583,18 +1583,15 @@ static int parse_audio_mixer_unit(struct
 			      unitid);
 		return -EINVAL;
 	}
-	/* no bmControls field (e.g. Maya44) -> ignore */
-	if (desc->bLength <= 10 + input_pins) {
-		usb_audio_dbg(state->chip, "MU %d has no bmControls field\n",
-			      unitid);
-		return 0;
-	}

 	num_ins = 0;
 	ich = 0;
 	for (pin = 0; pin < input_pins; pin++) {
 		err = parse_audio_unit(state, desc->baSourceID[pin]);
 		if (err < 0)
+			continue;
+		/* no bmControls field (e.g. Maya44) -> ignore */
+		if (desc->bLength <= 10 + input_pins)
 			continue;
 		err = check_input_term(state, desc->baSourceID[pin], &iterm);
 		if (err < 0)
