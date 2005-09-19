From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [alsa-utils/alsactl patch] Extend 'alsactl names' to show modem devices.
Date: Tue, 20 Sep 2005 01:18:52 +0300
Message-ID: <20050919221852.GC15916@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Extend 'alsactl names' to show phoneline and modem device names.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-utils/alsactl/names.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsactl/names.c,v
retrieving revision 1.5
diff -u -p -r1.5 names.c
--- alsa-utils/alsactl/names.c	17 May 2005 10:38:07 -0000	1.5
+++ alsa-utils/alsactl/names.c	19 Sep 2005 13:28:54 -0000
@@ -204,6 +204,8 @@ static int probe_pcm_card(int card, snd_
 		"surround51:%i", "Front, Rear, Center and Woofer",
 		"surround71:%i", "Front, Rear, Side, Center and Woofer",
 		"spdif:%i", "S/PDIF (IEC958) Optical or Coaxial Wire",
+		"phoneline:%i", "Phone Line Interface",
+		"modem:%i", "Soft Modem",
 		NULL
 	};
 	
@@ -239,7 +241,8 @@ static int probe_pcm_card(int card, snd_
 			class = snd_pcm_info_get_class(info2);
 		}
 		if (class != SND_PCM_CLASS_GENERIC &&
-		    class != SND_PCM_CLASS_MULTI)	/* skip this */
+		    class != SND_PCM_CLASS_MULTI &&
+		    class != SND_PCM_CLASS_MODEM )	/* skip this */
 			continue;
 		if (first) {
 			for (idx = 0; vnames1[idx] != NULL; idx += 2)


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
