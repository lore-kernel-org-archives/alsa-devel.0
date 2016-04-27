From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: allow changing the
 playback/capture rates for symmetric links
Date: Wed, 27 Apr 2016 17:15:04 +0100
Message-ID: <20160427161504.GZ3217@sirena.org.uk>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0462689004275584028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E6FD261703
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 18:15:12 +0200 (CEST)
In-Reply-To: <1461746959-11443-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0462689004275584028==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iwOtj70Sz1+p37c3"
Content-Disposition: inline


--iwOtj70Sz1+p37c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2016 at 10:49:19AM +0200, Peter Rosin wrote:

> The below program fails on a dai link with symmetric rates without this
> patch. The patch makes it work.

You've not articulated the problem you're trying to fix here, what in
concrete terms is the program trying to accomplish and why should it
succeed?

>     if ((fd = open("/dev/dsp", O_WRONLY, 0)) == -1) {
>             perror("open");
>             return 1;
>     }

This is using the OSS interfaces which really haven't ever been
especially supported for ASoC.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		if (!cpu_dai->capture_active)
> +			return 0;
> +	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		if (!cpu_dai->playback_active)
> +			return 0;
> +	}
> +
>  	rate = params_rate(params);
>  	channels = params_channels(params);
>  	sample_bits = snd_pcm_format_physical_width(params_format(params));

This means we've opened up a race where the stream is configured but not
started where the opposite direction can configure a different setup.
Since starting both directions very close together is a common operation
it seems likely to cause issues.

--iwOtj70Sz1+p37c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIOWHAAoJECTWi3JdVIfQU2kH/R921cVN0sx1JZWj0x1Y0++d
7dvtSh2Tg0mQ4UharOjjvjarALgIoaxT9S48W5ECNaAY/XV8qSDnkS4bmJyEl8eR
f0ekxEfx3KVgAGlV7Um4jNDZKJa31bjfsXUueEJ4ezeyKHK5IRY0kYv093fVMp+w
meDdX4gZ01zmogUD+QbpKskTmTro00ctcOSo8mtgAhXzYZPX7CPyKSXRU9GeAkSB
k+DCCqU+3yPTK3LRKYe08OO4rQocYyQXMzjjXvB4cCQOrj3Z54mlZMW2j/9JsPSc
8Jd+dRnRM78npg/DEp2jNS0OIp6R4U85BbZL7lC253Wy7SVciXCHcPb+U5ovtsY=
=dM+p
-----END PGP SIGNATURE-----

--iwOtj70Sz1+p37c3--

--===============0462689004275584028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0462689004275584028==--
