From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Envy24control man page
Date: Tue, 14 Feb 2006 15:51:10 +0000
Message-ID: <200602141551.10931.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uxf8DT3BLBvkcfB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


--Boundary-00=_uxf8DT3BLBvkcfB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Following previous patches, this updates the man page for two extra options 
that were added.

e24c-man-update.diff:

Update envy24control man page for options -t and -w.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_uxf8DT3BLBvkcfB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e24c-man-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-man-update.diff"

--- alsa-tools-1.0.10/envy24control/envy24control.1	2005-08-03 14:52:13.000000000 +0100
+++ alsa-tools-1.0.10/Aenvy24control/envy24control.1	2006-02-14 13:03:48.000000000 +0000
@@ -4,7 +4,7 @@
 soundcards, under ALSA.
 
 .SH "SYNOPSIS"
-\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel] [\fI\-M\fP]
+\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel] [\fI\-M\fP] [\fI\-w\fP window\-width] [\fI\-t\fP 0\-9]
 
 .SH "DESCRIPTION"
 \fBenvy24control\fP allows control of the digital mixer, channel gains
@@ -13,7 +13,7 @@
 displays a level meter for each input and output channel.
 
 .SH "INVOKING"
-\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel] [\fI\-M\fP]
+\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel] [\fI\-M\fP] [\fI\-w\fP window\-width] [\fI\-t\fP 0\-9]
 .TP 
 If no control\-name is given, then the first sound card is used.
 
@@ -65,6 +65,16 @@
.TP
 \fI\-M\fP
 Use an enhanced mapping from midi controller values to db sliders.
+.TP
+\fI\-w\fP window\-width
+Specify the initial width of the envy24control window.
+Using window\-width in the range 0\-20 specifies approx number of mixer channels visible.
+Values >20 are interpreted as screen pixels.
+.TP
+\fI\-t\fP tall\-equal mixer heights
+Using \fI\-t\fP 1 enlarges the channel mixers to the same height as the digital mixer.
+With values >1 the height of all mixers is increased in stages.
+\fI\-t\fP 0 is the default, set for minimum window height.
 .SH "SEE ALSO"
 \fB
 alsamixer(1),
@@ -75,4 +85,5 @@
 .SH "AUTHOR"
 \fBenvy24control\fP is  by Jaroslav Kysela <perex@suse.cz>
 This document is by James Tappin <james@xena.uklinux.net>.
-Last updated by Dirk Kalis <dirk.kalis@t\-online.de>.
+Updated by Dirk Kalis <dirk.kalis@t\-online.de>.
+Options\fI\-w\ and \fI\-t\fP added Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_uxf8DT3BLBvkcfB--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
