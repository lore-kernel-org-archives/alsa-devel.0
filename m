From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] ac97_codec(modem): MC97 registers reset.
Date: Tue, 05 Apr 2005 03:54:47 +0300
Message-ID: <E1DJBS9-0002DD-UB@sc8-sf-mx1.sourceforge.net>
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-To: alsa-devel@lists.sourceforge.net
Resent-message-id: <20050406142330.GB29933@sashak.softier.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Actually I don't see any real problem with just AC97_RESET (so this
patch is probably optional), but spec (AC97 rev 2.3) recommends to use
AC97_EXTENDED_MID for modem codec registers reset and AC97_RESET for
audio resisters reset.

Sasha.


Summary: MC97 registers reset

Separated ac97 registers reset for audio and modem (or both) as recommended
in AC97 spec.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.180
diff -u -b -B -r1.180 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	29 Mar 2005 15:33:28 -0000	1.180
+++ alsa-kernel/pci/ac97/ac97_codec.c	2 Apr 2005 22:44:12 -0000
@@ -1872,7 +1872,11 @@
 			goto __access_ok;
 	}
 
-	snd_ac97_write(ac97, AC97_RESET, 0);	/* reset to defaults */
+	/* reset to defaults */
+	if (!(ac97->scaps & AC97_SCAP_SKIP_AUDIO))
+		snd_ac97_write(ac97, AC97_RESET, 0);
+	if (!(ac97->scaps & AC97_SCAP_SKIP_MODEM))
+		snd_ac97_write(ac97, AC97_EXTENDED_MID, 0);
 	if (bus->ops->wait)
 		bus->ops->wait(ac97);
 	else {



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
