From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Thu, 13 Dec 2018 17:37:35 +0000
Message-ID: <20181213173735.GT10669@sirena.org.uk>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
 <20181126140200.GC9715@sirena.org.uk>
 <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6081111141511887274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FCEF26789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 18:37:39 +0100 (CET)
In-Reply-To: <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============6081111141511887274==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pnDjx0H/VpusRTEI"
Content-Disposition: inline


--pnDjx0H/VpusRTEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 09:23:28PM +0200, Dimitris Papavasiliou wrote:
> On Mon, Nov 26, 2018 at 4:02 PM Mark Brown <broonie@kernel.org> wrote:

> > Just remove the control, no need to jump through these hoops.

>  Sorry, I probably misunderstand.  Do you propose removing
> the "Digital Playback Switch" control entirely?  It would

Yes.

> certainly simplify things, as far as implementing the
> .digital_mute callback is concerned, but it would remove the only
> way of manually muting the DAC.  The "Digital Playback Volume"
> control is the main (and basically sole, apart from a switchable
> -6dB analog gain control) volume control of the DAC and removing
> the Switch component would make it unmutable.

That's not the end of the world, there's plenty of hardware that just
doesn't physically have a way to mute in hardware at all and a software
mute isn't particularly complex.

--pnDjx0H/VpusRTEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSmN4ACgkQJNaLcl1U
h9D83Af9FvOz0DpX+1Y2NJIwDmE6X3Bq39GCL0V+NxKNmaMzd5lheMm9og3C3+Kg
1NUUEyHQG/oabzC4Loo7rvi5mUYA0ObQRQhNkJSILVHIsk7aCT/JiQzCAp1kRrG4
FXhhH5gEl9kqhQQMAnzMXRuH23cPnrOM9yHvYnk6ngZ74waWoh7uG/T6w6lwhllj
V9UFSdGwDyvJh08iNcHuwwn47dUCdLDg1qh0Ek41GcDENahEGbxGhyCTUJZBnldN
A887NbGgKQoti4OEkuARyNBBHQ9iaELS6fBRm0bsTMIq8fMwuakefUhzfc11JW+p
jIRUC75SgKvgjTCzkR1LVp4CwPQUCA==
=A5Y3
-----END PGP SIGNATURE-----

--pnDjx0H/VpusRTEI--

--===============6081111141511887274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6081111141511887274==--
