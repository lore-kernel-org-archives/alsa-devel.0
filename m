From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 7/9] ASoC: Codec: Add sti platform codec
Date: Tue, 2 Jun 2015 20:12:36 +0100
Message-ID: <20150602191236.GE14071@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-8-git-send-email-arnaud.pouliquen@st.com>
 <20150525130124.GS21391@sirena.org.uk> <556C9962.4040508@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1605978065017086074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BEFB260523
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 21:12:43 +0200 (CEST)
In-Reply-To: <556C9962.4040508@st.com>
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


--===============1605978065017086074==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ht9V8wKec6a3w1Ef"
Content-Disposition: inline


--ht9V8wKec6a3w1Ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 07:41:54PM +0200, Arnaud Pouliquen wrote:
> On 05/25/2015 03:01 PM, Mark Brown wrote:

> >These event functions all look very similar and I can't help but think
> >that they look awfully like the sort of register write sequences that
> >DAPM normally generates anyway.  Is there any great reason for not doing
> >these by registering multiple widgets with routes between them rather
> >than with custom code?

> I need to respect the sequence for power up /power down. for sure I could
> manage it using 3 DAPMs with routes, but how to ensure sequence?

There's a defined ordering for handling widgets of different types wich
probably suffices.

> Moreover, i will need to implement a cpu dai DAPM to manage uniperipheral
> clock. This clock need to be enabled/disabled before/after DAC to avoid
> plop. So would prefer to manage the DAC sequence in a single function...

We already handle clock and supply widgets very early and late in the
sequence for precisely this reason.

> >>+	div = sti_sas_dai_clk_div[dai->id];
> >>+	if (cpu_dai->driver->ops->set_clkdiv)
> >>+		return cpu_dai->driver->ops->set_clkdiv(cpu_dai,
> >>+							SND_SOC_CLOCK_OUT, div);
> >>+	dev_warn(codec->dev, "WARN: CPU DAI not support sysclk div");

> >This is worrying, we shouldn't be peering inside the CPU DAI like this.
> >I'd expect this to either be done autonomously by the CPU DAI or handled
> >in a machine driver.

> I think i misunderstand your remark in V1...but i still not understand how
> you want that i implement it, if i can't neither use snd_soc_dai_set_clkdiv
> (except implement it in simple_card).
> Please could you precise how you would like that i implement the feature?

I don't know exactly what "this feature" is so it's hard to be sure what
the above is supposed to do but the fact that you're having one driver
for your platform set a clock divider in a completely different driver
for that platform should be an enormous red flag - at a bare minimum
whatever you're doing here doesn't seem like it should be done in this
other driver.

> I'm kind surprise that nobody else have this kind of setup. I know at least
> one codec that should need this kind of service: AK4628.
> For this codec, depending on runtime frequency, a division value should be
> apply between MCLK and SCLK...

We already have a _set_bclk_ratio() API if that's what you're looking
for?  It's not something that your CPU drivers should ever be using,
though - it's something for machine drivers.  Your CPU drivers can't
know what configuration a particular machine is going to require.  I
don't know what SCLK is here, do you mean LRCLK?

--ht9V8wKec6a3w1Ef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgAjAAoJECTWi3JdVIfQP5sH/R9khb6JE+0gXItiDd+N0Hhd
D8FKLrnoQqKoIJFM4Mq4064u+YrrzeDNOv+8XA7npLUoZGzBc0d4FZrn90nZsRCM
+TRgGCpb8H120auiuaWf5IkptG8/PvXyFWyl9mUoV2eP2a2cJ+kUMxAZIrkxoEx2
GxtEOURh7K64hhe5HZERMbofELq0m9T2pXrEsdhJrE44LIyx71wnQVKkiNvxDSH7
m0l6LHHzPklCe1zUXEWrdpjKNJD/RZvJXDQfn0Nt9UZDOusrGA75B/lo1cAIkeXP
WIR7HB6M1+PMve5tP7rq2iBn18FGfyOHcl8hUWgsxgna8BfEq/fh0aF++tri1FA=
=t9ua
-----END PGP SIGNATURE-----

--ht9V8wKec6a3w1Ef--

--===============1605978065017086074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1605978065017086074==--
