From: Pavel Roskin <proski@gnu.org>
Subject: USB audio doesn't compile on Linux-2.2.21
Date: Tue, 27 Aug 2002 19:03:01 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208271834490.12587-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

The CVS version of ALSA doesn't compile on a 2.2.21 kernel.  The error 
messages (just the beginning, there are more) are:

In file included from usbaudio.c:2:
../alsa-kernel/usb/usbaudio.c:1234: warning: `struct usb_device_id'
declared inside parameter list
../alsa-kernel/usb/usbaudio.c:1234: warning: its scope is only this
definition or declaration, which is probably not what you want.
../alsa-kernel/usb/usbaudio.c:1237: elements of array `usb_audio_ids' have
incomplete type

Indeed, there is no usb_device_id in the sources of Linux-2.2.21.  I tried 
to fix the driver, but it became clear that the fix won't be trivial.  

Actually, USB support exists and works fine in Linux-2.2.x, it just uses
different structures.  I'm almost sure it's possible to support 2.2
kernel.

As far as I understand, 2.2 drivers check for matching devices themselves
and cannot use the generic code that appeared in 2.4 series.  Some 2.4
devices (scanner.c) also do matching themselves, so that the user can
supply the ID as the parameter to the module.  This may be the only issue,
because most error messages disappear when I comment out the device table.

I don't know if you would like to port the driver to 2.2 kernels or not, I 
just don't want the default build to fail on 2.2 kernels.  Please consider 
disabling usb-audio driver for 2.2 kernels in the meantime.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
