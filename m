From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/9] sound:asoc: Add support for STA529
	Audio Codec
Date: Fri, 22 Jun 2012 09:49:19 +0100
Message-ID: <20120622084918.GE4037@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<d06e4180229ac4aa0e0f27aa4d444dd7a9634afd.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120621122540.GV4037@opensource.wolfsonmicro.com>
	<4FE41021.3060605@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1090810587420010049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B32EB24336
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 10:49:21 +0200 (CEST)
In-Reply-To: <4FE41021.3060605@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============1090810587420010049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDpvzslK0qRw06MN"
Content-Disposition: inline


--vDpvzslK0qRw06MN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2012 at 11:56:41AM +0530, Rajeev kumar wrote:
> On 6/21/2012 5:55 PM, Mark Brown wrote:

> >>+static int sta529_resume(struct snd_soc_codec *codec)
> >>>  +{
> >>>  +	snd_soc_cache_sync(codec);
> >You're not using the ASoC cache code.

> Point is not clear to me, you mean to say I need to use
> regcache_sync(sta529->regmap), please confirm.

You shouldn't be calling ASoC cache functions at all since you're not
using an ASoC cache.  There's no point in doing anything here as you're
doing your cache management in set_bias_level() but if you were then yes
you should be using regcache_sync().

--vDpvzslK0qRw06MN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5DGGAAoJEBus8iNuMP3dtjMP/jLdOOF+af8+ICET3+RFqpqr
P0meUIeiDLN3pbGeotzdzAft4lou2RhtpW7xJGA+B1lQeOvv4YZQhY+wWKILJzVY
U96/C+JV9pWxBZezx5mJbNzHb5sKiomoJDp/i3JF8VKs+VR8U30OeQG2Mwtxyn2z
Ge9KwbWpJs9q5uULKhxRO4johff+0QqpcsTVty5KjbiWOj8BxDYRJ/MlcO1zRr0P
qr2KSKWDj8CcpHcGL510MSfXxXkPXbSDNOi701Dn+7P2c8vggWZ4wpp1INRbSlP7
UeKYYFWRcIZYm3Zyumlm0FmSwB/yA8IB8XjwRSw70EfzllvZVskEtEotDM8LD3kz
4Y4TH9dDzk7KxynUY0B0XsbL+EY8ImB2DBBChMk24j8yr5KkZerBk3HXfgvXQCvm
MuKz9CydthRWuw0lLzko686p2z3DQgj0OiKGI3q8LNAuA1fSdIb0NcAzMiXgkWMN
p9b9Po2Ie/+WBzXCQe1LyADNOAFqiI0pyqY1jq3+CzYEZWsPobu66gmQ/4J13zym
e/uoEwmBRjF3iW5PWgRe8O6r78PjtX2t2GXkanVkePOzqxxxTxIN2g5Nww+3ffVz
YKDXqiVfqRmw4cn4Bso2Y/udPQrouhOuoKJY4ngi7L2z+9MhBSZr/p4o+vzdO2Ay
Si5hQTrHq0yasocsnSGj
=istC
-----END PGP SIGNATURE-----

--vDpvzslK0qRw06MN--

--===============1090810587420010049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1090810587420010049==--
