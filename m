From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Static versus shared builds of alsa-utils
Date: Mon, 01 Sep 2003 10:11:27 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309011007170.1268-100000@studcom.urz.uni-halle.de>
References: <200308312034.57045.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200308312034.57045.adrian@mcmen.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> [...]
> This certainly generates large (static?) binaries:
> -rwxr-xr-x    1 0        0         2294664 Aug 31 19:26 aplay
>
> But when I attempt to run any of them I get this problem:
>
> /usr/bin # ./aplay test.txt
> ./aplay: No such file or directory

This error message usually indicates that the executable uses a
dynamic linker which isn't available.

Do the compiler flags include --static? Maybe you can add this flag by
setting CFLAGS explicitly when ./configure-ing.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
