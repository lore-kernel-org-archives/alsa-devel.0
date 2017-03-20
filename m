From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 20 Mar 2017 15:08:45 +0000
Message-ID: <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0745203338660487662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E116266E37
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 16:08:57 +0100 (CET)
In-Reply-To: <20170320035831.10762-1-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0745203338660487662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nnupsqqa4zggsve5"
Content-Disposition: inline


--nnupsqqa4zggsve5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 11:58:31AM +0800, Kai-Heng Feng wrote:

> v3:
> Implicit conversion instead of tenary operator.
>=20
> v2:
> Use 'HP Power' instead of individual power events.

As covered in SubmittingPatches this should come after the ---, it
doesn't need to end up in the changelogs.

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMD:
> +	case SND_SOC_DAPM_POST_PMD:
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMU:

To repeat what I said last time:

| After power up we mute the amplifier?  That's worthy of a comment...

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--nnupsqqa4zggsve5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljP8HwACgkQJNaLcl1U
h9C4AQf/UFcAUUsnOyedRKXND3zRPPbLw2iOfZSpdWd9nOkuynEkOCQ8KiwxSmkr
BBjEak8bwZsL2Zix+YrNTIbWiJ8TEDMhzrYXhCQsTTuO9vIlYN6kdeTxTN/hcgfF
EytgPJSMrGKYVItwA0l199U0uy67ikvdVvFp7Gzeq2fC81om0CDHNM7DzayY3hyu
7j6EqZG7/bH9x5fB4wcPzfy870T7bo80MuIawlthE23wgsmYWxObCNzVmZ4zO/IX
aedqARUpihC2AB/j21Dh6EyCPTF9+OoskNahIiBYKC7zevW7UH7t+tFkIkvJC3IP
cJ4EdG+oJsw8gzCsahlo2ijVFGJnPw==
=SE0u
-----END PGP SIGNATURE-----

--nnupsqqa4zggsve5--

--===============0745203338660487662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0745203338660487662==--
