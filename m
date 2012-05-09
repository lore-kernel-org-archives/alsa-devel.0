From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/11] ASoC: core: Add widget
	SND_SOC_DAPM_CLOCK_SUPPLY
Date: Wed, 9 May 2012 09:47:59 +0100
Message-ID: <20120509084758.GA3955@opensource.wolfsonmicro.com>
References: <1336485400-27150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508154027.GY15893@opensource.wolfsonmicro.com>
	<4FAA230A.7060407@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1845282491848594963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2C0124586
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:26:04 +0200 (CEST)
In-Reply-To: <4FAA230A.7060407@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1845282491848594963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 09:55:54AM +0200, Ola Lilja wrote:
> On 05/08/2012 05:40 PM, Mark Brown wrote:
> > On Tue, May 08, 2012 at 03:56:40PM +0200, Ola Lilja wrote:

> >> +	if (SND_SOC_DAPM_EVENT_ON(event))
> >> +		return clk_enable(w->priv);
> >> +	else {
> >> +		clk_disable(w->priv);
> >> +		return 0;

> > Coding style - you need more { }.   This also all needs to be
> > conditionally complied for the many platforms that don't provide the
> > clock API.

> if (clk_enable)
> 	return clk_enable(w->priv);
> else
> 	return <some error>;

> ?

That's not going to help with platforms that don't provide the clock API
if that's what you're asking.  clk_enable() just won't be a symbol.

> >> +	case snd_soc_dapm_clock_supply:
> >> +		w->priv = (w->shift) ? clk_get_sys(w->name, NULL) :
> >> +				clk_get(dapm->dev, w->name);

> > I don't think supporting clk_get_sys() is a particularly good idea
> > here...  Also, I think Liam was wanting to add per-user data to the
> > widget rather than reuse the priv pointer.

> OK, so how can I solve the fact that we have one clock that is gotten with
> clk_get_sys()?

You should be using clkdev to map the clock to the device.

> The priv-pointer was reused for the delay in the regulator-supply, so I assumed
> that it was ok here as well. How should I do it so that it is OK with you, then?

Add a struct clk * to the widget.

> >> +int snd_soc_dapm_get_power_status(struct snd_soc_dapm_context *dapm,
> >> +				const char *pin)

> > This appears to be *nothing* to do with the rest of the patch!  It's
> > also not clear what it's for.

> It is for the debugging in our driver, using it to get the status of our clocks
> so that we can make sure that the correct clocks are enabled/disabled at certain
> points that we find useful.
> I named it get_power_status instead of get_clock_status, just because I thought
> you would complain that get_clock_status was using the ->power, which is not
> specific to just clock-widgets.

As discussed elsewhere this seems like a bad idea, but even if it's a
good idea this should have been split out - it's not a part of
introducing a new widget type.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqi8sAAoJEBus8iNuMP3dB7oP/2LN/8wECoMUNUxyXniyFBec
MSqbdHPVDEJcB+IeX1ndWAS+D5l4zCOeXQyuUR+UJt4MjqHJ9jWEFDVaYL9FIhMM
hT9EIbKuGcke2ti8zqfC1T0IT8w3KJ/UYTwqdAsAYSp64KJtap4UqFzqrQ+KNlyr
IBjcysYP47v01SSoF+Fxzzfjn3KD+7Qi6hQDtXUPkgH4W2bPRjkJ24ZsTL4J26vL
mTbKbMxUZIVtYi2ntFYU+lI/zj0LQd3qjY+3SxQy0lrqw4U3CvD6LFM2grbHb34k
C4YZ8trPTHlS+oWEKRfEOBCLdzsjdZDVtL3T+gCWu212iZpYMdnYyjey+emA37Qy
nAh+lV3WFIBAw5rtjowFEUhABCfJHJUCaFgIwRHtxtEuatFfBUYdyRx5tHIkVN+o
6UT5tsmjZc2jiCxvDdA1tMUngz6h2H9SzLj0b3RttXgmMGIa/knD0631n94ei2nA
np1jCA5GhVR9gjMYmISZ/kqjWuJEpcoXeo46xgIpnTDPpS2n0VMwR3rnQTADNOwk
Pf5IBWuFPbL0+o20Cvm/m2zTeKbt8EguGylUcMPt2h6fuIB0FKKwVH677fGBo72A
O1HxFH3V42OzDCXjGghUQSLk5Iyp+GI7fJIiGO2vXbiCdaxpyStUqKGOcdHRMlvk
622UETiW5Dtq67yev82L
=rdNp
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============1845282491848594963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1845282491848594963==--
