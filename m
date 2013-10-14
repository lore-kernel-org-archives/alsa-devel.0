From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] sound: soc: fsl: Fix memory leak in
	imx-audmux.c
Date: Mon, 14 Oct 2013 12:59:37 +0100
Message-ID: <20131014115937.GR2443@sirena.org.uk>
References: <1381617306-18764-1-git-send-email-felipensp@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5437867355954069016=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D3DC32608ED
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 14:00:09 +0200 (CEST)
In-Reply-To: <1381617306-18764-1-git-send-email-felipensp@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Pena <felipensp@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Bill Pemberton <wfp5p@virginia.edu>, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5437867355954069016==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RyOXVFQXzAE23HDB"
Content-Disposition: inline


--RyOXVFQXzAE23HDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 12, 2013 at 07:35:06PM -0300, Felipe Pena wrote:
> When audmux_clk is used and clk_prepare_enable function succeed,
> the memory alloc'd to buf variable is leaked

Applied, thanks.  Please try to use subject lines appropriate for the
subsystem and keep your CC lists focused - you want to send to
maintainers and people working on the specific code but it's best to
avoid people working on tree wide cleanups like Bill so they don't get
too much spam.

--RyOXVFQXzAE23HDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSW9ymAAoJELSic+t+oim99S4P/izU/ZcUlt5MsAmtixWPMcT6
5Z8MqOFszP95RXGwxaMcqmfjMH0UyGwkUNuE5di2PQEQ5KST4QZQSsb/e2BbbI7m
ve3QFUmpMgekJo1SuTuu/EjvLlJLYQCX+MG8Xt2GMpv2qIsXJakgM3OHSokmQFaw
KhWKNSY2pAejFj4QXZaw7IXGt6lL8kFeYB4B1iWJJEUTG6fUlb6qmC08OZMZHUkp
JL+aRfs+wk8blwpMal+wZ1Ae0gWnOhwOd2rNI+JVWtNer9s/fWMy2z+a3njgcxed
ES/caP7B15WkQv3jktga0ncNpyRgUrQDLNrqhH/P2qBmhqezQw7g2lFu6ainhtIH
90YgmsMeWiinoDxs4aX8yfVSk+QGjT4zkJs13nxsSQl9TG1arE562W5kj30MwEIZ
f7DRlBfPH8YYudOHNZvTEjMg0vgoNgjC/IauYj3RziNorjcR0AXRwrfPejp+mGFx
mLrOuj9HdhmgvDGAf+acfINGijDKliWF3VsAUxvojfyGtL6lV2fuYfWgS3n25Zc7
QC/J8TDw6GaQleWigr3FBNnbaLK6hG/Q/ngCf7ZLnTXsSOTBlXiKXSzMC6FXyl+h
HotY8AVkYYX6kTK0OtX/zebbJB0AEd+1aVMsHafeQsjwe51gyEja18xK3VR1WAVK
zJGYBcotOi/4kF377sRS
=MuZE
-----END PGP SIGNATURE-----

--RyOXVFQXzAE23HDB--

--===============5437867355954069016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5437867355954069016==--
