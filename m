From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sti: correction for HBRA support
Date: Mon, 30 Nov 2015 16:30:57 +0000
Message-ID: <20151130163057.GA1929@sirena.org.uk>
References: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
 <1448370996-30224-3-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8640540578851073176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0533B26156A
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 17:31:04 +0100 (CET)
In-Reply-To: <1448370996-30224-3-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8640540578851073176==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMBvpMIlSQ3hWZ0K"
Content-Disposition: inline


--rMBvpMIlSQ3hWZ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2015 at 02:16:36PM +0100, Moise Gergaud wrote:
> Detect HBRA based on rate and channels used in the pcm session
> In case of HBRA:
>   - CH_STS repeat is disabled
>   - channel status sampling freq is not set if already set (because it can
>     be a multiple of the runtime rate)

You might want to expand HBRA...

>  		switch (runtime->rate) {
>  		case 22050:
> -			player->stream_settings.iec958.status[3] =
> -						IEC958_AES3_CON_FS_22050;
> +			*aes3 |= IEC958_AES3_CON_FS_22050;
>  			break;

This feels like someting we could have as a generic function for other
drivers to use - can you add a core function and then call it from your
driver please?

--rMBvpMIlSQ3hWZ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHnAAAoJECTWi3JdVIfQZYEH/3wBt3ad9+/mtoYBle6f1Qkv
um9jfjPYiyokVAMIClnq+nHHvh3HNL/tiCq3Ym+jHiM+XwispaVdombaFQ1Ho1mK
03B2jpDnJD0NmRLRJwx6WMT4Y+JJQu27Eb2H6Ml8mN2DdosFiG/Rj3kBcBfOZ3n5
gBImoMU4ZOnbKYYkn3iEiNYSPbZD14JXvKpwFD4/5sZZoXC5OlDaGrf02S3+f+cr
8c3ePdtd+aXscsCO2BGMmYxu4LZCDpSgj01sCe6YgZsPuRE3bxEJCY9mr0RQ2G1+
UmiH7I8XU/jLPbkEmYFEHyFDH38Pp0NwXzDvN3KV/7XUUakNP6Y1UghXi0v3r34=
=BaJg
-----END PGP SIGNATURE-----

--rMBvpMIlSQ3hWZ0K--

--===============8640540578851073176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8640540578851073176==--
