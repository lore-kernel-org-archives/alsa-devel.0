From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
Date: Wed, 10 Jul 2013 11:00:20 +0100
Message-ID: <20130710100020.GA24508@sirena.org.uk>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
 <20130709145917.GA27646@sirena.org.uk>
 <CACQ1gAgHuAcBAAgYaP-n9grrM6X0L9b1mFFfkRg0HH_RnRuXMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6267381938235715252=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACQ1gAgHuAcBAAgYaP-n9grrM6X0L9b1mFFfkRg0HH_RnRuXMg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6267381938235715252==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2013 at 11:25:37AM +0200, Richard Genoud wrote:
> 2013/7/9 Mark Brown <broonie@kernel.org>:

> > Shouldn't the SSC driver be enforcing this constraint if it comes from
> > the SSC hardware?  If the clock is reprogrammable the usual convention
> > for drivers is to not constrain if the clock is set to zero so a machine
> > driver could remove the constraint.

> Actually, my comment is buggy here (or at least, unrelated to the
> authorized rates).
> The "MCLK_RATE" is the master clock of the wm8731 codec (a 12.288MHz crystal).
> According to the datasheet of wm8731, when a 12.288 crystal is used,
> the authorized rates are 8, 32, 48 and 96kHz (I have to remove 16 and
> 64kHz).

> So, is this the right place for the rates ?

No, the CODEC driver should be enforcing the restrictions if that's
where they come from.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3TCsAAoJELSic+t+oim96l4QAIBNdsDlUYqOzzE2DqS09ARC
LGwnmmxhDThgOEgKOlgaRVz215VBl7h+IB77pwGYwesWkMJlW7PhC3ES2fPmM/9i
aRkDx+2DKeRPjNJS2uvfmKo+ueF4PQEBkCsnHmbKphgmUA+LIkzp4bRarzKxqOqE
uL7g682JHdUvD3wYSvVg2w8AoOCRZzLsdIUNeIkK8WKLcrK9OWBJwKagO5JpF1m7
ZInX+d+5u0Sf13wOFk41fEtMKVzGKUuuji6HaPX4KUJsHufEHHLfhpE1Lan0Ag8y
g2/e+7g89QNIyJ9gt8SCTI0yf2B7ObdIfnzct++S5puhAlsOAgQ0/imPXtFIGQt8
w9ezl0Az8EcLkiU9U3/uEUT7Jcd6wi9nBaTCdnv3IexxJbO/JEs+K+qrSlwi9e/H
q8oPbw0Q9iJ3C2BLMVsVizezwpOo5bPbg5Xh7wZwroe5Ddf+6N2HpmAIn9HgbWne
yDC++oc/+xw7NWXLMUE0ZCSvCs7ebqoI37HAcM6638foCIP9Pe12jAJqmfRvpGfG
kSLeKy9cvuATNYySk/8iPPHAbh0Vi6ITZtjvcTKYt86nmKvpsD84bEaSihZD3GC3
hk5iTG2oYdImrGGnzLwOpazpcm0aPOhB5YRB7xzoyQmpzZWXzpyOYpweODnd3A8l
ScFk6Lu0rf3WnDaFHOjV
=bPxQ
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--


--===============6267381938235715252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6267381938235715252==--
