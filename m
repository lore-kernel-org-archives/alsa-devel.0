From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: kirkwood: add S/PDIF support
Date: Sun, 20 Oct 2013 18:12:55 +0100
Message-ID: <20131020171255.GP2443@sirena.org.uk>
References: <20131018203750.7b981d62@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7460679021621201097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E6C2526179C
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 19:13:01 +0200 (CEST)
In-Reply-To: <20131018203750.7b981d62@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7460679021621201097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gzSx7wqTEktSSHja"
Content-Disposition: inline


--gzSx7wqTEktSSHja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 08:37:50PM +0200, Jean-Francois Moine wrote:
> This patch adds S/PDIF input/output for mvebu DT boards.

This looks basically good, thanks.  A couple of things though:

> +	if (dai->name[0] == 'i')
> +		ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
> +	else
> +		ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
> +

This works and isn't actively a problem but it's not really normal
either - the normal thing would be to use dai->id.

> +static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
> +    {
> +	.name = "i2s",
> +	.playback = {

This should cause problems for the existing (non-DT) machine drivers?
They're using cpu_dai_name to bind the CPU DAI and you're now setting an
explicit name instead of letting the dev_name() be used.  The patch
should be updating those machine drivers too unless I'm missing
something.

--gzSx7wqTEktSSHja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZA8UAAoJELSic+t+oim9il8P/AyXwsSPGBlR2smfhPNWjJ1A
203Qzh+S8rS79sZcqB280g9oimt8PSH+BrTvXoVt1Tix4gT/97iTmPEZPUNbKDcR
ABC/KZmMB1MimyxsV1v9OCOe8huHPptetgT5nqGnmZMi0RhTtywfTG8+j/GejnLL
afZ6Gea+PBGTxUi+AvybFBXFH+I/gGmgq1iYba6cydAjMscUjyn/04yLC0/kd7TH
V52leJnzuLQw7W6/WJDo15hh9d0gFfnPyQqclE9NA83L1HDphfI8J7qtozk7+Axl
5mMye+wejbHr5o1GLCEMrxq0uSDv0IIjdDB/0BgrVEgaschO1J+rDI5G85iNJgGG
C9p19fy69WNxQHI73xhe2EYxNZgnX54K74W7Tn2BmH1KwLTFuhdyrx3TvcOSST+D
EulN2lQ+2xzToIXo2KG7XAldtGp38tEvFNXdxI5l203s8CXudhxpx5yFPJrHGnZu
6ZyN99aZVTOo4kppjV3v/5jM3uuZY1uC40dXPGeDUzJKnt1UeRw/EySlMpZy+R4J
K0CKV2Jq/NyJYWSI8/23j65Z2FH5pcsEHj1TsanFwYc5qLN0JoHrMCYeUg2DVx5e
VDMrdQfvIAPFrvhy5By4LWoNMWYQbYGalmPVldR87WuJogpxCCZCkby+IHPceuf4
qalklKFo8yctlQnfHJYA
=iwrK
-----END PGP SIGNATURE-----

--gzSx7wqTEktSSHja--

--===============7460679021621201097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7460679021621201097==--
