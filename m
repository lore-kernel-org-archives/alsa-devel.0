From: Rene Rebe <rene.rebe@gmx.net>
Subject: [PATCH] pmac 48kHz sample rate not function -> disable
Date: Fri, 30 Jul 2004 16:56:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410A61AC.80008@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050904000606080702020508"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050904000606080702020508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

48kHz sample rate is not functional - at least with all iBook2s I have 
access to. The hardware just does 44.1kHz instead. I have cross checking 
the Darwin source - but as far as I have seen it also does not support 
higher rates then 44.1kHz. Strange is, that any bit combination written 
does result in 44.1kHz. Maybe someone with access to the spec can 
implement it correctly - if the hardware does support something different.

Have fun,
  René Rebe

--------------050904000606080702020508
Content-Type: text/plain;
 name="alsa-pmac3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-pmac3.patch"

--- ppc/pmac.c.orig	2004-08-01 01:09:36.820879352 +0200
+++ ppc/pmac.c	2004-07-31 17:40:45.512859128 +0200
@@ -53,7 +53,7 @@
 };
 /* fixed frequency table for tumbler */
 static int tumbler_freqs[2] = {
-	48000, 44100
+	/*48000,*/ 44100
 };
 
 /*
@@ -494,14 +494,14 @@
 	snd_pcm_runtime_t *runtime = subs->runtime;
 	int i, j, fflags;
 	static int typical_freqs[] = {
-		48000,
+		/*48000,*/
 		44100,
 		22050,
 		11025,
 		0,
 	};
 	static int typical_freq_flags[] = {
-		SNDRV_PCM_RATE_48000,
+		/*SNDRV_PCM_RATE_48000,*/
 		SNDRV_PCM_RATE_44100,
 		SNDRV_PCM_RATE_22050,
 		SNDRV_PCM_RATE_11025,



--------------050904000606080702020508--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
