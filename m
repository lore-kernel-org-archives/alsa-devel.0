From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Static versus shared builds of alsa-utils
Date: Mon, 1 Sep 2003 19:44:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309011944.06017.adrian@mcmen.demon.co.uk>
References: <Pine.HPX.4.33n.0309011225190.11732-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309011225190.11732-100000@studcom.urz.uni-halle.de>
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

On Monday 01 September 2003 11:27, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
> > > Do the compiler flags include --static? Maybe you can add this flag=
 by
> > > setting CFLAGS explicitly when ./configure-ing.
> >
> > Exactly, but how?
>
> CC=3Dsh-linux-gcc CFLAGS=3D--static ./configure --xxx=3D...
>
>
> HTH
> Clemens

Cheers,

It works :)

Many thanks - have to get on with building the driver now.

Adrian



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
