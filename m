From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]us428control.patch.0.4
Date: Mon, 27 Oct 2003 20:34:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310272034.37164.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NNXn/DM2/2yFH9D"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_NNXn/DM2/2yFH9D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

please commit this with Comment:
>>>
Initialize Cus428State::SelectInputMonitor in Ctor.
<<<

Danke, 
Karsten

--Boundary-00=_NNXn/DM2/2yFH9D
Content-Type: text/x-diff;
  charset="us-ascii";
  name="us428control.patch.0.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="us428control.patch.0.4"

Index: alsa-tools/us428control/Cus428Midi.cc
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428Midi.cc,v
retrieving revision 1.1
diff -u -r1.1 Cus428Midi.cc
--- alsa-tools/us428control/Cus428Midi.cc	24 Oct 2003 14:01:45 -0000	1.1
+++ alsa-tools/us428control/Cus428Midi.cc	27 Oct 2003 19:26:10 -0000
@@ -1,3 +1,22 @@
+/*
+ *
+ * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
 #include <alsa/asoundlib.h>
 #include "Cus428Midi.h"
 
Index: alsa-tools/us428control/Cus428Midi.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428Midi.h,v
retrieving revision 1.1
diff -u -r1.1 Cus428Midi.h
--- alsa-tools/us428control/Cus428Midi.h	24 Oct 2003 14:01:45 -0000	1.1
+++ alsa-tools/us428control/Cus428Midi.h	27 Oct 2003 19:26:10 -0000
@@ -1,3 +1,22 @@
+/*
+ *
+ * Copyright (c) 2003 by Karsten Wiese <annabellesgarden@yahoo.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
 #include <sound/asequencer.h>
 #include "Cus428State.h"
 
Index: alsa-tools/us428control/Cus428State.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/Cus428State.h,v
retrieving revision 1.2
diff -u -r1.2 Cus428State.h
--- alsa-tools/us428control/Cus428State.h	24 Oct 2003 14:01:45 -0000	1.2
+++ alsa-tools/us428control/Cus428State.h	27 Oct 2003 19:26:10 -0000
@@ -29,6 +29,8 @@
 		:us428ctls_sharedmem(Pus428ctls_sharedmem)
 		,MuteInputMonitor(0)
 		,Mute(0)
+		,SelectInputMonitor(0)
+		,Select(0)
 		,us428_ctls(0)
 		{
 			init_us428_lights();
Index: alsa-tools/us428control/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/us428control/configure.in,v
retrieving revision 1.2
diff -u -r1.2 configure.in
--- alsa-tools/us428control/configure.in	24 Oct 2003 14:01:45 -0000	1.2
+++ alsa-tools/us428control/configure.in	27 Oct 2003 19:26:10 -0000
@@ -1,5 +1,5 @@
 AC_INIT(us428control.cc)
-AM_INIT_AUTOMAKE(us428control, 0.3)
+AM_INIT_AUTOMAKE(us428control, 0.4)
 AC_PROG_CXX
 AC_PROG_INSTALL
 AC_HEADER_STDC

--Boundary-00=_NNXn/DM2/2yFH9D--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
