From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Static versus shared builds of alsa-utils
Date: Mon, 1 Sep 2003 11:16:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309011116.33244.adrian@mcmen.demon.co.uk>
References: <Pine.HPX.4.33n.0309011007170.1268-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309011007170.1268-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 01 September 2003 09:11, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
> > [...]
> > This certainly generates large (static?) binaries:
> > -rwxr-xr-x    1 0        0         2294664 Aug 31 19:26 aplay
> >
> > But when I attempt to run any of them I get this problem:
> >
> > /usr/bin # ./aplay test.txt
> > ./aplay: No such file or directory
>
> This error message usually indicates that the executable uses a
> dynamic linker which isn't available.
>
> Do the compiler flags include --static? Maybe you can add this flag by
> setting CFLAGS explicitly when ./configure-ing.
>
>

Exactly, but how?

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
