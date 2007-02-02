From: Jakub Schmidtke <sjakub@gmail.com>
Subject: [PATCH 2/2] Added ALC861VD/ALC660VD support to
	hda-intel
Date: Fri, 2 Feb 2007 18:13:15 +0100
Message-ID: <200702021813.15963.sjakub@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rE3wFY7yVnXo2Yz"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_rE3wFY7yVnXo2Yz
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Changes:-

o Added new models to ALSA-Configuration.txt


Signed-off-by: Jakub Schmidtke <sjakub@gmail.com>

--Boundary-00=_rE3wFY7yVnXo2Yz
Content-Type: text/x-diff; charset="iso-8859-2"; name="alc861vd_660vd_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alc861vd_660vd_2.patch"

--- a/Documentation/ALSA-Configuration.txt	2007-02-02 17:43:41.000000000 +0100
+++ b/Documentation/ALSA-Configuration.txt	2007-02-02 17:45:12.000000000 +0100
@@ -844,6 +844,13 @@
 	  asus-laptop	ASUS F2/F3 laptops
 	  auto		auto-config reading BIOS (default)
 
+	ALC861VD/660VD
+	  3stack	3-jack
+	  3stack-dig	3-jack with SPDIF OUT
+	  6stack-dig	6-jack with SPDIF OUT
+	  3stack-660	3-jack (for ALC660VD)
+	  auto		auto-config reading BIOS (default)
+
 	CMI9880
 	  minimal	3-jack in back
 	  min_fp	3-jack in back, 2-jack in front

--Boundary-00=_rE3wFY7yVnXo2Yz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_rE3wFY7yVnXo2Yz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_rE3wFY7yVnXo2Yz--
