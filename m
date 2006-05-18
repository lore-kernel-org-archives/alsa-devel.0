From: Lee Revell <rlrevell@joe-job.com>
Subject: strace and ALSA ioctls
Date: Thu, 18 May 2006 11:41:48 -0400
Message-ID: <1147966909.12531.65.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have never seen strace correctly identify a single ALSA ioctl.  This
makes debugging a serious PITA.  Is it fixable?

ioctl(3, USBDEVFS_CONTROL, 0xbfe13958)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfe13a70)     = 0
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644,
st_size=7501, ...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfe138f8)  = 0
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbfe139e4) = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbfe139e4) = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbfe136d0) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13230)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbfe136d0) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13230)    = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13230)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbfe136d0) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13250)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbfe136d0) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13230)    = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13230)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbfe136d0) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbfe13250)    = 0

etc

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
