From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI assignments"
Date: Tue, 18 Jul 2017 13:59:11 +0100
Message-ID: <20170718125911.aw7syyjgbxbwv2za@sirena.org.uk>
References: <20170712155530.17765-1-johan@kernel.org>
 <20170712155530.17765-2-johan@kernel.org>
 <20170717145127.ke5o65as35itamaf@sirena.org.uk>
 <20170718082118.GG29638@localhost>
 <20170718100655.topzzdu6n7rd6euk@sirena.org.uk>
 <20170718103629.GI29638@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="npsiaupc6e7coghb"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718103629.GI29638@localhost>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--npsiaupc6e7coghb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2017 at 12:36:29PM +0200, Johan Hovold wrote:
> On Tue, Jul 18, 2017 at 11:06:55AM +0100, Mark Brown wrote:

> > Reverts shouldn't be special - they're just regular patches and should
> > have sensible changelogs like any others.

> Stating that you're reverting a commit and which commit that is is in
> the summary is arguable sensible (of course, you still also need further
> details in the commit message body itself describing why it was needed).

> Check the logs and you'll see that we have a ton of "Revert <reverted
> commit summary>" for various subsystems. In fact, it seems to be by far
> the most common summary for direct reverts.

The easily findable ones are, and it doesn't mean it's good practice -
reverts seem to attract particularly bad commit messages in general, not
just the subject lines, and I happen to have a pre-canned response for
this so...

--npsiaupc6e7coghb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlluBh4ACgkQJNaLcl1U
h9CS1AgAhfNE1+ey5LQ3jf0tXSlLNEAC1Jyd9WOVV0mQ/JvnmxTDMRGWDcY3vHrU
mZZwzqQ4Yru0a8X4q48/qpxXOypLIBryyHXq0mIYijE7PBG3CnLQzKg2T6egVcUD
PedKpKqXWFkmiKuCN5YDVBoT/CKOWPmSlDkLbr6l5ajgIZQbYnL6LxIakVFV6+hU
pqYaL0VMtkB4BPB4OlF+GGnrcvzb/aHv9L+WTMe4PyKyhN/XvPgQDCdfOr1+5g47
6cYhs91FbZ57Mx5Q0sHlLu9Yy+I5P0rtEw8CdeNCwZMuXQpnu6Pugtraa0kqkcz7
8JNLhxFkQBzaZRHpWOGZeckiTAIdQA==
=s3ie
-----END PGP SIGNATURE-----

--npsiaupc6e7coghb--
