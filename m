From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000465]: es18xx driver fails to set filter register
Date: Thu, 26 Aug 2004 17:58:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040826155804.4D12224006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8D0A8280
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 17:58:04 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000465
======================================================================
Reported By:                ranma
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     465
Category:                   ISA - es18xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian/GNU Linux
Kernel Version:             2.6.8
Resolution:                 fixed
======================================================================
Date Submitted:             08-26-2004 15:27 CEST
Last Modified:              08-26-2004 17:58 CEST
======================================================================
Summary:                    es18xx driver fails to set filter register
Description: 
Apparently my es18xx bugfix was not pushed upstream as I noticed when I
switched from Kernel 2.4 + alsa-source to Kernel 2.6, so I'm reposting my
original Debian bugreport here:

I just installed alsa on my notebook and the first thing I noticed was
that it "does not sound right" with alsa whereas the sound is fine with
the kernel oss driver. A short comparison between the kernel driver and
the alsa driver turned up the following difference:

alsa-kernel/isa/es18xx.c:
|	/* set filter register */
|	div0 = 256 - 7160000*20/(8*82*runtime->rate);
|		
|	if ((chip->caps & ES18XX_PCM2) && mode == DAC2) {
|		snd_es18xx_mixer_write(chip, 0x70, bits);
|		snd_es18xx_mixer_write(chip, 0x72, div0);
|	} else {
|		snd_es18xx_write(chip, 0xA1, bits);
|		snd_es18xx_write(chip, 0xA2, div0);
|	}

drivers/sound/sb_ess.c:
|	/* Set filter roll-off to 90% of speed/2 */
|	speed = (devc->speed * 9) / 20;
|
|	div2 = 256 - 7160000 / (speed * 82);
|
|	if (!devc->duplex) audionum = 1;
|
|	if (audionum == 1) {
|		/* Change behaviour of register A1 *
|		sb_chg_mixer(devc, 0x71, 0x20, 0x20)
|		* For ES1869 only??? */
|		ess_write (devc, 0xa1, div);
|		ess_write (devc, 0xa2, div2);
|	} else {
|		ess_setmixer (devc, 0x70, div);
|		/*
|		 * FKS: fascinating: 0x72 doesn't seem to work.
|		 */
|		ess_write (devc, 0xa2, div2);
|		ess_setmixer (devc, 0x72, div2);
|	}

The 'fascinating' comment is the key, after inserting a corresponding
line in the ALSA driver, the sound is ok now:

--- alsa-kernel/isa/es18xx.c	2003-08-05 00:19:21.000000000 +0200
+++ alsa-kernel/isa/es18xx.c	2003-08-05 00:20:55.000000000 +0200
@@ -422,6 +422,11 @@
 		
 	if ((chip->caps & ES18XX_PCM2) && mode == DAC2) {
 		snd_es18xx_mixer_write(chip, 0x70, bits);
+		/*
+		 * Comment from kernel oss driver:
+		 * FKS: fascinating: 0x72 doesn't seem to work.
+		 */
+		snd_es18xx_write(chip, 0xA2, div0);
 		snd_es18xx_mixer_write(chip, 0x72, div0);
 	} else {
 		snd_es18xx_write(chip, 0xA1, bits);
======================================================================

----------------------------------------------------------------------
 tiwai - 08-26-2004 17:58 CEST 
----------------------------------------------------------------------
Thanks, the patch was applied to cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 15:27 ranma          New Bug                                      
08-26-04 15:27 ranma          Distribution              => Debian/GNU Linux
08-26-04 15:27 ranma          Kernel Version            => 2.6.8           
08-26-04 17:58 tiwai          Bugnote Added: 0001632                       
08-26-04 17:58 tiwai          Assigned To               => tiwai           
08-26-04 17:58 tiwai          Resolution               open => fixed       
08-26-04 17:58 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
