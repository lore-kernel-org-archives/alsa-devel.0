From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: rt5640: add device tree support
Date: Wed, 12 Jun 2013 17:46:28 +0100
Message-ID: <20130612164628.GN1403@sirena.org.uk>
References: <1370983240-4976-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9151312544605357143=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370983240-4976-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, flove-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============9151312544605357143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CoKeqzoheR24UlpS"
Content-Disposition: inline


--CoKeqzoheR24UlpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 02:40:40PM -0600, Stephen Warren wrote:

> +- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.

Why gpios and not gpio?

> -	if (rt5640->pdata.ldo1_en) {
> +	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
>  		ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
>  					    GPIOF_OUT_INIT_HIGH,

Unfortunately gpio_is_valid() is unhelpful for platform data since often
zero is a valid GPIO but it's also the default "do nothing" platform
data.  It's therefore better to either include a check for non-zero as
well or have code that takes a zero in the platform data and sets it to
a negative value instead.

--CoKeqzoheR24UlpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuKXhAAoJELSic+t+oim92dMQAIo/aWyXJQ7ZBzbFBk8o8d6v
YLE118hmpNpVmpkHlXHaIQ9/yTxxntCvToGuvAvykgJosOJF7f+bFIlDgKPN47NX
svbw0fw6+bXEjoVkUPYWaljXROVr6wKQ/9Mr+hNXbpc6ZDw9GuIXo6WwOvdhtXM/
IOACTe38IAJNzJvm9GKBYfP0Y+w8bbZRZHtkXzPjf2qKr4Aol8UJfhsIR9jbSp+h
qMnMUQQ9wM8yorCxijgZRq8eNKNngYO+slL9jiPASrSLcu9o8d8/1q44hClgmimw
QhhSkZ4o56W4tLm/OQTlzr1d6kfvm3PxC3KWh66tKS96UxLiN+VKPd4Zwd8ywTNX
/yPgxSbUKjEH8kXNqAJSVO+mKxNVtaqD5d9YNdI6uccE6YGurS9tHptR16UdnAgm
/Id1XuDXltdDCEbikXpaOu8Rs7wYH5x4DeYGTtXQFMSCLbe89WdjGLn7PANx5i+C
l4O56BifDnWb+0mVXXsZuAZ8zR4JLf7bqZz7mT/fTTtlWl70uJmpVbO4lf2HasDd
b6csb25DrLn+FeNzpe7owGxg828nrmgA9JnEy62/Mrl0VN2xd4xAV2WfutxBpcI7
XICuew/KIqiDb2huynvJ9pu71b6mYMsbnBH0A6TfjcvYKMmBZLnmDO3zCKzUCMLN
SSG+tds7eXMtbCZazPmE
=bNdQ
-----END PGP SIGNATURE-----

--CoKeqzoheR24UlpS--

--===============9151312544605357143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============9151312544605357143==--
