From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: configure and compile errors (possibly because of gcc
 3.3)
Date: Fri, 20 Jun 2003 09:23:41 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306200912570.9190-100000@studcom.urz.uni-halle.de>
References: <20030619132925.68cb59bd.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030619132925.68cb59bd.hanno@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hanno B=F6ck wrote:
> Kernel compiler: gcc-Version 3.3 (Gentoo Linux 1.4, PVR 3.3)
> Used compiler:   gcc (GCC) 3.3 (Gentoo Linux 1.4, PVR 3.3)
> ...
> Decoded kernel compiler: type=3Dgcc-Version version=3D3.3
> Decoded used compiler:   type=3Dgcc         version=3D3.3
>
> Well, the kernel compiler and the used compiler are definitely the =
same.

Well, the identification strings aren't (not exactly).

> checking for kernel version... 2.4.21-ac1
> ...
> serialmidi.c: In function `open_tty': serialmidi.c:158: error: inva=
lid operands to binary >

The -ac patch changes the count field's type to atomic_t. Change the
offending line to:

=09if (atomic_read(&tty->count) > 1) {


HTH
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
