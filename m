From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ALC650 rev D. - SPDIF out
Date: Fri, 03 Oct 2003 15:23:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F7D8676.6030904@superbug.demon.co.uk>
References: <200310030633.IAA13612@www1.pobox.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050808000401070704070401"
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
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050808000401070704070401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

p z oooo wrote:
> Hi,
> 
> I have ALC650 rev. D and spdif is not working with 0.9.7.
> 
> Please delete this row from ac97_patch.c from function patch_alc650
> 
> ac97->ext_id &= ~AC97_EI_SPDIF; /* disable extended-id */ 
> 
> I think, that all ALC650 have spdif out and rev. E and later have 
> spdif in.
> 
> Peter Zubaj
> 
> 
The ALC650 chip specs do show that SPDIF out is present on all models.

I am not sure about your fix, because even the Realtek versions of the 
alsa driver disable spdif out if AC97_EA_SPCV is not set.
Reasons for AC97_EA_SPCV not being set are: -
Current S/PDIF configuration {SPSA,SPSR,DAC/slot rate} is invalid.

Why that only works on Rev E or above I don't know.

I think that maybe a better way would be to also remove the checking of 
AC97_EA_SPCV, and instead use the Chip revision code, now that we can 
detect chip revisions.

See attached suggested patch.

Cheers
James

--------------050808000401070704070401
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

--------------050808000401070704070401--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
