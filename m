From: Harald Welte <laforge@gnumonks.org>
Subject: Re: atiixp: Problems making it work on SB400
Date: Fri, 24 Jun 2005 22:16:52 +0200
Message-ID: <20050624201652.GO19928@sunbeam.de.gnumonks.org>
References: <20050624165908.GL19928@sunbeam.de.gnumonks.org> <s5h1x6rlk8x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1x6rlk8x.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi!

On Fri, Jun 24, 2005 at 07:47:42PM +0200, Takashi Iwai wrote:
> After a quick look at your information, I couldn't find anything
> wrong.  The ac97 register values look OK (compared with ALC658
> datasheet).

Yes, I meanwhile obtained the datasheet, too (and played with GPIO
output and EAPD bits, but at no success).

> Just to be sure, could you install alsa-driver-1.0.9b?

I tried that, too (forgot to mention it in my initial mail.

> There have been some bug reports with ATIIXP-laptop, and interestingly
> someone reported that it was fixed by disabling ACPI.  But, his case
> was only for the speaker output, so not 100% identical with your
> case.

For some strange reason, the headphone output now works.  I don't really
know what I did different from my first tries where it wasn't working.

So it seems like I'm observing the same bug.

Booting with acpi=3Doff didn't change the behaviour, and the BIOS config
is so stripped-down that it has no option to disable ACPI.

The only thing that I could find was that the atiixp (not ac97)
registers 0x10 and 0x14 change when inserting/removing a plug into the
headphone jack.  Unfortunately there is no public datasheed for the
SB400 :(

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCvGo0XaXGVTD0i/8RApjXAKCUAxb8OaxvL7bka3IvVtmWP2o+CwCeJJ6Z
S28GB1QgDauA7uHI2pF/t9M=
=prbY
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
