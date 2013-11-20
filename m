From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][topic/symmetry] ASoC: soc-pcm: move DAIs
 parameters cleaning into hw_free()
Date: Wed, 20 Nov 2013 17:02:29 +0000
Message-ID: <20131120170229.GK2674@sirena.org.uk>
References: <1384943829-9005-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1236786431358416250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A2D362616B4
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:02:34 +0100 (CET)
In-Reply-To: <1384943829-9005-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1236786431358416250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZuCi2HMIMuKavysU"
Content-Disposition: inline


--ZuCi2HMIMuKavysU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 06:37:09PM +0800, Nicolin Chen wrote:
> We're now applying soc_hw_params_symmetry() to reject unmatched parameters
> while we clear parameters in soc_pcm_close(). So here's a use case might be
> broken by this mechanism: aplay -Dhw:0 44100.wav 48000.wav 32000.wav

Applied, thanks.

--ZuCi2HMIMuKavysU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjOsiAAoJELSic+t+oim9sZkP/jUZ0QU285bQq+c8kPuJ8Rjt
4RW0aV3DATZBa1kw6uM6LckfZ4l9yh6polJ6qPYkR4g/EQ42JXvnwKyJnscY1M+d
enDPwpi+eQ4EfghdjN7piZ9lVCb6Lq6asJl3SjSAHt0St7xw+oM0ZyuCUCcQQ+5J
3rNkgHMA4PT3AhydpqgTh97hZwDn4ZBAiAMTYpqH1Z2bsNGjN+7MabDriIPDQP5q
jUfFNFlpqzfXEHVN6PqFcpHh8JJjWcSPFMnGzZ7eJfgiYsmGc+IzIARvOU2xyqhx
xr7ubY9Lc8na0xmOr+8hCAr4YiGr/OPQzpD2Nt+4bbm6W8IWwA1M1xbQWN1NkWvn
uicMrUjIWZz0ju0I/7lqCgi0UGLVV6RgM4WFPsjmh4YneBN/MeiAiK1S8t8tBpaX
sy6/lRlvkU5RJXtWJpYo3uSlsRWB4lA/9H7vIWeDKCG8ROuscMEfqwC1kf91bXkW
Ab4dfquQrzH9XZaiEf/HiQJYuYzqCfo3ug4r4A8I6stxT/FgATo5HAeo9xSYKxcF
bSG5sXTdFNVfyTRlhUfok2rPLO97SpNgOGkdZfOk+IVn3Eqktx9cerDajAIpDFny
qKak9Hhbo9QKveMDkMD8m5R4J5raYx7NIIhUGkevNiFt2xt7dKhR5TjnfZAG5iJu
L+hocQpmsTNGkGWidqhV
=LvXN
-----END PGP SIGNATURE-----

--ZuCi2HMIMuKavysU--

--===============1236786431358416250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1236786431358416250==--
