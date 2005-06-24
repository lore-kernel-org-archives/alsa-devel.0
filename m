From: Sebastian Henschel <sebastian@mali.geekcorps.org>
Subject: Re: [Alsa-user] snd-via82xx on EPIA-M - 0 analog subsections not ready
Date: Fri, 24 Jun 2005 10:59:42 +0000
Message-ID: <20050624105942.GA10544@fingerbrecher>
References: <20050623184321.GA7728@fingerbrecher> <1119555870.13259.26.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1119555870.13259.26.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--jq0ap7NbKX2Kqbes
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello Lee...

thanks for your reply...

* Lee Revell <rlrevell@joe-job.com> [2005-06-24 08:51 +0000]:
> On Thu, 2005-06-23 at 18:43 +0000, Sebastian Henschel wrote:
> > hi list,
> >=20
> > i am working on a machine with an EPIA-M mainboard and the ICEensemble
> > VT1616i sound chip (see attached lspci -v).
>=20
> Thanks, this is an excellent bug report.  It sounds like a not quite
> fully supported device.

so should i open a bug report on that?

btw, i forgot to attach the dmesg for the OSS driver and my /etc/asound.con=
f.
here you got.



> On a related topic, it seems like a lot of users waste hours and hours
> changing settings before they even consider that they might have a
> hardware variation we have not seen before.

given that the BIOS is dated from somewhere from 2004 and that the
EPIA-M is not unpopular, i would have thought it is well-known. but
perhaps this is just another hardware revision (rev 50 in this case)
which might do something slightly different than the revisions before.

=20
> I'll see if I can identify the specific errors that could indicate an
> unknown device, or anything other situation where something very strange
> has happened and we want the user to contact us with the details.  Any
> suggestions?

check for the hardware revision, if possible.


thanks,
 Sebastian
--=20
Oo.....................
 wer ein ganzer mensch ist, braucht keine autoritaet zu sein.
 OpenPGP key ID: 0x4A1F5E81  Geekcode: GCSd-s:a-C++ULB+++W++M+PS+++
                                                ..................oO

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asound.conf"

pcm.via82xx {
	type hw
	card 0
}

ctl.via82xx {
	type hw
	card 0
}

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.oss"

Via 686a/8233/8235 audio driver 1.9.1-ac4-2.5
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 10 (level, low) -> IRQ 10
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 0000:00:11.5 to 64
ac97_codec: AC97 Audio codec, id: ICE82 (Unknown)
via82cxxx: board #1 at 0xE400, IRQ 10

--tKW2IUtsqtDRztdT--

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCu+eeqe04hEofXoERAqLoAJ9j2fHoR/80Q78S9ZowKPt7P1iUPACgl7Df
ZbyuIQDz8ES5bxQgq1nH4q4=
=gOJY
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
