From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] ALC650 rev D. - SPDIF out
Date: Fri, 10 Oct 2003 15:52:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F86C7AF.4060807@superbug.demon.co.uk>
References: <200310030633.IAA13612@www1.pobox.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010902000907080000080105"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310030633.IAA13612@www1.pobox.sk>
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

This is a multi-part message in MIME format.
--------------010902000907080000080105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is a patch to enable SPDIF out on ALC650 rev D. codecs.

Cheers
James


--------------010902000907080000080105
Content-Type: text/plain;
 name="alc650-rev-d-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alc650-rev-d-fix.diff"

--- ac97_patch.c.org	2003-10-03 15:16:06.099127808 +0100
+++ ac97_patch.c	2003-10-03 15:21:50.975698600 +0100
@@ -898,7 +898,6 @@
 int patch_alc650(ac97_t * ac97)
 {
 	unsigned short val;
-	int spdif = 0;
 
 	ac97->build_ops = &patch_alc650_ops;
 
@@ -907,22 +906,16 @@
 	ac97->spec.dev_flags = (ac97->id == 0x414c4722 ||
 				ac97->id == 0x414c4723);
 
-	/* check spdif (should be only on rev.E) */
-	if (ac97->spec.dev_flags) {
-		val = snd_ac97_read(ac97, AC97_EXTENDED_STATUS);
-		if (val & AC97_EA_SPCV)
-			spdif = 1;
-	}
+	/* enable AC97_ALC650_GPIO_SETUP, AC97_ALC650_CLOCK for R/W */
+	snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS, 
+		snd_ac97_read(ac97, AC97_ALC650_GPIO_STATUS) | 0x8000);
 
-	if (spdif) {
-		/* enable AC97_ALC650_GPIO_SETUP, AC97_ALC650_CLOCK for R/W */
-		snd_ac97_write_cache(ac97, AC97_ALC650_GPIO_STATUS, 
-			snd_ac97_read(ac97, AC97_ALC650_GPIO_STATUS) | 0x8000);
+	/* Enable SPDIF-IN only on Rev.E and above */
+	if (ac97->spec.dev_flags) {
 		/* enable spdif in */
 		snd_ac97_write_cache(ac97, AC97_ALC650_CLOCK,
 				     snd_ac97_read(ac97, AC97_ALC650_CLOCK) | 0x03);
-	} else
-		ac97->ext_id &= ~AC97_EI_SPDIF; /* disable extended-id */
+	} 
 
 	val = snd_ac97_read(ac97, AC97_ALC650_MULTICH);
 	val &= ~0xc000; /* slot: 3,4,7,8,6,9 */


--------------010902000907080000080105--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
