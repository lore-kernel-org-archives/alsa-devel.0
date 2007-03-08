From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Patch: Shared jack control logic for AD1985 and others
Date: Thu, 08 Mar 2007 18:05:47 -0500
Message-ID: <45F096CB.2000204@earthlink.net>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>	<45EEA3C4.7000501@googlemail.com>	<20070307104746.f08a2e84.akpm@linux-foundation.org>	<6bffcb0e0703071141j42309702w793e4a76b1b23bfa@mail.gmail.com>	<20070307115024.756c848f.akpm@linux-foundation.org>	<s5hvehcrdod.wl%tiwai@suse.de>	<45EF3B2C.9060801@googlemail.com>	<s5hfy8gbrmj.wl%tiwai@suse.de>	<45F02EE2.6040606@googlemail.com>	<s5h8xe7ognj.wl%tiwai@suse.de>	<6bffcb0e0703080852l4a06c0f9qeb51044a7a1a68a@mail.gmail.com>	<s5hwt1rn0aj.wl%tiwai@suse.de>	<45F0426D.6020408@earthlink.net>
	<s5hvehbmuvb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070902050903060409080606"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mta15.adelphia.net (mta15.mail.adelphia.net [68.168.78.77])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EF17243D2
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2007 00:05:57 +0100 (CET)
In-Reply-To: <s5hvehbmuvb.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070902050903060409080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi and Michal,

Here is a patch that I believe will correct the issue Michal identified.

Takashi's patch was close, but he overlooked that I also had the logic 
for the OMS bit reversed.  For the AD1985 Surround would have worked 
correctly, but Center/LFE still would have been broken.

Randy Cushman


--------------070902050903060409080606
Content-Type: text/plain;
 name="ac97_ad_shared.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_ad_shared.patch"

Summary: fix AD shared shared jack control logic

This patch fixes the control logic for shared
Microphone in/Center+LFE out and Line in/Surround out jacks
for Analog Devices AD1888, AD1980 and AD1985 AC '97 CODECs.

Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>


diff -r e4f79cb873e5 pci/ac97/ac97_patch.c
--- a/pci/ac97/ac97_patch.c	Tue Mar 06 11:29:05 2007 +0100
+++ b/pci/ac97/ac97_patch.c	Thu Mar 08 17:08:52 2007 -0500
@@ -1950,9 +1950,11 @@ static void ad1888_update_jacks(struct s
 static void ad1888_update_jacks(struct snd_ac97 *ac97)
 {
 	unsigned short val = 0;
-	if (! is_shared_linein(ac97))
+	/* clear LODIS if shared jack is to be used for Surround out */
+	if (is_shared_linein(ac97))
 		val |= (1 << 12);
-	if (! is_shared_micin(ac97))
+	/* clear CLDIS if shared jack is to be used for C/LFE out */
+	if (is_shared_micin(ac97))
 		val |= (1 << 11);
 	/* shared Line-In */
 	snd_ac97_update_bits(ac97, AC97_AD_MISC, (1 << 11) | (1 << 12), val);
@@ -2124,8 +2126,9 @@ static void ad1985_update_jacks(struct s
 static void ad1985_update_jacks(struct snd_ac97 *ac97)
 {
 	ad1888_update_jacks(ac97);
+	/* clear OMS if shared jack is to be used for C/LFE out */
 	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 1 << 9,
-			     is_shared_micin(ac97) ? 0 : 1 << 9);
+			     is_shared_micin(ac97) ? 1 << 9 : 0);
 }
 
 static int patch_ad1985_specific(struct snd_ac97 *ac97)
@@ -2406,9 +2409,9 @@ static void ad1986_update_jacks(struct s
 	unsigned short ser_val;
 
 	/* disable SURROUND and CENTER/LFE if not surround mode */
-	if (! is_surround_on(ac97))
+	if (!is_surround_on(ac97))
 		misc_val |= AC97_AD1986_SODIS;
-	if (! is_clfe_on(ac97))
+	if (!is_clfe_on(ac97))
 		misc_val |= AC97_AD1986_CLDIS;
 
 	/* select line input (default=LINE_IN, SURROUND or MIC_1/2) */

--------------070902050903060409080606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------070902050903060409080606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070902050903060409080606--
