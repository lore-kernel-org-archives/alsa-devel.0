From: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>
Subject: [PATCH] intel8x0 - IBM Thinkpad T30
Date: Mon, 21 Jul 2003 17:41:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030721154100.GB10783@via.ecp.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

here is a patch which fixes a bug on T30 computers when switching back
from suspend mode.

The first modification allow the system to recover from errors when a
warm reset is not enough.

The second one fixes the bug I explained.

With this patch no need to kill all the applications using audio devices
before switching to suspend mode.

I made the patch with an old version on the driver (0.9.4) but it's easy
to port it for the CVS version.

Regards,

-- 
Arnaud

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="intel8x0.patch"

--- ../alsa-driver-0.9.4/alsa-kernel/pci/intel8x0.c	2003-05-20 14:55:15.000000000 +0200
+++ alsa-kernel/pci/intel8x0.c	2003-06-07 12:22:49.000000000 +0200
@@ -1542,7 +1542,10 @@
 	}
 	ac97.pci = chip->pci;
 	if ((err = snd_ac97_mixer(chip->card, &ac97, &x97)) < 0)
+	{
+		iputdword(chip, ICHREG(GLOB_CNT), igetdword(chip, ICHREG(GLOB_CNT)) & ~ICH_AC97COLD);
 		return err;
+	}
 	chip->ac97[0] = x97;
 	snd_ac97_tune_hardware(chip->ac97[0], ac97_quirks);
 	/* the following three entries are common among all devices */
@@ -1769,7 +1772,7 @@
       	if (status == (ICH_PCR | ICH_SCR | ICH_TCR))
       		goto __ok3;
 	/* wait for other codecs ready status. No secondary codecs? , ok */
-	end_time = jiffies + HZ / 4;
+	end_time = jiffies + HZ / 2;
 	do {
 		nstatus = igetdword(chip, ICHREG(GLOB_STA)) & (ICH_PCR | ICH_SCR | ICH_TCR);
 		if (nstatus != status) {

--vtzGhvizbBRQ85DL--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
