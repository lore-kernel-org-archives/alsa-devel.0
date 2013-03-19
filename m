From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] ALSA: usb: Parse UAC2 extension unit like for
	UAC1
Date: Tue, 19 Mar 2013 17:12:14 +0100
Message-ID: <20130319161214.GB7539@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 640A1260307
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 17:12:17 +0100 (CET)
Received: from horisont.pvv.ntnu.no ([129.241.210.175] ident=Debian-exim)
 by microbel.pvv.ntnu.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.72) (envelope-from <torstehe@pvv.ntnu.no>)
 id 1UHz94-0004yi-Po
 for alsa-devel@alsa-project.org; Tue, 19 Mar 2013 17:12:16 +0100
Received: from torstehe by horisont.pvv.ntnu.no with local (Exim 4.72)
 (envelope-from <torstehe@pvv.ntnu.no>) id 1UHz94-00058T-GP
 for alsa-devel@alsa-project.org; Tue, 19 Mar 2013 17:12:14 +0100
Content-Disposition: inline
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

UAC2_EXTENSION_UNIT_V2 differs from UAC1_EXTENSION_UNIT, but can be handled in
the same way when parsing the unit. Otherwise parse_audio_unit() fails when it
sees an extension unit on a UAC2 device.

UAC2_EXTENSION_UNIT_V2 is outside the range allocated by UAC1.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 sound/usb/mixer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 638e7f7..8eb84c0 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -725,7 +725,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 		case UAC1_PROCESSING_UNIT:
 		case UAC1_EXTENSION_UNIT:
 		/* UAC2_PROCESSING_UNIT_V2 */
-		/* UAC2_EFFECT_UNIT */ {
+		/* UAC2_EFFECT_UNIT */
+		case UAC2_EXTENSION_UNIT_V2: {
 			struct uac_processing_unit_descriptor *d = p1;
 
 			if (state->mixer->protocol == UAC_VERSION_2 &&
@@ -2052,6 +2053,8 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 			return parse_audio_extension_unit(state, unitid, p1);
 		else /* UAC_VERSION_2 */
 			return parse_audio_processing_unit(state, unitid, p1);
+	case UAC2_EXTENSION_UNIT_V2:
+		return parse_audio_extension_unit(state, unitid, p1);
 	default:
 		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
 		return -EINVAL;
-- 
1.7.10.4
