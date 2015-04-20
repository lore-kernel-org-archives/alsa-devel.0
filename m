From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] ASoc: Codec: add sti platform codec
Date: Mon, 20 Apr 2015 21:33:28 +0100
Message-ID: <20150420203328.GF14892@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-8-git-send-email-arnaud.pouliquen@st.com>
 <20150418130914.GT26185@sirena.org.uk> <5534C337.9080009@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0516632617091691047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BBCEA260616
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 22:33:35 +0200 (CEST)
In-Reply-To: <5534C337.9080009@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0516632617091691047==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 11:13:27AM +0200, Arnaud Pouliquen wrote:
> On 04/18/2015 03:09 PM, Mark Brown wrote:

> Register definitions are already part of the driver data structure
> (stih407_data  or stih416_data) .
> Your point is that i should delete this structure?
> And then use  separate regmap_field  tables (dynamically allocated) for for
> register map
> and declare registers struct like this
> static struct reg_field sti_sas_dac_stih416[STIH416_DAC_MAX_RF] = {
>     /*STIH416_DAC_MODE*/
>     {REG_FIELD(STIH416_AUDIO_DAC_CTRL, 1, 2)},
> ...
> }

Yes, basically.

> >>+static int sti_sas_hw_params(struct snd_pcm_substream *substream,
> >>+			     struct snd_pcm_hw_params *params,
> >>+			     struct snd_soc_dai *dai)
> >>+{
> >>+	struct snd_soc_codec *codec = dai->codec;
> >>+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >>+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >>+	int ret, div;
> >>+
> >>+	div = sti_sas_dai_clk_div[dai->id];
> >>+	ret = snd_soc_dai_set_clkdiv(cpu_dai, SND_SOC_CLOCK_OUT, div);
> >>+	if (ret)

> >set_clkdiv() is an external API, you shouldn't be calling it within the
> >driver - probably you should just not implement it and inline the
> >functionality here.

> how to do it properly?

Like I say probably you should just inline the functionality here.  It's
not like anything else can usefully call set_clkdiv() if the driver is
just going to do it itself anyawy.

> My point is that cpu codecs have a constraint on MCLK_FS division.
> So i need to provide it to the CPU_DAI that generates MCLK.
> I checked simple driver
> priv->mclk_fs exists but is only used to set codec dai not CPU dai...
> should i add call in simple card?

Possibly.  In general it is better to add missing functionality to
generic code rather than bodge around the generic code.  However in this
case I expect that any user of the driver (not just simple card) may
need the same configuration.  If that is the case then the driver should
just always do the configuration without needing the machine driver to
do anything so this just doesn't need to be visible outside the driver.

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWKXAAoJECTWi3JdVIfQnFEH/0TAdRM6EOgTjKn5EI07xiL1
tgoD/JnZeH9MashzE/lwHgbSTwj1cw2PhNMF4rWP3OI6Ne+GzP0U8Xap0v+VneRz
aqGd6+KMnu89EzZqWbODSRDSg0vonPhAsJ9+gbLaeHpkl5ipZ6qLAnBSL+gVnOaH
If7lHEEXjnCtxnkf+k/3B4c36tIvd0V/G2Lu3UfeDD07WDeyfueLLMyDswaB6KtE
epv5OgxoHyVp4sT99W9N7AcVcq3jn4A/rSxFc9+3ujTHhDOvLt1/vOWwx1LEXfqH
ntH8ojBAtdf/mjbZZfgA74qD11OnE1c7nG6VyQYa96HhemJ1c6FWCzknqYfGDuc=
=dic0
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--

--===============0516632617091691047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0516632617091691047==--
