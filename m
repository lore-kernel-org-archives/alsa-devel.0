From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What to do?
Date: Fri, 03 Sep 2004 14:16:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409031411560.16124-100000@studcom.urz.uni-halle.de>
References: <000e01c491ac$5b5adb60$4f015d0a@asuya>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 19DD4289
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 14:16:32 +0200 (MEST)
In-reply-to: <000e01c491ac$5b5adb60$4f015d0a@asuya>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?koi8-r?B?4c7E0mnKIPHSxc3Lzw==?= <and@if.energy.gov.ua>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

=E1=CE=C4=D2i=CA =F1=D2=C5=CD=CB=CF wrote:
> ...
> checking for current directory... /usr/src/linux-2.4.18/alsa-driver=
-1.0.0rc2/alsa-driver-1.0.0rc2
> ...
> checking for directory with kernel source... /usr/src/linux
> checking for kernel version... 2.2.19-3.asp
> checking for GCC version... Kernel compiler: gcc egcs-2.91.66 19990=
314/Linux (egcs-1.1.2 release) Used compiler: 2.96
> Fatal error: Compiler type does not match
> Decoded kernel compiler: type=3Degcs version=3D2.91.66
> Decoded used compiler: type=3Dgcc version=3D2.96

If the kernel you're compiling ALSA for is not the kernel currently
running, you have to tell the configure script which kernel to use
with the --with-kernel option.  In your case, it's probably
--with-kernel=3D/usr/src/linux-2.4.18.  And you might consider using
ALSA 1.0.6 instead of 1.0.0rc2.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
