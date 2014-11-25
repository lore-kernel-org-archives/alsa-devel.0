From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Tue, 25 Nov 2014 12:07:24 +0000
Message-ID: <20141125120724.GP7712@sirena.org.uk>
References: <1416034608-24238-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1273475465712767685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B618B2605B4
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 13:09:23 +0100 (CET)
In-Reply-To: <1416034608-24238-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Anatol Pomozov <anatol@google.com>, Grant Likely <grant.likely@linaro.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1273475465712767685==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="epRuUhiNkW/O9uqo"
Content-Disposition: inline


--epRuUhiNkW/O9uqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 10:56:47PM -0800, Ben Zhang wrote:

> The rt5677 codec driver looks for ACPI device ID "RT5677CE",
> which is specified in coreboot. This patch allows platform
> data to be obtained via ACPI

This actually does two things - it adds the ACPI device probing and it
adds the ACPI platform data.  That last bit is a bit fun, I've added
several of the people working on ACPI here since this is another variant
on the whole ACPI platform data thing which probably needs addressing in
the best practice dissemination which ought to be going on now.

> +static unsigned long long rt5677_parse_acpi_entry(struct device *dev,
> +		acpi_string name)
> +{
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +	unsigned long long val;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(handle, name, NULL, &val);
> +	if (ACPI_FAILURE(status)) {

So, here were defining what's essentially an ACPI property read API
which uses something other than _DSD which is the way all the ACPI
platform data specification for devices is apparently supposed to be
going in order to reuse work between DT and ACPI.

> +static void rt5677_parse_acpi(struct rt5677_priv *rt5677, struct device *dev)
> +{
> +	rt5677->pdata.dmic2_clk_pin = (enum rt5677_dmic2_clk)
> +		rt5677_parse_acpi_entry(dev, "DCLK");
> +	rt5677->pdata.in1_diff = (bool)rt5677_parse_acpi_entry(dev, "IN1");
> +	rt5677->pdata.in2_diff = (bool)rt5677_parse_acpi_entry(dev, "IN2");
> +	rt5677->pdata.lout1_diff = (bool)rt5677_parse_acpi_entry(dev, "OUT1");
> +	rt5677->pdata.lout2_diff = (bool)rt5677_parse_acpi_entry(dev, "OUT2");
> +	rt5677->pdata.lout3_diff = (bool)rt5677_parse_acpi_entry(dev, "OUT3");
> +	rt5677->pdata.jd1_gpio = rt5677_parse_acpi_entry(dev, "JD1");
> +	rt5677->pdata.jd2_gpio = rt5677_parse_acpi_entry(dev, "JD2");
> +	rt5677->pdata.jd3_gpio = rt5677_parse_acpi_entry(dev, "JD3");

Here we read a bunch of properties named with a most definitely non-DT
idiom.  The names here don't look great in general, in particular all
the properties for differential outputs are just boolean flags for the
output name which I'd expect to be flags saying if the output is in use
or not rather than saying if it's in differential mode or single ended
mode.  Things like foo_DIFF would seem better.

My understanding is that best practice for ACPI is to use the new
device_property_read_ APIs which idiomatically take DT style property
names.  However if there's BIOSs out there we need to support perhaps we
just have to deal with this but judging from your e-mail address it
seems this may be for a system intended to run Linux natively so perhaps
that's not an issue.

--epRuUhiNkW/O9uqo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHD7AAoJECTWi3JdVIfQS+cH/086wR38jeZWLn7aRPa8DX+p
ii5R+xTJBAmwmfCs6+e8Xl3fCGJZ7u6Vmv01oAXMom2xO3+eNFojHNfz1IbdExVE
dU+U2iIRvEr5y2ZdCCuK3IqgH/nAPiJ283MvTycVpjyYE9y048R3yqaREfqfAhMh
/A0DKIP2KajtaOZgoVf++9QHFjgsK5l68UI/kauHgm3sllhObwj9aQty5mcNoCHq
q1ua4fk5+R3YDRiE9noq8wXRFKZQ9KS6QKHXWfirN3RLkeI1fIyJsqzNAyAlTiBJ
SNOMFfEH3Ysi3Dpnuouamo06GJLimnQtCqN50iZghsYIJiZatMc/AB2ZD9WodAQ=
=Ccnp
-----END PGP SIGNATURE-----

--epRuUhiNkW/O9uqo--

--===============1273475465712767685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1273475465712767685==--
