From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix amixer load error messages
Date: Tue, 24 Feb 2004 10:12:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402241009050.6462-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


fix error messages for snd_mixer_load


BTW: yesterday's change to alsa-lib's asequencer.h hasn't been
committed yet


Index: alsa-utils/amixer/amixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amixer/amixer.c,v
retrieving revision 1.79
diff -u -r1.79 amixer.c
--- alsa-utils/amixer/amixer.c	21 Feb 2004 18:44:18 -0000	1.79
+++ alsa-utils/amixer/amixer.c	24 Feb 2004 08:56:13 -0000
@@ -774,7 +774,7 @@
 	}
 	err = snd_mixer_load(handle);
 	if (err < 0) {
-		error("Mixer load error: %s", card, snd_strerror(err));
+		error("Mixer %s load error: %s", card, snd_strerror(err));
 		snd_mixer_close(handle);
 		return err;
 	}
@@ -1145,7 +1145,7 @@
 	}
 	err = snd_mixer_load(handle);
 	if (err < 0) {
-		error("Mixer load error: %s", card, snd_strerror(err));
+		error("Mixer %s load error: %s", card, snd_strerror(err));
 		snd_mixer_close(handle);
 		return err;
 	}
@@ -1427,7 +1427,7 @@
 	snd_mixer_set_callback(handle, mixer_event);
 	err = snd_mixer_load(handle);
 	if (err < 0) {
-		error("Mixer load error: %s", card, snd_strerror(err));
+		error("Mixer %s load error: %s", card, snd_strerror(err));
 		snd_mixer_close(handle);
 		return err;
 	}




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
