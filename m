From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Wed, 10 Aug 2016 08:57:28 -0500
Message-ID: <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk> <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk> <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BE6FE265A7F
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 15:57:31 +0200 (CEST)
In-Reply-To: <20160729163933.GJ10376@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: mark.rutland@arm.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, robh+dt@kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

On 7/29/16 11:39 AM, Mark Brown wrote:
> On Fri, Jul 29, 2016 at 09:45:21PM +0530, Vinod Koul wrote:
>
>> Yeah I am not aware of any plan to have clks on x86. For audio we are not
>> going to use much. ACPI and controller w/ firmware does the job.
>
>> I have added Darren, he oversee platform things so might know if clocks
>> would be there in future..
>
> Not having controllable clocks is fine but as we've discussed before
> you're going to need to represent the clocks that are there with fixed
> clocks instantiated through whatever you use to enumerate boards.  We
> don't want to have to special case x86 all the time in CODEC drivers.

Without going into a debate on x86 v. the clock API or the merits of a 
patch that has already been applied, I am pretty confused on who's 
supposed to manage the mclk between the machine and codec driver.

If you go back to this specific patch for the rt5659 audio codec, the 
simplified code reads as:

static int rt5659_set_bias_level()
[snip]
	case SND_SOC_BIAS_STANDBY:
		if (dapm->bias_level == SND_SOC_BIAS_OFF) {
			ret = clk_prepare_enable(rt5659->mclk);

So on a DAPM transition the clock is enabled. Fine.
What's not clear here is that the codec driver doesn't know what rates 
are supported by the SOC/chipset. The machine driver is typically the 
one doing calls such as

ret = snd_soc_dai_set_pll(codec_dai, 0,
			RT5640_PLL1_S_MCLK,
			19200000,
			params_rate(params) * 512);

it's as if this patch assumes the mclk is a single rate? if this was a 
generic solution then the codec driver would need to set the rates as 
well and its internal PLL/divider settings.

In addition, the machine driver can implement a platform clock control 
with things like

static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
	{"Headphone", NULL, "Platform Clock"},
	{"Headset Mic", NULL, "Platform Clock"},
	{"Internal Mic", NULL, "Platform Clock"},
	{"Speaker", NULL, "Platform Clock"},


static int platform_clock_control(struct snd_soc_dapm_widget *w,
				  struct snd_kcontrol *k, int  event)

	if (SND_SOC_DAPM_EVENT_ON(event)) {
		ret = clk_prepare_enable(priv->mclk);
		ret = snd_soc_dai_set_sysclk(codec_dai,
					RT5640_SCLK_S_PLL1,
					48000 * 512,
					SND_SOC_CLOCK_IN);
	} else {
		/*
		 * Set codec clock source to internal clock before
		 * turning off the platform clock. Codec needs clock
		 * for Jack detection and button press
		 */
		ret = snd_soc_dai_set_sysclk(codec_dai,
					RT5640_SCLK_S_RCCLK,
				         0,
					SND_SOC_CLOCK_IN);
		clk_disable_unprepare(priv->mclk);


so the summary is that we have two ways of doing the same thing - 
turning the mclk on when it's needed - and I wonder if doing this in the 
codec is really the right solution? Again this is not a question on the 
merits of the clk API/framework but whether we can have a single point 
of control instead of two pieces of code doing the same thing in two 
drivers.
If I am missing something I am all ears.
