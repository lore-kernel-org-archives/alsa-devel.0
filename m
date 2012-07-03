From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: dapm: Remove incomplete stereo
	code
Date: Tue, 3 Jul 2012 19:54:53 +0100
Message-ID: <20120703185452.GY29030@opensource.wolfsonmicro.com>
References: <681621148.529589.1341242387391.JavaMail.root@advansee.com>
	<927358047.646516.1341339497010.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6681673591186984866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69564104147
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 20:54:54 +0200 (CEST)
In-Reply-To: <927358047.646516.1341339497010.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6681673591186984866==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b2s+RKoBicgQlNJs"
Content-Disposition: inline


--b2s+RKoBicgQlNJs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 08:18:17PM +0200, Beno=EEt Th=E9baudeau wrote:
> Stereo is not yet supported by dapm widgets, so remove stereo code from
> snd_soc_dapm_get_volsw(), and warn if stereo controls are detected.

Applied, thanks.

--b2s+RKoBicgQlNJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8z/0AAoJEBus8iNuMP3dRK8P/RHvLqpC3jtCk0kg6ptIVv4A
w+OehmP4budVfxVHh28ybRkUdCxLbCp6gfz+tMPJH8jkFQ5rgBpHNHWKudxDQc6f
BUWa3PtxEyPRJxSlC1oIDknTOQQdruhSZS0+WpkMfAkanIIIeLWKlNozP+p3DW7Z
+wCChrFeZf6bG6wfGzCK+zd6F0+syUFI+3lTm8JnDvGYovzUyKFTa0mvJsFgTVc9
TByKKBEaWvAN8c7a7KkW0KXI5KpwIuA9UNA4GX5XIaa2ta4yWhP/sl1Jty3ecMBd
BF5Da69izxGDa3cwUjbJQ0Dqu8fXji1ccrV90dYtVxqGHlapLcxcmQqP3eeajulc
gOQkFhrIitWOew8g1JGOPVXENqkePfwBIz7aR1IfchmiSCAW16/93WJjeq0iuZQD
kuGBsF7IHGAijbwDqOztjcRTOeSQw0GZLFcebuRsLyrG/3YGRX39rSe6E0RKMaxz
UG2ZF6PpM1msPB8AP6yF0ysBcqnSBugvwXOFbXfyQgaXDtpCtM53zZLDT2ojKF5C
4mLJxc7zSWjCqX6pDVzfiG9E3xe+jZHx1hOh+65SmGZX5h4JgoqOl6xEOOf+85m4
JNSB9xiVzFVP8Chv65lYHRNOinfGlp/fITBAOOZOZzVg/wEGfUM1PXDPvqEp2wDW
XuHf1Lty0N2bjFIUF0Kz
=TX0H
-----END PGP SIGNATURE-----

--b2s+RKoBicgQlNJs--

--===============6681673591186984866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6681673591186984866==--
