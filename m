From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: [patch] envy24control save state of LRGang button in config file
Date: Sat, 30 Jul 2005 16:14:00 +0200
Message-ID: <42EB8B28.1040404@cubic.org>
References: <42E66ECA.10407@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090600020306070804070509"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E66ECA.10407@cubic.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090600020306070804070509
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The last mail I sent for this topic contained a non functional patch, 
which has not been included in CVS yet.
I resend the patch, which should now work.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------090600020306070804070509
Content-Type: text/plain;
 name="envy24control-stereosave.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-stereosave.patch"

Index: Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/Makefile.am,v
retrieving revision 1.15
diff -u -r1.15 Makefile.am
--- Makefile.am	21 Dec 2004 17:15:01 -0000	1.15
+++ Makefile.am	26 Jul 2005 16:58:10 -0000
@@ -3,8 +3,8 @@
 man_MANS = envy24control.1
 envy24control_SOURCES = envy24control.c envy24control.h levelmeters.c midi.c \
                         mixer.c patchbay.c hardware.c driverevents.c volume.c \
-			profiles.c profiles.h midi.h
+			profiles.c profiles.h midi.h config.c config.h
 envy24control_LDFLAGS = @ENVY24CONTROL_LIBS@
 EXTRA_DIST = envy24control.1 depcomp configure.in-gtk2 \
 	     strstr_icase_blank.c new_process.c README.profiles
 
Index: envy24control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.c,v
retrieving revision 1.35
diff -u -r1.35 envy24control.c
--- envy24control.c	24 May 2005 16:52:18 -0000	1.35
+++ envy24control.c	26 Jul 2005 16:58:11 -0000
@@ -22,6 +22,7 @@
 
 #include "envy24control.h"
 #include "midi.h"
+#include "config.h"
 #define _GNU_SOURCE
 #include <getopt.h>
 
@@ -244,7 +244,9 @@
 	gtk_widget_show(toggle);
 	gtk_box_pack_end(GTK_BOX(vbox), toggle, FALSE, FALSE, 0);
 	/* gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(toggle), TRUE); */
-	
+	gtk_signal_connect(GTK_OBJECT(toggle), "toggled",
+			   GTK_SIGNAL_FUNC(config_set_stereo), (gpointer)stream-1);
+
 	hbox = gtk_hbox_new(TRUE, 6);
 	gtk_widget_show(hbox);
 	gtk_box_pack_end(GTK_BOX(vbox), hbox, FALSE, FALSE, 0);
@@ -2116,6 +2117,7 @@
 	}
 
 	/* Initialize code */
+	config_open();
 	level_meters_init();
 	mixer_init();
 	patchbay_init();
@@ -2185,6 +2187,7 @@
 
 	snd_ctl_close(ctl);
 	midi_close();
+	config_close();
 
 	return EXIT_SUCCESS;
 }
Index: mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/mixer.c,v
retrieving revision 1.11
diff -u -r1.11 mixer.c
--- mixer.c	26 Jul 2005 11:37:11 -0000	1.11
+++ mixer.c	26 Jul 2005 16:58:11 -0000
@@ -19,6 +19,7 @@
 
 #include "envy24control.h"
 #include "midi.h"
+#include "config.h"
 
 #define	MULTI_PLAYBACK_SWITCH		"Multi Playback Switch"
 #define MULTI_PLAYBACK_VOLUME		"Multi Playback Volume"
@@ -263,4 +269,6 @@
 		if (stream_is_active[stream - 1])
 			mixer_update_stream(stream, 1, 1);
 	}
+
+	config_restore_stereo();
 }

--------------090600020306070804070509--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
