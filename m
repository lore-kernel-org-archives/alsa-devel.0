From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: What to do?
Date: Fri, 3 Sep 2004 16:11:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409031610070.21405@linux.local>
References: <Pine.HPX.4.33n.0409031411560.16124-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4E3D42C0
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 16:23:34 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0409031411560.16124-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ????i? ?????? <and@if.energy.gov.ua>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Sep 2004, Clemens Ladisch wrote:

> =E1=CE=C4?i? ???=CD=CB? wrote:
> > ...
> > checking for current directory... /usr/src/linux-2.4.18/alsa-driver-1.0=
=2E0rc2/alsa-driver-1.0.0rc2
> > ...
> > checking for directory with kernel source... /usr/src/linux
> > checking for kernel version... 2.2.19-3.asp
> > checking for GCC version... Kernel compiler: gcc egcs-2.91.66 19990314/=
Linux (egcs-1.1.2 release) Used compiler: 2.96
> > Fatal error: Compiler type does not match
> > Decoded kernel compiler: type=3Degcs version=3D2.91.66
> > Decoded used compiler: type=3Dgcc version=3D2.96
>=20
> If the kernel you're compiling ALSA for is not the kernel currently
> running, you have to tell the configure script which kernel to use
> with the --with-kernel option.  In your case, it's probably
> --with-kernel=3D/usr/src/linux-2.4.18.  And you might consider using
> ALSA 1.0.6 instead of 1.0.0rc2.

Also, it might be required to specify different compilator for
older RH kernels. Try something like this:

CC=3Degcs ./configure <your_parameters>

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
