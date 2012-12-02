From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: atmel-pcm: dma support based on pcm dmaengine
Date: Sun, 2 Dec 2012 13:30:38 +0900
Message-ID: <20121202043036.GW17981@opensource.wolfsonmicro.com>
References: <1354074373-7671-1-git-send-email-voice.shen@atmel.com>
 <1354074373-7671-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ou5B7nmexOOGXbzo"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354074373-7671-2-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Ou5B7nmexOOGXbzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2012 at 11:46:13AM +0800, Bo Shen wrote:
> Specify overrun bit in interrupt mask
> Add dmaengine specific routines

Applied, thanks.

> +	struct snd_pcm_substream *substream)
> +{
> +	struct atmel_pcm_dma_params *prtd;
> +
> +	prtd = snd_dmaengine_pcm_get_data(substream);
> +
> +	if (ssc_sr & prtd->mask->ssc_error) {
> +		if (snd_pcm_running(substream))

It is a bit weird that this is not part of the SSC code...

--Ou5B7nmexOOGXbzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutlmAAoJELSic+t+oim9eCMP/jj4ZM1E0vATa1eTyCMNzUmI
5MIwP28Pew9rYjqPO6kv2IliP2Bc2LMtqhVHBznOlDbOD9THjtIFFqa4ERXm7xqk
UTJR2mBwxZ07pqIv1gRTvU5WeazudrMQb2kHFm4ywf21oqIj2qqUNJene+sF4CTE
66K2E1hQkJIdOeS9s8kFjdrmjCPqKaTVdvabXyRUL6MiHImrDC6BGTUm5sRSUo3s
e0moX/PcOhq5cOhXjSzkAdqc03NePRiBnX9DavH/arQ6EzstImkFRMcObSw/432r
0ojLlNUXO3+AGnNtEu2MMFhuthJnsYvzRxZ2mE4bNCtDdiWSxABDr6pC6CMnqelp
fePzm8kECNKwQin/QHzUMhZ+1e59IB8swCmGM1lCICE5O4rC0gWfvZBDq44Ar5gM
YkEuFcLgRVpPFpjxD9qvtS6hgaZFTVpk+6/O7JyRfK49rbe94pPcme8U1jLXlinj
EsV4ArsHVJCj/6PzolgJOyjlXvJZhebc1uZeqQPKKPaZSYBE1vRBMss6AR2YNPBQ
lmKncBvpnRym4i0mQ2CWvXKtb2S4mTLI5QSdJeY81VwKa+RVT5h+ClhPF4EEi8BU
QuuU2Eag9HUZ1L9lplKBuwsQyF4JqplEs+ZOYhPc/uzS2lAoOA4aJ3IxUP0xbRet
nkWea417F5uNDsyou/X1
=3O/D
-----END PGP SIGNATURE-----

--Ou5B7nmexOOGXbzo--
