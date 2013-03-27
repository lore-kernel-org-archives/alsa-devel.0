From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 27 Mar 2013 16:50:21 -0600
Message-ID: <515377AD.9080704@wwwdotorg.org>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B7096265319
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 23:50:25 +0100 (CET)
In-Reply-To: <20130327011511.GP18316@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 03/26/2013 07:15 PM, Mark Brown wrote:
> On Tue, Mar 26, 2013 at 05:35:38PM -0600, Stephen Warren wrote:
> 
>> Mark, a couple questions: * Is the custom index_reg device attr
>> file OK, or should I remove that? * Do new CODEC drivers have to
>> use regmap directly, or is using the ASoC IO system still OK?
> 
> Convert to regmap please - it looks like this ought to be using
> the paging support from a quick glance at what the register I/O
> stuff is doing.  The device file appears to duplicate the register
> dump stuff and isn't suitable for sysfs anyway as it's not one
> value per file, it ought to be in debugfs.

Ah, I hadn't seen the ranges stuff before. I think that should work.

>> +/* IN1/IN2 Input Type */ +static const char * const
>> rt5640_input_mode[] = { +	"Single ended", "Differential"};
> 
> This looks like platform data.

I thought the idea was to expose all the CODEC's configuration/routing
through DAPM, and then let everything get set up through controls at
run-time? Looking at the WM8903 driver, it seems like it has the exact
same kind of option.

>> +static const char * const rt5640_data_select[] = { +	"Normal",
>> "left copy to right", "right copy to left", "Swap"};
> 
> DAPM?
> 
>> +/* DMIC */ +static const char * const rt5640_dmic_mode[] =
>> {"Disable", "DMIC1", "DMIC2"}; + +static const
>> SOC_ENUM_SINGLE_DECL(rt5640_dmic_enum, 0, 0, rt5640_dmic_mode);
> 
> DAPM?

I'm not sure what change you're asking for here; isn't this defining a
control that influences the DAPM routing?

Perhaps the issue is that the enum above feeds into a snd_kcontrol,
rather than being an snd_soc_dapm_route that's conditional upon one of
the values in that list?

If so, that's going to be a lot of stuff to change in the driver
considering that I can't actually test any of the DMIC (or even analog
mic) support yet since I can't get it working. Perhaps I should just
rip out all the widgets/controls I can't test?

>> +static const struct snd_soc_dapm_route rt5640_dapm_routes[] = { 
>> +	{"IN1P", NULL, "LDO2"}, +	{"IN2P", NULL, "LDO2"}, + +	{"IN1P",
>> NULL, "MIC1"}, +	{"IN1N", NULL, "MIC1"}, +	{"IN2P", NULL,
>> "MIC2"}, +	{"IN2N", NULL, "MIC2"},
> 
> Are MIC1 and MIC2 pins on the device?

Hmmm. I see SND_SOC_DAPM_INPUT()s for MIC1 and MIC2, but they don't
appear to be pins on the device. Rather, IN1P/N and IN2P/N are the
pins, and also are declared as SND_SOC_DAPM_INPUT().

I'm not really sure what MIC1/MIC2 are meant to represent...

>> +	{"DMIC L1", NULL, "DMIC CLK"}, +	{"DMIC L2", NULL, "DMIC
>> CLK"},
> 
> Shouldn't the DMIC CLK widget be handling the clock enables/muxes
> from the DMIC event above?

Oh right, so you mean:

* Add a SND_SOC_DAPM_OUTPUT() for the "DMIC CLK".

* Change the "DMIC L*" from SND_SOC_DAPM_PGA_E() to
SND_SOC_DAPM_PGA(), and move the event to the "DMIC CLK" widget.

* Add routing table entries where "DMIC1 *" are each fed from "DMIC
CLK", with "conditions" based on which DMIC is "on":

{"DMIC L1" "DMIC1" "DMIC CLK"},
{"DMIC R1" "DMIC1" "DMIC CLK"},
{"DMIC L2" "DMIC2" "DMIC CLK"},
{"DMIC R2" "DMIC2" "DMIC CLK"},

or something like that?

>> +static int get_sdp_info(struct snd_soc_codec *codec, int
>> dai_id)
...
>> +	bclk_ms = frame_size > 32 ? 1 : 0;
> 
> Grumble.

Sorry, I don't understand the issue here. (through lack of familiarity
with the issue; I'm not saying there isn't one).

>> +static int rt5640_prepare(struct snd_pcm_substream *substream, +
>> struct snd_soc_dai *dai) +{ +	struct snd_soc_pcm_runtime *rtd =
>> substream->private_data; +	struct snd_soc_codec *codec =
>> rtd->codec; +	struct rt5640_priv *rt5640 =
>> snd_soc_codec_get_drvdata(codec); + +	rt5640->aif_pu = dai->id; +
>> return 0; +}
> 
> This looks like only one DAI can be active at once, shouldn't there
> be some sort of checking for busy here?

I haven't read the spec through in explicit detail, but I didn't see
anything to indicate that only one DAI could be active at once. In
fact the diagrams in the documentation make it look at least somewhat
cross-bar-like.

It looks like rt5640->aif_pu is used solely by set_dmic_clk() to
somehow derive the DMIC CLK from the DAI LRCLK based on which DAI is
actually active. I assume "which DAI is actually active" should be
implemented as "which DAI is routed from the DMICs". I guess this
should be implemented in a very different way then?

> 
>> +	dai_sel = get_sdp_info(codec, dai->id); +	if (dai_sel < 0) { +
>> dev_err(codec->dev, "Failed to get sdp info: %d\n", dai_sel); +
>> return -EINVAL; +	}
> 
> I suspect using dai->base (or just picking a suitable value for
> dai->id even) would be simpler.

So there is something dynamic here; there are 2 physical DAIs on the
chip package, but somehow I think there are 3 digital channels within
the device that can be routed to/from the physical DAIs in various
(sometimes broadcast?) configurations based on the rt5640_dai_iis_map.
Hence, the implementation of get_sdp_info() looks up the value of the
register that configures that routing, and returns data that isn't
static...

I wonder if this all shouldn't be explicitly represented by DAPM
widgets/routes, but the diagrams and text in the documentation aren't
particularly clear on what this third thing is that the code seems to
support:-(

>> +static int rt5640_resume(struct snd_soc_codec *codec) +{ +	int
>> ret = 0 ; + +	codec->cache_sync = 1; +	ret =
>> snd_soc_cache_sync(codec); +	if (ret) { +		dev_err(codec->dev,
>> "Failed to sync cache: %d\n", ret); +		return ret; +	} +
>> rt5640_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> 
> We also sync the cache in the bias management code.

In other words, I should just remove the call to
snd_soc_cache_sync(codec) here, since it's redundant?
