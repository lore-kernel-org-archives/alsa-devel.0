From: Mark Brown <broonie@kernel.org>
Subject: Re: pcm512x driver: Mixer control naming issue
Date: Tue, 17 Mar 2015 17:23:05 +0000
Message-ID: <20150317172304.GR28806@sirena.org.uk>
References: <5500DE5B.2020401@hmbedded.co.uk> <5502DAE1.30609@hmbedded.co.uk>
 <20150313182729.GE28806@sirena.org.uk>
 <55060771.7060200@hmbedded.co.uk>
 <20150316113845.GM28806@sirena.org.uk>
 <550714D8.5060407@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3727665043967402732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E09264F52
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 18:23:14 +0100 (CET)
In-Reply-To: <550714D8.5060407@hmbedded.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Howard Mitchell <hm@hmbedded.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Gordon Garrity <gordon.garrity@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3727665043967402732==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2ibbZKN8N91xLJga"
Content-Disposition: inline


--2ibbZKN8N91xLJga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2015 at 05:37:28PM +0000, Howard Mitchell wrote:
> On 16/03/15 11:38, Mark Brown wrote:

> >Really the problem here is using asound.state - it's far too dumb a
> >means of controlling random cards, and attempting to change it is most
> >likely going to break something else.  Any attempt to introduce a
> >default for analogue control will inevitably result in problems on cards
> >that currently work fine with digital/default control unless those are
> >changed which would then cause problems for things without the analogue
> >control.

> So it sounds like adding an analogue prefix should be fairly safe in
> which case are you happy for me to go ahead and prepare a patch?

I'm certainly happy with that.

--2ibbZKN8N91xLJga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCGL4AAoJECTWi3JdVIfQ7BYH/i/PoN2DmRohkldy488ioC/c
mL4cyoFUVyJBwZKbGDr0IA1mYBMtBHkgXOm5QvFwKSRQe42Fu6q4jO/KLg4TnVUU
CO8I0Yqa9XFfZ69hd6tYXI3iN+wvrhdRZVxZZs2F9e1+X0lElw8tC/OWrQeWuZ0P
Tk77ZnuXqJpuCO4wrvYd3pc+IrHDC2a3wbJijxU0gfBbwYWegT7blANbF5aF/mfd
TEUMPlu2HWXoveKMn9a/3SnuG9dEYJR3JZFkH+pwnqXsDuphAJKvZsBXeBxGfBJG
VfsKmyJVcsPmbS5FVykF7Z36z62VI7F0PpZNKDPch0LbzP3Uy7T1gKa4wPo5Lgs=
=2v/m
-----END PGP SIGNATURE-----

--2ibbZKN8N91xLJga--

--===============3727665043967402732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3727665043967402732==--
