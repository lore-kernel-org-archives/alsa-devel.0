From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#436502: alsa-tools ->
	usx2yloader
Date: Wed, 12 Sep 2007 22:52:56 +0200
Message-ID: <20070912205256.GR4125@frodo.home.lxtec.de>
References: <20070911152102.GA17585@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AD7C2446A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:53:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070911152102.GA17585@frodo.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pkg-alsa-devel@lists.alioth.debian.org, alsa-devel <alsa-devel@alsa-project.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, 436502@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Tue, 11 Sep 2007 the mental interface of
Elimar Riesebieter told:

> Hi all,
> 
> according to Debian #436502 I am asking herefore if there are plans
> to port asx2yloader from the old hotplug to udev? Debian lenny/sid
> relies on udev only, though.
> 
> Thanks in advance

Attached is a patch for the Makefiles and an udev rule which should
work anyway. I don't have TASCAM US-122 usb hardware handy, so
I would be very pleased if someone could test it.

Thanks

Elimar


-- 
  Never make anything simple and efficient when a way 
  can be found to make it complex and wonderful ;-)

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="usx2yloader_udev.patch"

Make usx2yloader work with udev
-- Elimar Riesebieter <riesebie@lxtec.de>  Wed, 12 Sep 2007 18:21:16 +0200

diff -urd alsa-tools-1.0.14~/usx2yloader/Makefile.am alsa-tools-1.0.14/usx2yloader/Makefile.am
--- alsa-tools-1.0.14~/usx2yloader/Makefile.am	2007-06-04 13:27:26.000000000 +0200
+++ alsa-tools-1.0.14/usx2yloader/Makefile.am	2007-09-12 18:18:24.000000000 +0200
@@ -11,8 +11,8 @@
 
 EXTRA_DIST = depcomp tascam_fw.usermap tascam_fw.in tascam_fpga.in
 
-hotplug_files = tascam_fw.usermap tascam_fw tascam_fpga
-hotplugdir = /etc/hotplug/usb
+hotplug_files = tascam_fw tascam_fpga
+hotplugdir = /lib/udev
 hotplug_SCRIPTS = $(hotplug_files)
 
 
diff -urd alsa-tools-1.0.14~/usx2yloader/Makefile.in alsa-tools-1.0.14/usx2yloader/Makefile.in
--- alsa-tools-1.0.14~/usx2yloader/Makefile.in	2007-06-04 13:29:06.000000000 +0200
+++ alsa-tools-1.0.14/usx2yloader/Makefile.in	2007-09-12 18:17:58.000000000 +0200
@@ -166,8 +166,8 @@
 AM_CFLAGS = -DDATAPATH=\"$(datadir)/alsa/firmware/$(MYNAME)\"
 usx2yloader_SOURCES = usx2yloader.c
 EXTRA_DIST = depcomp tascam_fw.usermap tascam_fw.in tascam_fpga.in
-hotplug_files = tascam_fw.usermap tascam_fw tascam_fpga
-hotplugdir = /etc/hotplug/usb
+hotplug_files = tascam_fw tascam_fpga
+hotplugdir = /lib/udev
 hotplug_SCRIPTS = $(hotplug_files)
 all: all-am
 

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="alsa-firmware-loaders.rules"

###############################################################################
# Description:   udev rule to load TASCAM US-122 usb sound card.
# Author:        Elimar Riesebieter <riesebie@lxtec.de>
# Created:       Wed, 12 Sep 2007 17:05:25 +0200
# Last modified: Wed, 12 Sep 2007 17:07:00 +0200
# File:          /etc/udev/alsa-tools.rules
###############################################################################

# TASCAM US-122 usb sound card.
    SYSFS{idVendor}=="1604", SYSFS{idProduct}=="8000", RUN+="/lib/udev/tascam_fw"
    SYSFS{idVendor}=="1604", SYSFS{idProduct}=="8004", RUN+="/lib/udev/tascam_fw"
    SYSFS{idVendor}=="1604", SYSFS{idProduct}=="8006", RUN+="/lib/udev/tascam_fw"
    SYSFS{idVendor}=="1604", SYSFS{idProduct}=="8001", RUN+="/lib/udev/tascam_fpga"
    SYSFS{idVendor}=="1604", SYSFS{idProduct}=="8005", RUN+="/lib/udev/tascam_fpga"
    SYSFS{idVendor}=="1604", SYSFS{idProduct}=="8007", RUN+="/lib/udev/tascam_fpga"

# vim:tw=160:syntax=udevrules


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MfFXiAuoTsnnDAfZ--
