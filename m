From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [PATCH] fix building alsa-tools with gtk+-2.x
Date: Thu, 04 May 2006 15:23:20 +0200
Message-ID: <m2psitx6t3.fsf@vador2.mandriva.com>
References: <m24q06x9l2.fsf@vador2.mandriva.com>
	<s5hd5eugehi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DAE1227
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 15:24:53 +0200 (MEST)
In-Reply-To: <s5hd5eugehi.wl%tiwai@suse.de> (Takashi Iwai's message of "Thu, 04 May 2006 14:29:29 +0200")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > the following patch fixes building with devel packages gtk+-2
> > devel files and not gtk+-1.2 devel files (a m4 macro was renamed
> > between gtk+-1.x and gtk+-2.x):
> 
> The patch looks wrong.  The relevant parts are in if-block for
> gtk-1.x, and pkgconfig is used for gtk-2.x.

Indeed.
I understand the fix i proposed cannot be accepted as it.

Still, it does break running autoconf when gtk+-1 devel files are not
installed.
Here's the output of a build bot:


See http://qa.mandriva.com/build/iurt//cooker/x86_64/log/alsa-tools-1.0.11-2mdk.src.rpm/

Command failed: TMP=/home/builder/tmp/ sudo chroot /export/home/mandrake//iurt_unionfs/unionfs.1.1 /bin/su builder -c "rpm --rebuild /home/builder/rpm/SRPMS/alsa-tools-1.0.11-2mdk.src.rpm"
Installing /home/builder/rpm/SRPMS/alsa-tools-1.0.11-2mdk.src.rpm
Executing(%prep): /bin/sh -e /home/builder/rpm/tmp/rpm-tmp.48611
+ umask 022
+ cd /home/builder/rpm/BUILD
+ '[' 1 -eq 1 ']'
+ '[' 1 -eq 1 ']'
+ '[' 1 -eq 1 ']'
+ cd /home/builder/rpm/BUILD
+ rm -rf alsa-tools-1.0.11
+ /usr/bin/bzip2 -dc /home/builder/rpm/SOURCES/alsa-tools-1.0.11.tar.bz2
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd alsa-tools-1.0.11
+ /usr/bin/bzip2 -dc /home/builder/rpm/SOURCES/alsa-firmware-1.0.11.tar.bz2
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ echo 'Patch #0 (alsa-tools-0.9.8-sscape_ctl.c.patch.bz2):'
Patch #0 (alsa-tools-0.9.8-sscape_ctl.c.patch.bz2):
+ /usr/bin/bzip2 -d
+ patch -p0 -s
patch unexpectedly ends in middle of line
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ pushd envy24control
~/rpm/BUILD/alsa-tools-1.0.11/envy24control ~/rpm/BUILD/alsa-tools-1.0.11
+ touch NEWS ChangeLog
+ aclocal
aclocal:configure.in:17: warning: macro `AM_PATH_GTK' not found in library
+ autoconf
configure.in:17: error: possibly undefined macro: AM_PATH_GTK
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
error: Bad exit status from /home/builder/rpm/tmp/rpm-tmp.48611 (%prep)


RPM build errors:
    Bad exit status from /home/builder/rpm/tmp/rpm-tmp.48611 (%prep)


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
