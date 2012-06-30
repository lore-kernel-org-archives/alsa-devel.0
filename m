From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Sat, 30 Jun 2012 19:35:58 +0100
Message-ID: <20120630183558.GB28922@opensource.wolfsonmicro.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
	<20120628122727.GI28922@opensource.wolfsonmicro.com>
	<4FED5AB1.6030907@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6601833752915978772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF508244ED
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 20:35:59 +0200 (CEST)
In-Reply-To: <4FED5AB1.6030907@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vipin Kumar <vipin.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, "tiwai@suse.de" <tiwai@suse.de>, spear-devel <spear-devel@list.st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============6601833752915978772==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vWfgMjdKllQeoPX8"
Content-Disposition: inline


--vWfgMjdKllQeoPX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2012 at 01:05:13PM +0530, Vipin Kumar wrote:
> On 6/28/2012 5:57 PM, Mark Brown wrote:

> >>+	.ops = (struct snd_soc_dai_ops *)&spdif_out_dai_ops,

> >Why do you need this cast?

> It was a const I think

So you've just introduced a bug, then - you're using a const variable in
a non-const context.  Don't cast away the const, either arrange for the
ops pointer in the dai to be const or remove the const.

--vWfgMjdKllQeoPX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP70cHAAoJEBus8iNuMP3daygP/jlmvw3Wa7WUd+BmdNCSjs6W
yXUGrGGk1z9X3XPKIXvI/7LNryE/ufVt83/sAqHHWrJe7RHr6vBcS2S1dA68NPTj
9D5FMT3Wh5+9jKQwJ4O5eEqPv4ZccRrKFNKtYcpKvwZaBxcSFWZG9bz5ZJlsqoZE
wLd/lhKPRPCUJ7Pm1Oy8k5yzFxg2fTqfEltRRJbdc/f1p5fiM1R49m1Zomvl8pb+
W06UCfL9GoY0DCZppi6f9R9UYIDHumjFvIIeaJfus6s7VzV8DBrMypopRFPZvUyM
RXA5qimdnXySXpiQMG2pqTXvBbylSg5XkbyEG9kFcqKnDDd/A+ExmXouavtsEDZF
nTC69WaEKisnfI5pV5rjyNUewz3O04H/o72v5+gcORvtv5VBDVJC10G6u7sdLNVB
jAZXDrvdkq9tQ/Xnd5UxaepfgKU2KWbttv8mUv1tZodDqz9nT8fTjY7mQrgA3lat
D/0P6jnitl5rLtIdJ7hkuXCceWwPjYpdbwdCc/6hU8l3KSL5Zz9ycznDvqf0aVzf
4jtAFauoh1Fnp678W3sKw6Uji/noInSAxZBif0Z8+rphiARbbz1N6gbUEcGaqluL
W81POFCo7TXRUHCPH2nddI/ydnpRbGlskW9eyltvEcKmib9zEGklcGh587TZpPAC
A3U6olCl6rrLSanLUsQK
=cnbQ
-----END PGP SIGNATURE-----

--vWfgMjdKllQeoPX8--

--===============6601833752915978772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6601833752915978772==--
