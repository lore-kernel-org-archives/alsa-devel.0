From: Martin Langer <martin-langer@gmx.de>
Subject: usx2yloader: us224 fix
Date: Sun, 1 Feb 2004 12:54:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040201115415.GA1531@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, David <david@robot-droid.com>
List-Id: alsa-devel@alsa-project.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

our assumption in the usx2yloader for an US-224 was wrong (the prepad
size differs). I've attached a patch which fix this in alsa-firmware.

Instead of usx2y.prepad (which can be removed now) I've created two new
prepad files for the usx2yloader: us122.prepad, us224.prepad. They should be
copied to alsa-firmware/usx2yloader.

Thanks to David Coulm for his help.


martin

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usx2yloader-us224.patch"

--- us122.conf.ORIGINAL	Sun Feb  1 12:18:26 2004
+++ us122.conf	Sun Feb  1 12:19:02 2004
@@ -1,5 +1,5 @@
 # boot firmwares for Tascam us122 deviceid 0x8007
 
-dsp0	usx2y.prepad
+dsp0	us122.prepad
 dsp1	us122.rbt
 
--- us224.conf.ORIGINAL	Thu Jan 29 23:47:49 2004
+++ us224.conf	Thu Jan 29 23:48:04 2004
@@ -1,5 +1,5 @@
 # boot firmwares for Tascam us224 deviceid 0x8005
 
-dsp0	usx2y.prepad
+dsp0	us224.prepad
 dsp1	us224.rbt
 
--- Makefile.am.ORIGINAL	Thu Jan 29 23:47:15 2004
+++ Makefile.am	Sun Feb  1 12:21:39 2004
@@ -1,7 +1,7 @@
 MYNAME = usx2yloader
 
 cfg_files = 	us122.conf us224.conf us428.conf \
-		usx2y.prepad us428.prepad \
+		us122.prepad us224.prepad us428.prepad \
 		us122.rbt us224.rbt us428.rbt \
 		tascam_loader.ihx \
 		us122fw.ihx us224fw.ihx us428fw.ihx

--XsQoSWH+UP9D9v3l
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="us224.prepad"
Content-Transfer-Encoding: base64

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAA==

--XsQoSWH+UP9D9v3l
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="us122.prepad"
Content-Transfer-Encoding: base64

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAA=

--XsQoSWH+UP9D9v3l--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
