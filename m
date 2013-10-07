From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Mon, 7 Oct 2013 18:27:06 +0100
Message-ID: <20131007172706.GS21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1805323502541506579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 45ACB265176
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 19:27:14 +0200 (CEST)
In-Reply-To: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1805323502541506579==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gXx2FYK2AghGE4Yq"
Content-Disposition: inline


--gXx2FYK2AghGE4Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2013 at 12:53:17PM +0200, Markus Pargmann wrote:

> In case of a start command, the calling function will call undo_start,
> calling this trigger function with the stop command. It will call stop
> for each function. But only the first function was started previously.
> The other functions may fail in the assumption that a stop command
> always comes after a start command.

> As the API does not specify the behaviour of trigger functionpointers, I
> think this should be fixed in the function calling the trigger
> functionpointers.

> This patch changes the behaviour. The trigger function calls all
> functionpointers independent of their returncodes. The first error-code
> is returned.

I'm not sure if this will resolve the problem robustly - if something is
going to get confused about this it seems just as likely that the
trigger that failed will get upset because it gets a _STOP after
returning an error from _START.  I think what I'd expect here is that
the unwind on error would unwind only the triggers that it successfully
ran.  Equally well I'd be a bit surprised if a trigger function actually
had a problem with extra _STOPs since they mostly just do register
writes...  did you see this from code inspection or were you resolving a
practical problem in your system?

--gXx2FYK2AghGE4Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUu7nAAoJELSic+t+oim94RsP/jeuGgi7up+TxrEv230u9V4k
u/OboLdDFGA2uqkQygBsDr7xSKyZid35ViLXV7Y/1cnwgJjNc3upfATFXveq5X+H
hfHS6Vh1ohrP4ykK2+AAo1/oIcgvWK3VKLeInucJ6VLGIXdDarLqfx1RkfOIJYdr
fk255BulXHyvs+LgWeg4Z3nbkk2HgTzpRoMzKFp/Rl26JzNubk5o/33pwl0k0KA6
Wmm/n20gz5DUx3tT5NDnwc6m6zJauwURQCxwciO0LIWWvhnkkEmpCkSFxvjshAAq
l/MojzMr3XnPxSzzUJgV5XkeXJZeVyI233LHP4LCMCTFLd2cjRoQlVGTvEhyirxh
DHr7FyA9Mn9YNEfgz8adnAFdMiYB6t7Qj4Pgu6agaEYm1NK6WS7/HQPDjFMq5ich
plDEMHtIjMm7iG5gZb6nYuY55twWetocER03m0KiO0TC0U9Tl7LY/7SQILTiOMAP
6MF34bpEP0GxQxt55dPq6exGal7ehtC+quvgkaBvg4i7dE4hcl6mhsfA0TOGY5pX
x0HoFxzT2Jx9FbOXCdUiTInqyzFzgtJ6X+Ck8Rg84ws/naYuzObmYLociqU+q03u
bwYzLlugCEu2iXlUxfsS5az0K52bcE4zqMKStA7wFLby8kymd0dmeBqIskM87eLa
3iMJprsXIEe9T8+AXC84
=1c+E
-----END PGP SIGNATURE-----

--gXx2FYK2AghGE4Yq--

--===============1805323502541506579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1805323502541506579==--
