From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: Any missing patches?
Date: Mon, 20 Mar 2006 21:18:33 +0100
Message-ID: <877j6oq38m.fsf@blackdown.de>
References: <s5hmzfl9cql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzfl9cql.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
	20 Mar 2006 19:45:22 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> if someone has patches intended for merging to ALSA tree, please
> submit them ASAP.
>
> I think the current ALSA CVS tree is forming to a relatively good
> shape now, and it's good time to push Linux kernel tree, too.
> Let's be not too late to ride a bus.

Here's a patch for generic dmix which fixes S16 byte swapping.

Tested on powerpc with snd-usb-audio.  (Without the patch I get crackling.)


BTW: Is it normal that the dmix plug-in consumes 100% CPU?


        Juergen


Signed-off-by: Juergen Kreileder <jk@blackdown.de>

--- o/alsa-lib-1.0.11rc3/src/pcm/pcm_dmix_generic.c	2005-12-19 08:39:04.000000000 +0100
+++ alsa-lib-1.0.11rc3/src/pcm/pcm_dmix_generic.c	2006-03-10 02:04:56.000000000 +0100
@@ -194,7 +194,7 @@ static void mix_areas1_swap(unsigned int
 	register signed int sample;
 
 	for (;;) {
-		sample = bswap_16(*src);
+		sample = (signed short) bswap_16(*src);
 		if (! *dst) {
 			*sum = sample;
 			*dst = *src;
@@ -205,7 +205,7 @@ static void mix_areas1_swap(unsigned int
 				sample = 0x7fff;
 			else if (sample < -0x8000)
 				sample = -0x8000;
-			*dst = bswap_16((signed short)sample);
+			*dst = (signed short) bswap_16((signed short) sample);
 		}
 		if (!--size)
 			return;
=


-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
