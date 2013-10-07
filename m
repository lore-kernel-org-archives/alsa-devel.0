From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Ignore VMID widgets for target
	bias
Date: Mon, 7 Oct 2013 11:33:55 +0100
Message-ID: <20131007103355.GE21581@sirena.org.uk>
References: <1380993977-1037-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7388339275294944517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DFF0265026
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 12:34:02 +0200 (CEST)
In-Reply-To: <1380993977-1037-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7388339275294944517==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2013 at 07:26:17PM +0200, Lars-Peter Clausen wrote:
> VMID widgets behave very similar to signal generator widgets. Both are always
> considered to be powered up. This means that we need to ignore the VMID widgets
> in the same way as signal generator widgets when calculating the DAPM context's
> target bias level. Otherwise the presence of a VMID widget, regardless whether
> it is on an active path or not, will cause the DAPM context to be powered up.

Applied, thanks.

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUo4QAAoJELSic+t+oim9Q9kP/3hEiT+Dl2lcAdUVwVQHUv/c
FGrXdcqMszcnppVRV/9ayP7KQPKN4NddfyaTg23NpQ2WVRrH2GiKTPw5XhL7Uivj
IhdmIkvX9C7pPzdKeLE4aqeEhe5rDlMrHoeQjfbyQUCMPTPh5C9ihHl3SPHArswJ
/GlXxuknfxDDAhdZDZ62RrVHfm8898dKbbiUlgOK4GSjqDK/RX8FTRQMhNrg9JQS
CiX3xg7+CxK8dgw63cqPFK41fC8eJsv69UVH729eQXRIi3o6kbtPvd1gznUghg8G
YFKNHJw9q0PUZsEFCmtCeNBV3UlN23fZtD0NDqz/6NsAc6vK2wSDKK1X1FUCWdzM
zbm+q+FqXNpWOgyv2eP4JJYPc2fr/SG9FPHNJgEhnbAz4Ccu7ZQcnqUSsBEQLq5+
xPZ/ChAmA/EjPTeIDn9N49AUum86/fCoqwQ96q9rURzVlZNhUwzt+VmSANbkMN75
1ywmJITm9c9ysXhKxYbY98lNZK0Hlp3YIXcZbc5uh/xTnGrbaSpOHJ1EGAFDdQb5
sL18gqYkIu0batn04ZgrWsx90cEXmk+BS3iobWU/bOSgIbatF8YxXpjftUBmPlxo
lSwmYGIH3kHkBk5SbK1z5+YzcquIUYR6GY8cqWLaXS/DJFNomLlYZyFo1pnxNdHw
OGeed02ssVjRvbIB5UPg
=AAPH
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--

--===============7388339275294944517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7388339275294944517==--
