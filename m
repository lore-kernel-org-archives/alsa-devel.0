From: Harald Welte <laforge@gnumonks.org>
Subject: Re: GPL Violation in Aldi PC Medion MD95500
Date: Thu, 28 Apr 2005 12:34:17 +0200
Message-ID: <20050428103417.GL7407@sunbeam.de.gnumonks.org>
References: <Pine.LNX.4.58.0504101821320.12537@tigger.tange.dk> <Pine.HPX.4.33n.0504151831520.8806-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N5iGxCIPT7YMRg16"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0504151831520.8806-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: legal@lists.gpl-violations.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--N5iGxCIPT7YMRg16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2005 at 06:50:27PM +0200, Clemens Ladisch wrote:
> Ole Tange wrote:
> > I just bought Aldi PC Medion MD95500. It comes with a neat system for
> > playing DVDs without starting Microsoft Windows. It boots a small Linux
> > system for this. The manual does not contain GPL. None of the unwrapped
> > CDs contain GPL.
> > ...
> > ./image-mnt/lib/modules/snd-seq-device.ko
> > ./image-mnt/lib/modules/snd-pcm.ko
> > ./image-mnt/lib/modules/snd.ko
> > ./image-mnt/lib/modules/snd-mixer-oss.ko
> > ./image-mnt/lib/modules/snd-timer.ko
> > ./image-mnt/lib/modules/snd-seq-midi-event.ko
> > ./image-mnt/lib/modules/snd-page-alloc.ko
> > ./image-mnt/lib/modules/snd-pcm-oss.ko
> > ./image-mnt/lib/modules/snd-seq-oss.ko
> > ./image-mnt/lib/modules/snd-seq.ko
>=20
> These are ALSA modules.  A few lines of code in these were written by
> me.  Most was written by Jaroslaw Kysela and Takashi Iwai (both are
> SUSE employees).

=2E.. so suse owns the copyright and is the one who'd have to enforce on
them.

I'm already in negotiations with Medion.  They're referring their users
to http://www.gocyberlink.com/english/companybg/pcmlinuxgpl.jsp, which
is not sufficient.

The above cyberlink url only contains linux-2.6.6, whereas the md95500
object code contains linux-2.6.9.  Despite that, it's missing a number
of source code pieces, including alsa-lib, libgdk, ...

Interestingly, I cannot get the audio working with vanilla 2.6.11 or
2.6.12-rc3 kernels.. so maybe they've also tweaked something within the
audio drivers...

cheers,
	Harald
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--N5iGxCIPT7YMRg16
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCcLwpXaXGVTD0i/8RAiiLAKCVwJEpbp5rBvyMJhj/hrfiw/igKQCgkCuf
WAapt6hOKeiBv/3FmyOgNew=
=GyZZ
-----END PGP SIGNATURE-----

--N5iGxCIPT7YMRg16--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
