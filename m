From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
Date: Mon, 5 Aug 2013 15:07:29 +0100
Message-ID: <20130805140729.GC9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4648647801791873102=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FFA348.2010503@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4648647801791873102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WaWVzWcmZYO3Beyi"
Content-Disposition: inline


--WaWVzWcmZYO3Beyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 03:06:16PM +0200, Sebastian Hesselbarth wrote:

> looking at e.g. nvidia,tegra-audio-*.txt bindings, I guess you are
> proposing to have a new binding for every SoC/codec/board combination?
> Also, you should have seen "ASoC: fsl: Add S/PDIF machine driver", which
> is - again - proposing a new binding for fsl with spdif "codec".

> You really want me to go the same way or is there any "other board
> binding" I should follow?

Yes, go that way.  There is the simple-card driver which should be able
to grow to consume most of these things for simple stereo CODECs, having
the common clock API more widely available so we can create a hard
requirement that clocks be described using the clock API would help a
lot with that.

> That will be one machine driver for possibly all Marvell boards, not
> what e.g. tegra is doing with one machine driver for each board they
> can find. I understand that the exact wiring on each board may get
> complicated, but I don't see why a (well thought) binding should not
> be able to describe it?

The clocking arrangements for a smartphone are not that trivial and we
need to be able to cope with things like having more than two devices on
the bus.

--WaWVzWcmZYO3Beyi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/7GdAAoJELSic+t+oim9ZrIP/RyRNe7/jzlSD5qiGaLxR/wf
A4X4Ue7bYsa9+7ZM5cfn0cUDc8ATDBqQuI9ICxwK7lKi+ENizy4tsQxlKS5x4OM3
aAKMI8iqzi5jOiMAoxEeSXQJRxPeCBGdzK09UP0NkYnyLEiQQwaAa3mzY7eq7zO0
9ZgY+6iDD7lrgphVBE7RKvK76+TfZoyjD3nxnepn3DCRkrT9oePDub0WX36LpWqo
umj2P7yJ4s3qBQReRLOpsoGoRxIPazLdpqMQMAbQvOJZuHer/nDacXpTU6RDHYfe
C44/vXSK2PimKhigTXqopWNWOGtcN/HOpN8cVqHZxRsDdzUuBoXmrOeS8Vbn5XI0
fgdMKdZ5qeLkkxN5+oxMJ2tk9W2/oLgR1t8+0OT5vzSW9cDFu0/VRUk9TK/uFm6W
GL5in+jjMj3x3opl/vLzFGTcRT0wONDlxynDCvqMfZJoU2PB+yvgmM5fBMRoq6xR
/g7xJ8CbP0Z8TaaMdoPDOs7Fc13XwSZapqv/6v55z/yhISicc+7SWCMRa2D7q8A8
1dQYMWZ6WIxQL3AuprLxAtmcwuNDnbDK4ODo1nW5NQSf4cUFrmYVz2EfalSh9Ggm
yeBQYHEjlvYvRUEfNugEYUeCEf6TQQEx8/8C5eTg+TrMZ5Bnpx0Ywr8NLzndLnPI
WinxQMRG8o8IGJwSzlQk
=S1sC
-----END PGP SIGNATURE-----

--WaWVzWcmZYO3Beyi--


--===============4648647801791873102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4648647801791873102==--
