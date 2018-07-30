From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
	function
Date: Mon, 30 Jul 2018 11:54:34 +0100
Message-ID: <20180730105434.GI5789@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1421058992548613074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC8F2673A0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 12:54:43 +0200 (CEST)
In-Reply-To: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============1421058992548613074==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 06:13:42PM +0800, Akshu Agrawal wrote:
> There are cases where a pointer function populates
> runtime->delay, such as:
> ./sound/pci/hda/hda_controller.c
> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
>=20
> Also, in some cases cpu dai used is generic and the pcm
> driver needs to set delay.
>=20
> This delay was getting lost and was overwritten by delays
> from codec or cpu dai delay function if exposed.

I'm not 100% clear how this patch is supposed to work.

> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd=
_pcm_substream *substream)
>  	snd_pcm_sframes_t codec_delay =3D 0;
>  	int i;
> =20
> +	/* clearing the previous delay */
> +	runtime->delay =3D 0;
> +
>  	for_each_rtdcom(rtd, rtdcom) {
>  		component =3D rtdcom->component;
> =20

Here we reset runtime->delay to 0.

> @@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd=
_pcm_substream *substream)
>  	}
>  	delay +=3D codec_delay;
> =20
> -	runtime->delay =3D delay;
> +	runtime->delay +=3D delay;
> =20
>  	return offset;
>  }

but here we change the only assignment to delay from a straight
assignment to an accumilation.  I'm a bit confused as to the intended
difference - when will this be doing something other than setting
runtime->delay to the value we originally accumilated in delay which was
what we were doing anyway?

The two examples you mention just do a straight assignment to delay so
they're not going to be compatible with accumilating in delay, it feels
like we'd do better to add an explicit delay operation for them too to
match what we're doing with CODECs but perhaps I'm missing something
here.

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte7moACgkQJNaLcl1U
h9D7Ogf9EEnFRQaJzcEvMxcXWGfpH67sMPsepAF3DfO24Y88skr2RlBooq4Pxs6r
SNr6Rxgm8OJgX4LkAbmGrvuPKZZGeEDxi+pSJJewueB6/Sh+oilp3GFVaXxJBSea
8hnFVMDLf3JKLPL93kRLyibAI52h+3d3BUTH71MIERP9JqeeHcHYhbN65+vcz//k
I4lMN/v2etok6lQtdmEPSeD6phJBJFkZPe8Nycqm2T8xKJLq1e6kptTjVuaCvmVN
IdmbAMCOqULeGAKCw5IMYcr4U3I7mh0UufoJbMef1Bg1a5CEwBw5z670uoC6g0up
9H33GILgjFhfo3M86aYahTkaGrvU4A==
=0aig
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--

--===============1421058992548613074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1421058992548613074==--
