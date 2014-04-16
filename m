From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable
	baudclk when used
Date: Wed, 16 Apr 2014 18:42:16 +0100
Message-ID: <20140416174216.GW12304@sirena.org.uk>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself>
 <20140416072738.GC6159@pengutronix.de>
 <20140416080826.GA13449@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3519271418627161080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 388C12654E0
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 19:42:38 +0200 (CEST)
In-Reply-To: <20140416080826.GA13449@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3519271418627161080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ddJi1IsAv4W/kcDl"
Content-Disposition: inline


--ddJi1IsAv4W/kcDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2014 at 04:08:29PM +0800, Nicolin Chen wrote:
> On Wed, Apr 16, 2014 at 09:27:38AM +0200, Markus Pargmann wrote:

> > Is there always exactly one hw_free call for one hw_params call? There
> > is a comment above the function:
> > "Frees resources allocated by hw_params, can be called multiple times",

> That's a good question. IIRC, snd_pcm_release_substream() would call its
> hw_free() right before calling snd_pcm_close(). So there would be at least
> twice for hw_free()'s execution.

There may be any number of hw_params() calls.

--ddJi1IsAv4W/kcDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTsD0AAoJELSic+t+oim9ij4P/2fTPRb+WaYMDSksemMFHmOE
f3FLF7dEGlRlo8DKRHZJ/OJKHXqcZD/jCKMlqRF6o0NbERggG/jQIrUXYRY1KgLM
Os6iMC97TLROZUoYSfQ3NIVwzIn5hRUq/QDZs7lTtHGcLmEhWOmLhVo6GhOirdXq
yFDmPjajrMCKsLaXfCmXJ0uxA5Qo1l9Sp+idvZuJZAXz/UfZgjs7IPnP7QuGgVK9
3tySmMoCNTcA2eomGjhPoFkGi3AmVZV97WFVD8NSHEI86JPYqkLNpRzkXKO14K+i
iGStbytDkYqAZJIQLHjV/ZHx6xXmQ2JcYh9xl1JeXNN7rHkGcOQX/vDoNbH2n4NY
dmG8N+orxL2J2fBZuvMdlFK5uueuvY9w1BPG8jDuoe6hkB4xQP0LqNJlDHzjA8qU
GE2gnm2sx+iRrV6nKnkVzQWDqfJy4ixFLX58U6IH+we5wjL30CGZDn0Osq8NRU5K
IkZ5FP3ocGqaesWPOk5/jIsx2rrisWfabOCrWsUDG2oZEjk1FU1bwwwdTckrCGq/
X64Egj1KM31FXemHXvOJyX8sWqSOgx19joR6imk15P6cHK3X80JJ1N6YuHWXZWFI
nHikyNP3EhNco334iKCHxDOa1qAePocl+Y++t7wRZd6szGFdM4zgIiRiKRE0S3ep
xTCcKicREfSjz+RDdOp3
=5rXM
-----END PGP SIGNATURE-----

--ddJi1IsAv4W/kcDl--

--===============3519271418627161080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3519271418627161080==--
