From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] ASoC: max98927: Added support for
 DSP_A and DSP_B format
Date: Tue, 29 Aug 2017 20:00:15 +0100
Message-ID: <20170829190015.kpscn3uuwbvwlp6e@sirena.org.uk>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4197254592494657695=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 31679266E37
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:24:14 +0200 (CEST)
In-Reply-To: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============4197254592494657695==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="euhoxbrlqmbpsmvn"
Content-Disposition: inline


--euhoxbrlqmbpsmvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2017 at 04:30:53PM -0700, Ryan Lee wrote:

> +	if ((max98927->iface == SND_SOC_DAIFMT_DSP_A) ||
> +	    (max98927->iface == SND_SOC_DAIFMT_DSP_B))
> +		return 0;
> +
> +	/* BCLK configuration */

Why do we not configure the BCLK in DSP modes?  That's unusual and seems
likely to break some systems that rely on exact clocking.

Also if we're selecting on format a switch statement is generally better
to make any further special casing easier in future.

--euhoxbrlqmbpsmvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmlub8ACgkQJNaLcl1U
h9ATgwgAg7A9FD5vNeKfNbMaPuGscSKHWiIlwzXlpaDCS09BPMKQaIU03LIQ6/47
Qgg2Mf5WPY+c4TPwebR9a1+6m5wUPKf1p6fsY7lCCqCyBhIuvTjI2nPHtotY6Frh
waKFm4taKvAfQ+AkP1gUMX4sY9OrzRulUm+sxJdfwF09bmowV57/+EDtTvRvbCGI
FarNEN7qfhIClAS/UVv+SbJ51Q8sX8JYj5HuigXMQO2PExt32zzaI3Owy+d/cO/e
JR2q3cCjPx6SzNqgMXIxitJUPwSyhJ4l31A3kXjfdJ8hMTzGBEmk2SzvMJFf0W1i
oC3+70UEJEBbvoJ804xxQFdPrrrJ+A==
=CIKk
-----END PGP SIGNATURE-----

--euhoxbrlqmbpsmvn--

--===============4197254592494657695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4197254592494657695==--
