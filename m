From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] AD1985 mixer settings
Date: Wed, 20 Aug 2003 09:26:52 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308200909180.2513-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


The AD1985's "ADI compatibility mode" changes the meaning of some
mixer controls to be more useful. In this case, it makes the Master
Volume control behave correctly.


Index: alsa-kernel/pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.18
diff -u -r1.18 ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c	30 Jul 2003 10:54:03 -0000	1.18
+++ alsa-kernel/pci/ac97/ac97_patch.c	20 Aug 2003 06:59:16 -0000
@@ -768,7 +768,8 @@
 	misc = snd_ac97_read(ac97, AC97_AD_MISC);
 	/* switch front/surround line-out/hp-out */
 	/* center/LFE, surround in High-Z mode */
+	/* ADI compatibility mode */
-	snd_ac97_write_cache(ac97, AC97_AD_MISC, misc | 0x1c28);
+	snd_ac97_write_cache(ac97, AC97_AD_MISC, misc | 0x5c20);
 	return 0;
 }





-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
