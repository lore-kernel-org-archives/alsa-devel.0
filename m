From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: Intel: Headset button support in
 broxton machine driver
Date: Thu, 12 Apr 2018 16:24:24 +0100
Message-ID: <20180412152424.GF9929@sirena.org.uk>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
 <1522817219-3750-3-git-send-email-naveen.m@intel.com>
 <20180406003033.GA234162@decatoncale.mtv.corp.google.com>
 <20180406011548.GA4189@intel.com>
 <1522999715.7862.170.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3141346733310262307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 650D7266C1C
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 17:24:41 +0200 (CEST)
In-Reply-To: <1522999715.7862.170.camel@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, harshapriya.n@intel.com, Naveen M <naveen.m@intel.com>, Benson Leung <bleung@google.com>, bleung@chromium.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3141346733310262307==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 06, 2018 at 08:28:35AM +0100, David Woodhouse wrote:
> On Fri, 2018-04-06 at 06:45 +0530, Naveen M wrote:

> > Thanks for the review and update. Shall correct this in V2.
> > Also there are other machines which still use KEY_MEDIA -
> > kbl_da7219_max98357a.c, cht_bsw_nau8824.c
> > Shall correct these too.

> kbl_da7219_max98357a and rk3399_gru_sound also seem to have
> KEY_VOICECOMMAND on BTN_3 and volume up/down on 1/2; is that correct?

> Until I spotted that, I was going to suggest a generic helper to set
> all four, since they should *all* be setting the four events to
> KEY_PLAYPAUSE, KEY_VOICECOMMAND, KEY_VOLUMEUP, KEY_VOLUMEDOWN
> respectively.

Headsets are very system specific, it's going to depend on both how the
manufacturer headset is labelled and how the hardware interprets the
buttons on it.  There's a diversity of standards for both unfortunately
and no way to identify what's plugged in usefully.

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrPeicACgkQJNaLcl1U
h9AVfwf8C3j6jjjWk3LEOcxJd7yTzecdtDt+IYEH+47l/NFcdEocOsohNC+yF6PC
uOqwWBEM68jZsA5brd4Qy0ZCOoZQYOWc1gsk6kIcN4xB3AHEn2GaZ0kA9DuBSHSl
xxEGQth/SDWGizJNQwWe281ZmJvqGk/IILxOKI4rwBFUM8lIQYz5QrlcWnChuFGH
9OwgwpDqc5AV9yHWoz4PAUe+80Q0krDOtZbGOuU4B5bw3nTKrhcZxtiJfLHNPILc
fMxQzy//zEZoyfgKsiLuJ9ZIzZh0E/xwps76xVLquPmJoJmpQ7hMO36uj9T5W93P
v+hQT/+fYZkjjbThmUZ6NM8+WsQkjA==
=rl6n
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--

--===============3141346733310262307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3141346733310262307==--
