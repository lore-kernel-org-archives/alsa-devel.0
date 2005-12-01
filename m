From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001243]: gnome-alsamixer segfaults in snd_ctl_elem_value_set_iec958 when clicking 'Headphone Detection'
Date: Thu, 1 Dec 2005 16:29:31 +0100
Message-ID: <53d6f73e3465516eafc285e816a9a23b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E0C518F
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2005 16:29:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1243> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1243
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-08-2005 13:54 CEST
Last Modified:              12-01-2005 16:29 CET
======================================================================
Summary:                    gnome-alsamixer segfaults in
snd_ctl_elem_value_set_iec958 when clicking 'Headphone Detection'
Description: 
The submitter of Debian bug #317426 writes the following
-------------------------------------------------------------------------

I realize that I might have failed this bug against gnome-alsamixer
instead,
but I believe that the library shouldn't go into an unterminated
recursion
even if it is misused. And I don't even know for sure that it is misused,
so...

On my PowerBook 5,6 gnome-alsamixer shows a control 'Headphone Detection'
(this is kernel 2.6.12-rc5). When I try to check it, gnome-alsamixer
segfaults. Further investigating this problem, it appears that within
libasound2 there is some recursion:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 6744)]
0x0f03f1d8 in ioctl () from /lib/libc.so.6
(gdb)
(gdb) bt
#0  0x0f03f1d8 in ioctl () from /lib/libc.so.6
#1  0x0f2332c4 in snd_ctl_elem_value_set_iec958 () from
/usr/lib/libasound.so.2
#2  0x0f2332c4 in snd_ctl_elem_value_set_iec958 () from
/usr/lib/libasound.so.2
[... I gave up trying to get something relevant after seeing the next line
...]
#11385 0x0f2332c4 in snd_ctl_elem_value_set_iec958 () from
/usr/lib/libasound.so.2

even putting a breakpoint on snd_ctl_elem_value_set_iec958 didn't help.

stracing it yields:
[...]
ioctl(16, USBDEVFS_HUB_PORTINFO, 0x7f031c10) = -1 EPERM (Operation not
permitted)
ioctl(16, USBDEVFS_IOCTL, 0x7f031300)   = 0
ioctl(16, USBDEVFS_HUB_PORTINFO, 0x7f031300) = -1 EPERM (Operation not
permitted)
ioctl(16, USBDEVFS_IOCTL, 0x7f0309f0)   = 0
ioctl(16, USBDEVFS_HUB_PORTINFO, 0x7f0309f0) = -1 EPERM (Operation not
permitted)
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

Note how the values passed memory location is increasing all the time.
From
/proc/pid/maps I found that this location is the stack (which I suppose
should have been obvious to me, but I didn't really think about it).

Now, since there's apparently some usb stuff involved, I'll attach 
/proc/bus/usb/devices as well /proc/asound/cards.

If you need anything else let me know.

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (500, 'unstable'), (1, 'experimental')
Architecture: powerpc (ppc)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.12-rc5
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)

Versions of packages libasound2 depends on:
ii  libc6                         2.3.5-1    GNU C Library: Shared
libraries an

libasound2 recommends no packages.

-- no debconf information




T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 5
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.12-rc5 ehci_hcd
S:  Product=NEC Corporation USB 2.0
S:  SerialNumber=0001:10:1b.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.12-rc5 ohci_hcd
S:  Product=NEC Corporation USB (#2)
S:  SerialNumber=0001:10:1b.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.12-rc5 ohci_hcd
S:  Product=NEC Corporation USB
S:  SerialNumber=0001:10:1b.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00e Rev=11.10
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Optical Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 81/900 us ( 9%), #Int=  4, #Iso=  2
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.12-rc5 ohci_hcd
S:  Product=Apple Computer Inc. KeyLargo/Intrepid USB (#2)
S:  SerialNumber=0001:10:1a.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=8205 Rev=17.92
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05ac ProdID=020e Rev= 0.28
S:  Manufacturer=Apple Computer
S:  Product=Apple Internal Keyboard/Trackpad
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr= 40mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=atp
E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=   1 Ivl=10ms



0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                     PowerMac Snapper (Dev 0) Sub-frame 0

======================================================================

----------------------------------------------------------------------
 jdthood - 07-08-05 14:36 
----------------------------------------------------------------------
Thanks for the quick reply.

>  The control has nothing to do with IEC958, and it's read-only, so it
must be not changed at all.

Are you saying that, in your opinion, there is no bug in alsa-lib --- that
the only bug is in gnome-alsamixer?

----------------------------------------------------------------------
 jdthood - 12-01-05 16:29 
----------------------------------------------------------------------
> The control has nothing to do with IEC958, and it's read-only, so it must
be not changed at all.

Are you saying that, in your opinion, there is no bug in alsa-lib --- that
the only bug is in gnome-alsamixer?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-08-05 13:54 jdthood        New Issue                                    
07-08-05 14:31 tiwai          Note Added: 0005424                          
07-08-05 14:36 jdthood        Note Added: 0005425                          
12-01-05 16:29 jdthood        Note Added: 0006884                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
