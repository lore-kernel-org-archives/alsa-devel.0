From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 02/10] ASoC: img: Add driver for I2S
 input controller
Date: Wed, 28 Oct 2015 10:04:43 +0900
Message-ID: <20151028010443.GX28319@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk>
 <56293472.7000401@imgtec.com>
 <20151023225723.GO29919@sirena.org.uk>
 <562F824F.9070407@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0509053987684889000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 482A92656F5
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 02:05:04 +0100 (CET)
In-Reply-To: <562F824F.9070407@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--===============0509053987684889000==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E5HUUwS3R9LcK7+r"
Content-Disposition: inline


--E5HUUwS3R9LcK7+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2015 at 01:55:27PM +0000, Damien Horsley wrote:
> On 23/10/15 23:57, Mark Brown wrote:

> > Shouldn't we be doing that flush on stream close instead?  If nothing
> > else the flush is going to discard a bit of data if the stream is just
> > paused.

> The FIFOs are only 8 frames in size, so I am not sure there is an
> issue with these frames being lost.

> I think it also makes sense to keep the blocks consistent with each
> other. The spdif (out and in), and parallel out, all flush automatically
> when stopped, and the fifo for the i2s out block is cleared when the
> reset is asserted.

This seems like an issue that got missed in the other drivers then.  I'd
expect the trigger operation to be a minimal operation which starts and
stops the data transfer, not doing anything else.

--E5HUUwS3R9LcK7+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMB8qAAoJECTWi3JdVIfQjyoH/AqvualpliASdv2dh3haXToA
dQ6tFIHMTCqNlWn0e4zljQmfOfhP8Ub8/NH/JOir2TQCgQD47TxUaqzoSr5V+JDc
uCFBj4PQsHzXEVypazrwQMEvCwcnTxAksZGDzjU34TtRHiDQaw/s7Lc6QqE7mba/
I3hc4a4LYJrUdjie+UM+j6SopxBQ4htpXDUpCUvBWLyq6wjuv8hBmXDlgV9uu2ex
oXtXNG2rKAGCYwgcsSlaw4yrza/78+noh+HkvEPna6gtkfTovd1oervQXss/XUtc
nEjI+k2syIEvNYK5vtICfmzYuAVuAfWOKKPq9gX0omQE/tiEb7/E4KZd9RBkeH0=
=kOxG
-----END PGP SIGNATURE-----

--E5HUUwS3R9LcK7+r--

--===============0509053987684889000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0509053987684889000==--
