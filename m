From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-lib: enable dmix-ing and proper
	5.1 routing for USB audio devices
Date: Tue, 13 Feb 2007 14:08:08 +0100
Message-ID: <m2ps8e2ojr.fsf@vador.mandriva.com>
References: <ALOGGER1171354291.14@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ALOGGER1171354291.14@alsa-project.org> (Clemens Ladisch's
	message of "Tue\, 13 Feb 2007 09\:11\:31 +0100 \(CET\)")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

Clemens Ladisch <clemens@ladisch.de> writes:

> changeset:   2259:038e10f8332b
> tag:         tip
> user:        cladisch
> date:        Tue Feb 13 09:01:31 2007 +0100
> files:       src/conf/cards/USB-Audio.conf
> description:
> enable dmix-ing and proper 5.1 routing for USB audio devices
> 
> add a configuration file for USB audio devices

err, don't you need sg like this:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=alsa-usb2.diff

--- ./src/conf/cards/Makefile.in.tv	2007-02-13 14:04:20.000000000 +0100
+++ ./src/conf/cards/Makefile.in	2007-02-13 14:04:25.000000000 +0100
@@ -251,7 +251,7 @@
 	HDA-Intel.conf ICE1712.conf ICE1724.conf ICH.conf ICH4.conf \
 	ICH-MODEM.conf Maestro3.conf NFORCE.conf PC-Speaker.conf \
 	PMac.conf PMacToonie.conf RME9636.conf RME9652.conf \
-	SI7018.conf TRID4DWAVENX.conf YMF744.conf VIA686A.conf \
+	SI7018.conf TRID4DWAVENX.conf USB-Audio.conf YMF744.conf VIA686A.conf \
 	VIA8233.conf VIA8233A.conf VIA8237.conf VX222.conf \
 	VXPocket.conf VXPocket440.conf $(am__append_1)
 alsa_DATA = $(cfg_files)
--- ./src/conf/cards/Makefile.am.tv	2007-02-13 14:04:44.000000000 +0100
+++ ./src/conf/cards/Makefile.am	2007-02-13 14:04:39.000000000 +0100
@@ -39,6 +39,7 @@
 	RME9652.conf \
 	SI7018.conf \
 	TRID4DWAVENX.conf \
+	USB-Audio.conf \
 	YMF744.conf \
 	VIA686A.conf \
 	VIA8233.conf \

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-=-=--
