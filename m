From: Koef <koef@xs4all.nl>
Subject: Running 32 bit apps under 64 bit kernel
Date: Tue, 12 Oct 2004 16:56:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012145657.GA22992@bukken.notsupported.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
List-Id: alsa-devel@alsa-project.org

I have AMD64 machine running 64 bit 2.6.9-rc3 kernel. 64 bit sound apps run
fine, but 32 bit apps do not:

$ aplay file.wav
aplay: main:508: audio open error: Invalid argument

And I find in my syslog:

ioctl32(aplay:1080): Unknown cmd fd(3) cmd(80045500){00} arg(ffffd77c) on
/dev/snd/controlC0

A strace segment:

open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xffffd76c)  = -1 EINVAL (Invalid argument)
close(3)                                = 0
write(2, "aplay: main:508: ", 17aplay: main:508: )       = 17
write(2, "audio open error: Invalid argume"..., 34audio open error: Invalid
argument) = 34

The same segment with 64 bit aplay binary:

open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0x7fbffff41c) = 0
ioctl(3, 0x40045532, 0x7fbffff464)      = 0
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
close(3)                                = 0

-- 
Koef.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
