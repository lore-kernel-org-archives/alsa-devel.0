From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix dmix crashes
Date: Thu, 07 Aug 2003 11:27:11 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308071125030.5261-100000@studcom.urz.uni-halle.de>
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


pcm->name can be NULL (when an unnamed pcm node is embedded in another
pcm)


Index: alsa-lib/src/pcm/pcm_dmix.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dmix.c,v
retrieving revision 1.40
diff -u -r1.40 pcm_dmix.c
--- alsa-lib/src/pcm/pcm_dmix.c	25 Jul 2003 17:02:03 -0000	1.40
+++ alsa-lib/src/pcm/pcm_dmix.c	7 Aug 2003 09:20:51 -0000
@@ -414,9 +414,11 @@
 	info->stream = pcm->stream;
 	info->card = -1;
 	/* FIXME: fill this with something more useful: we know the hardware name */
-	strncpy(info->id, pcm->name, sizeof(info->id));
-	strncpy(info->name, pcm->name, sizeof(info->name));
-	strncpy(info->subname, pcm->name, sizeof(info->subname));
+	if (pcm->name) {
+		strncpy(info->id, pcm->name, sizeof(info->id));
+		strncpy(info->name, pcm->name, sizeof(info->name));
+		strncpy(info->subname, pcm->name, sizeof(info->subname));
+	}
 	info->subdevices_count = 1;
 	return 0;
 }
Index: alsa-lib/src/pcm/pcm_dshare.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dshare.c,v
retrieving revision 1.7
diff -u -r1.7 pcm_dshare.c
--- alsa-lib/src/pcm/pcm_dshare.c	25 Jul 2003 17:02:03 -0000	1.7
+++ alsa-lib/src/pcm/pcm_dshare.c	7 Aug 2003 09:20:52 -0000
@@ -201,9 +201,11 @@
 	info->stream = pcm->stream;
 	info->card = -1;
 	/* FIXME: fill this with something more useful: we know the hardware name */
-	strncpy(info->id, pcm->name, sizeof(info->id));
-	strncpy(info->name, pcm->name, sizeof(info->name));
-	strncpy(info->subname, pcm->name, sizeof(info->subname));
+	if (pcm->name) {
+		strncpy(info->id, pcm->name, sizeof(info->id));
+		strncpy(info->name, pcm->name, sizeof(info->name));
+		strncpy(info->subname, pcm->name, sizeof(info->subname));
+	}
 	info->subdevices_count = 1;
 	return 0;
 }
Index: alsa-lib/src/pcm/pcm_dsnoop.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dsnoop.c,v
retrieving revision 1.7
diff -u -r1.7 pcm_dsnoop.c
--- alsa-lib/src/pcm/pcm_dsnoop.c	25 Jul 2003 17:02:03 -0000	1.7
+++ alsa-lib/src/pcm/pcm_dsnoop.c	7 Aug 2003 09:20:54 -0000
@@ -184,9 +184,11 @@
 	info->stream = pcm->stream;
 	info->card = -1;
 	/* FIXME: fill this with something more useful: we know the hardware name */
-	strncpy(info->id, pcm->name, sizeof(info->id));
-	strncpy(info->name, pcm->name, sizeof(info->name));
-	strncpy(info->subname, pcm->name, sizeof(info->subname));
+	if (pcm->name) {
+		strncpy(info->id, pcm->name, sizeof(info->id));
+		strncpy(info->name, pcm->name, sizeof(info->name));
+		strncpy(info->subname, pcm->name, sizeof(info->subname));
+	}
 	info->subdevices_count = 1;
 	return 0;
 }
Index: alsa-lib/src/pcm/pcm_null.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_null.c,v
retrieving revision 1.48
diff -u -r1.48 pcm_null.c
--- alsa-lib/src/pcm/pcm_null.c	25 Jul 2003 17:02:04 -0000	1.48
+++ alsa-lib/src/pcm/pcm_null.c	7 Aug 2003 09:20:55 -0000
@@ -70,9 +70,11 @@
 	memset(info, 0, sizeof(*info));
 	info->stream = pcm->stream;
 	info->card = -1;
-	strncpy(info->id, pcm->name, sizeof(info->id));
-	strncpy(info->name, pcm->name, sizeof(info->name));
-	strncpy(info->subname, pcm->name, sizeof(info->subname));
+	if (pcm->name) {
+		strncpy(info->id, pcm->name, sizeof(info->id));
+		strncpy(info->name, pcm->name, sizeof(info->name));
+		strncpy(info->subname, pcm->name, sizeof(info->subname));
+	}
 	info->subdevices_count = 1;
 	return 0;
 }




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
