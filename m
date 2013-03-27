From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 27 Mar 2013 23:07:30 +0000
Message-ID: <20130327230730.GA18316@opensource.wolfsonmicro.com>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
 <515377AD.9080704@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6290231219168035221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65A44265317
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:07:32 +0100 (CET)
In-Reply-To: <515377AD.9080704@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6290231219168035221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bF8FQe8Tx5jntaYn"
Content-Disposition: inline


--bF8FQe8Tx5jntaYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2013 at 04:50:21PM -0600, Stephen Warren wrote:
> On 03/26/2013 07:15 PM, Mark Brown wrote:
> > On Tue, Mar 26, 2013 at 05:35:38PM -0600, Stephen Warren wrote:

> >> +/* IN1/IN2 Input Type */ +static const char * const
> >> rt5640_input_mode[] = { +	"Single ended", "Differential"};

> > This looks like platform data.

> I thought the idea was to expose all the CODEC's configuration/routing
> through DAPM, and then let everything get set up through controls at

Given that changing between single ended and differential generally
involves a modification of the circuit this is something we know at
build time in the same way we know how the microphone biases are wired
up.  Changing it would generally need to be coordinated with some
external circuit (eg, flipping an analouge switch to reroute the
signals) and hence done from the machine driver.

> run-time? Looking at the WM8903 driver, it seems like it has the exact
> same kind of option.

Older drivers aren't always good examples of this stuff.

> >> +/* DMIC */ +static const char * const rt5640_dmic_mode[] =
> >> {"Disable", "DMIC1", "DMIC2"}; + +static const
> >> SOC_ENUM_SINGLE_DECL(rt5640_dmic_enum, 0, 0, rt5640_dmic_mode);

> > DAPM?

> I'm not sure what change you're asking for here; isn't this defining a
> control that influences the DAPM routing?

It looks like just a plain old enum to me.

> Perhaps the issue is that the enum above feeds into a snd_kcontrol,
> rather than being an snd_soc_dapm_route that's conditional upon one of
> the values in that list?

Probably, or a mux or something.

> I'm not really sure what MIC1/MIC2 are meant to represent...

I think they're supposed to represent the microphones someone might
connect to the inputs but that should be done in the machine driver.

> > Shouldn't the DMIC CLK widget be handling the clock enables/muxes
> > from the DMIC event above?

> Oh right, so you mean:

> * Add a SND_SOC_DAPM_OUTPUT() for the "DMIC CLK".

No need for that, it can just be handled as a supply within the device
since it's an integral part of the DMIC interface.

> * Add routing table entries where "DMIC1 *" are each fed from "DMIC
> CLK", with "conditions" based on which DMIC is "on":

> {"DMIC L1" "DMIC1" "DMIC CLK"},
> {"DMIC R1" "DMIC1" "DMIC CLK"},
> {"DMIC L2" "DMIC2" "DMIC CLK"},
> {"DMIC R2" "DMIC2" "DMIC CLK"},

> or something like that?

Pretty much.

> >> +static int get_sdp_info(struct snd_soc_codec *codec, int
> >> dai_id)

> >> +	bclk_ms = frame_size > 32 ? 1 : 0;

> > Grumble.

> Sorry, I don't understand the issue here. (through lack of familiarity
> with the issue; I'm not saying there isn't one).

I don't like the ternery operator where it's not especially idiomatic,
if I wanted to read line noise I'd be working with perl.

> >> +static int rt5640_prepare(struct snd_pcm_substream *substream, +
> >> struct snd_soc_dai *dai) +{ +	struct snd_soc_pcm_runtime *rtd =
> >> substream->private_data; +	struct snd_soc_codec *codec =
> >> rtd->codec; +	struct rt5640_priv *rt5640 =
> >> snd_soc_codec_get_drvdata(codec); + +	rt5640->aif_pu = dai->id; +
> >> return 0; +}

> > This looks like only one DAI can be active at once, shouldn't there
> > be some sort of checking for busy here?

> I haven't read the spec through in explicit detail, but I didn't see
> anything to indicate that only one DAI could be active at once. In
> fact the diagrams in the documentation make it look at least somewhat
> cross-bar-like.

> It looks like rt5640->aif_pu is used solely by set_dmic_clk() to
> somehow derive the DMIC CLK from the DAI LRCLK based on which DAI is
> actually active. I assume "which DAI is actually active" should be
> implemented as "which DAI is routed from the DMICs". I guess this
> should be implemented in a very different way then?

Probably, yes.  This code really doesn't look like it'll work properly
if the two interfaces are running at once, especially if they are
started simultaneously.

> I wonder if this all shouldn't be explicitly represented by DAPM
> widgets/routes, but the diagrams and text in the documentation aren't
> particularly clear on what this third thing is that the code seems to
> support:-(

Yes, putting it all into DAPM seems like the way forward.

> >> +static int rt5640_resume(struct snd_soc_codec *codec) +{ +	int
> >> ret = 0 ; + +	codec->cache_sync = 1; +	ret =
> >> snd_soc_cache_sync(codec); +	if (ret) { +		dev_err(codec->dev,
> >> "Failed to sync cache: %d\n", ret); +		return ret; +	} +
> >> rt5640_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

> > We also sync the cache in the bias management code.

> In other words, I should just remove the call to
> snd_soc_cache_sync(codec) here, since it's redundant?

Or remove it from the bias management since there's no regulator or
other code I can see which cuts the power or otherwise resets the device
so restoring the cache outside of suspend is probably a waste of time at
the minute.

--bF8FQe8Tx5jntaYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRU3uDAAoJELSic+t+oim9OsIP+wUdejLbl8//KeNcf3HvxQh8
jID1kin+8UVjmp+DZ0O44jufVYxIjcWaiUBdgGsYzl8EkMPIE8wWaUsEy1BEjky5
zmZVprTjKYI2JqE5xv4eDTiFqUkhhinIzdmJKkXpNbPYZFjwPy3jFl1OKfoIgFOL
F6l9H9dNij1LVZPsvIZA3hZK9nsuN9mhtRBDkOF1Lgob9y2DojbxerM9L6Zp/J7/
prNC2/eGXegXRVRu1xIshIdlrmbAfjKHFj7UYCk8F4A0AMjJCJ/c8a6VPc+tp5o5
I1C4IuDeWgb6XZ4b8WZeNeC9S0kgs+Ziv44PRNAf8bPNSjkVkmLDA4R3sIpZg3SB
QR6sddkJVy2AK9aZnXJkX8qjGi9ie4bBc8LPDYOYeixIVS86sPzlZrmgUVd33C8A
cZe3TPGuolDy7dKykif2tV/kOvGsfPpPoI32H+IAg4xfAqLKu0u8tl6jPku/TnFn
2m0adqSOSWR100k6OEduGKbotgrhl2Sb4AhG0GvYigFjLjLkuDl83G7F37EHwmnh
/Ot7jJJq+XkAq16IRg7vZNqnrXuaj9vkIq0Wa0eVQ21kJ4H8BKrInQLfZG1+ZZP6
3ZUCo++mliYbL4ZXFk/t8OZJqft+7IdoPEtwvLg9T+Zi5h2i/xkg6VaOTGskkyUY
tviAPsKXTN/MbPcAGkqR
=/NVl
-----END PGP SIGNATURE-----

--bF8FQe8Tx5jntaYn--

--===============6290231219168035221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6290231219168035221==--
