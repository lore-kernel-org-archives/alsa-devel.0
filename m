From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: davinci-mcasp: Add
 overrun/underrun event handling
Date: Mon, 10 Nov 2014 18:58:14 +0000
Message-ID: <20141110185814.GE3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-7-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1828231066060649612=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B53B265A36
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 19:59:31 +0100 (CET)
In-Reply-To: <1415615540-28981-7-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1828231066060649612==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mkPqt2yxDAeJ9tTX"
Content-Disposition: inline


--mkPqt2yxDAeJ9tTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:32:20PM +0200, Peter Ujfalusi wrote:

> +	stat = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG);
> +	if (stat & XUNDRN) {
> +		dev_warn(mcasp->dev, "Transmit buffer underflow\n");
> +		substream = mcasp->substreams[SNDRV_PCM_STREAM_PLAYBACK];
> +		if (substream) {
> +			snd_pcm_stream_lock_irq(substream);
> +			if (snd_pcm_running(substream))
> +				snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +			snd_pcm_stream_unlock_irq(substream);
> +		}
> +	}
> +
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, stat);
> +
> +	return IRQ_HANDLED;

This will unconditionally report that any interrupt that gets delivered
is handled and acknowledged regardles of what was reported.  This isn't
ideal, I'd at least expect a warning to be printed if we're handling
interrupts we don't understand.

--mkPqt2yxDAeJ9tTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYQrFAAoJECTWi3JdVIfQESoH/1M9Ff12xOllG+9X4eqygJh/
uUycjzy9XvbPWeXBMvUbnuFHjBCMxgeMVXRU0QM7gdIvFLqWpEf+qlbgygVK4mnl
2dBGU8LN/iyEZrR6d1I8bvxDZOeioSiPMWzhMno610GqhSm4HrWvUS8DdXDpK2n1
xjNLGdiJNudZ0rVsX4zxoYo+LSUp4Im4M4Wi6c6r2nb7u3QAS44mqK7Lh9yojhbI
08jD9LqO+vkZBgYqKhisqMvA3QTNFhHrhXHvFCKznbiVZbrHKvqSOHLslfn5vIHs
eY3JAtz9jnrkNMA2/9i3Izk4AmQCV5FwbqSQpVbeT98tNrxtWpm3ZO1ZNEcgek4=
=46NV
-----END PGP SIGNATURE-----

--mkPqt2yxDAeJ9tTX--

--===============1828231066060649612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1828231066060649612==--
