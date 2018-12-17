From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Mon, 17 Dec 2018 12:36:04 +0000
Message-ID: <20181217123604.GE13868@sirena.org.uk>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
 <20181126140200.GC9715@sirena.org.uk>
 <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
 <20181213173735.GT10669@sirena.org.uk>
 <6d49609e-e7e9-3786-a321-ac974c20ca6e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8732211664134536860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8019826789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:36:06 +0100 (CET)
In-Reply-To: <6d49609e-e7e9-3786-a321-ac974c20ca6e@gmail.com>
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


--===============8732211664134536860==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 01:53:16PM +0200, Dimitris Papavasiliou wrote:

> wouldn't even experience any benefit from the patch.)  I'm not
> sure how or where the software muting would be implemented, but
> removing the switch would seem like a substantial inconvenience

There's an ALSA plugin for this.

> That said, the patch seems to have been accepted, so now I'm
> confused.  Do I have to make any changes to the patch, or is it
> accepted as is?

I applied it.

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXmDMACgkQJNaLcl1U
h9D0tQf/dTEWdnbBOvJsMfzeoeRoYIqep7FuIKe/W1PqKujiLOzF1rT+XWgVVejS
wqIY6rUdBPANDbinlWORVBE9mfizZlfh0IP0XdMA+jdqbm/C4HKtIGYMc00RXdol
fybBCqw4fdugnoQ+Pq/C5H2RNPD8qjPflhpMToV8uAHgeFq3NP7G8ib5E1efnvfo
HYNjZteY7Fr4RQnyHy1bY97Z4RBdGdcKtuEWLNuspvp9mQYfq6A+Kk1+fdZG/V7T
bveNP0ilPslcOQ8mjmCKt2qgzgIndoXsIOGvL0YGUH1oAEX9roMzO2THHLYH9oDH
uHRKX0+KP57W4SpnAwA+GjtXGv+tgw==
=Sy2Q
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

--===============8732211664134536860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8732211664134536860==--
