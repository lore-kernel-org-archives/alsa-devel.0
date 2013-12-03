From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ux500_pcm: Differentiate between pdata and DT
 initialisation
Date: Tue, 3 Dec 2013 15:07:55 +0000
Message-ID: <20131203150755.GZ27568@sirena.org.uk>
References: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8664782279494483997=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linus.walleij@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8664782279494483997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IchZQccUbQrk8obU"
Content-Disposition: inline


--IchZQccUbQrk8obU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 10:27:06AM +0000, Lee Jones wrote:
> If booting with full DT support (i.e. DMA too, the last piece of the
> puzzle), then we don't need to use the compatible_request_channel call
> back or require some of the historical bumph which probably isn't
> required by a platform data start-up now either. This will also be
> ripped out in upcoming commits.

Applied both, thanks.

--IchZQccUbQrk8obU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfPIAAoJELSic+t+oim9LnAP/108kwuVEJ/gly3Yzp0R4R9m
8d6dKjeJLSRoD7Z86cHDpu9z+0REWDLN9rivdOFaFWdckBokLKz0mS+a5kWGTswr
oJqMtpeBTUtTMRdGGGKnFFK2FG9ygg8OgR9gbkytY0LdpLoGUSX3H97Z6UPZuN/O
DZppzk/9k6p6DKjz9gIxXOpxyRPXDMSeGK7a7YD571B4HwxNKNkNUTf4yK/uOmNE
zHLsVXvhAaYsihYy20n+3YbncTceNl0UmYOihu8WCivkjA7Gx/iSF8fJ84cShJwC
5JuAFDAi4ovgdLQukLUzqLdun7KenJDJ5rxjnUL29hTCEYnMHnIgOa5nQwBGWVqT
pO0cxYoPOxB5NRTEQN6+dODVDWsHu7uPQSROlgdyEpy4d2SjvlrNoclnoH7NQNEK
nKVPONovUCOXx8Hj+IrmW/W2kpSQkXOgJMauUfvwq18GxqGHJHaqo9JcrFDkFpwC
+OFKXLSvyDOvYp7KFzMjrEdpqKjgXeCG/XitjQyQZz/Cziiz9merk14IXVhKZy+L
NjrR+fQvykMCQGO+f5gGD6O1YA23svpoW4gLdUfZEDk5pVPwTm+ZXNITid8Nd20a
Qrojf85b1aEY4NNMNozjxxyamKbxHSnKi0a5WSVV2IRSrLlr9fo1bNlFTKNT3Z8u
GNPkfHh7cMFA5JPu+52c
=UArl
-----END PGP SIGNATURE-----

--IchZQccUbQrk8obU--


--===============8664782279494483997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8664782279494483997==--
