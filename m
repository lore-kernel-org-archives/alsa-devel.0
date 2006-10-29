From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Enable stereo line input for TAS codec
Date: Sun, 29 Oct 2006 15:10:27 +1100
Message-ID: <17732.10675.757518.888784@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7D97328D
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2006 07:56:19 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Despite what the data sheet says in one place, to get stereo input
from input A (line in), we have to clear the "input B monaural" bit in
the ACR.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index 2ef55a1..9de8485 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -514,9 +514,15 @@ static int tas_snd_capture_source_put(st
 	mutex_lock(&tas->mtx);
 	oldacr = tas->acr;
 
-	tas->acr &= ~TAS_ACR_INPUT_B;
+	/*
+	 * Despite what the data sheet says in one place, the
+	 * TAS_ACR_B_MONAUREAL bit forces mono output even when
+	 * input A (line in) is selected.
+	 */
+	tas->acr &= ~(TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL);
 	if (ucontrol->value.enumerated.item[0])
-		tas->acr |= TAS_ACR_INPUT_B;
+		tas->acr |= TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL |
+		      TAS_ACR_B_MON_SEL_RIGHT;
 	if (oldacr == tas->acr) {
 		mutex_unlock(&tas->mtx);
 		return 0;
@@ -686,8 +692,7 @@ static int tas_reset_init(struct tas *ta
 	if (tas_write_reg(tas, TAS_REG_MCS, 1, &tmp))
 		goto outerr;
 
-	tas->acr |= TAS_ACR_ANALOG_PDOWN | TAS_ACR_B_MONAUREAL |
-		TAS_ACR_B_MON_SEL_RIGHT;
+	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
 		goto outerr;
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
