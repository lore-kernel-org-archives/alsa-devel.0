From: "Nicolas Croiset (VDL)" <ncroiset@vdldiffusion.com>
Subject: Compilation problem with alsa driver 1.0.8rc1
Date: Wed, 29 Dec 2004 12:19:10 +0100
Message-ID: <5.2.1.1.1.20041229115540.0263b7e0@pop.int.vdldiffusion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

when I want to compile under linux Redhat 7.2 kernel 2.4.7-10 I obtain this 
compilation problem.

In file included from usx2yhwdeppcm.c:64:
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c: 
In function `i_usX2Y_urb_complete':
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c:306: 
warning: implicit declaration of function `unlikely'
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c:314: 
warning: implicit declaration of function `likely'
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c: 
In function `usX2Y_urbs_set_complete':
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c:348: 
warning: assignment from incompatible pointer type
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c: 
In function `usX2Y_urbs_allocate':
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c:457: 
warning: assignment from incompatible pointer type
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c: 
In function `usX2Y_rate_set':
/usr/src/redhat/BUILD/alsa-driver-1.0.8rc1/alsa-kernel/usb/usx2y/usbusx2yaudio.c:691: 
warning: assignment from incompatible pointer type
usx2yhwdeppcm.c: In function `usX2Y_usbpcm_urb_capt_iso_advance':
usx2yhwdeppcm.c:161: warning: initialization from incompatible pointer type
usx2yhwdeppcm.c:168: dereferencing pointer to incomplete type
usx2yhwdeppcm.c:169: dereferencing pointer to incomplete type

Bye.
Nicolas Croiset                   ncroiset@vdl.fr
Tel : +33 4 72 84 06 04   Fax : +33 4 72 84 06 02



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
