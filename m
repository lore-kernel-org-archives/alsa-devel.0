From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]only start us428control if an us428 listens
Date: Wed, 3 Dec 2003 23:08:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312032305.08537.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T7lz/vxB0keYFVP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


--Boundary-00=_T7lz/vxB0keYFVP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

please commit. thanks!

Karsten



--Boundary-00=_T7lz/vxB0keYFVP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tascam_fpga.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tascam_fpga.in.patch"


Index: alsa-tools/usx2yloader/tascam_fpga.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/tascam_fpga.in,v
retrieving revision 1.2
diff -u -r1.2 tascam_fpga.in
--- alsa-tools/usx2yloader/tascam_fpga.in	2 Dec 2003 11:57:06 -0000	1.2
+++ alsa-tools/usx2yloader/tascam_fpga.in	3 Dec 2003 21:54:27 -0000
@@ -1,18 +1,45 @@
 #!/bin/sh
-# load the firmware into Tascam USB devices (FPGA design)
+# load the firmware into Tascam USB devices (FPGA design),
+# start appropriate control application.
 
 prefix=@prefix@
 exec_prefix=@exec_prefix@
 
 LOADER=@bindir@/usx2yloader
+CONTROLLER=
 
-if [ -x /usr/bin/logger ]; then
-	/usr/bin/logger -t $0 "calling $LOADER for $DEVICE"
+if [ -x $LOADER ]; then
+	if [ -x /usr/bin/logger ]; then
+		/usr/bin/logger -t $0 "calling $LOADER for $DEVICE"
+	fi
+	$LOADER
+else
+	if [ -x /usr/bin/logger ]; then
+		/usr/bin/logger -t $0 "missing $LOADER for $DEVICE"
+	fi
 fi
-$LOADER
-if [ -x @bindir@/us428control ]; then
-	@bindir@/us428control &
+
+case $PRODUCT in
+1604/8001/*)
+	CONTROLLER=@bindir@/us428control
+	;;
+*)
+	;;
+esac
+
+if [ -n $CONTROLLER ]; then
+	if [ -x $CONTROLLER ]; then
+		if [ -x /usr/bin/logger ]; then
+			/usr/bin/logger -t $0 "starting $CONTROLLER for $DEVICE"
+		fi
+		$CONTROLLER &
+	else
+		if [ -x /usr/bin/logger ]; then
+			/usr/bin/logger -t $0 "missing $CONTROLLER for $DEVICE"
+		fi
+	fi
 fi
+
 if [ -x /usr/bin/logger ]; then
 	/usr/bin/logger -t $0 "leaving"
 fi

--Boundary-00=_T7lz/vxB0keYFVP--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
