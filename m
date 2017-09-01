From: Li Xu <li.xu@cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs43130: Add support for
	CS43130 codec
Date: Fri, 1 Sep 2017 09:57:43 -0500
Message-ID: <be12429f-814f-4b4a-9b82-d69fc9bd64cc@EX3.ad.cirrus.com>
References: <a71e2771-fec4-4d15-af95-ec15e010fd0c@EX3.ad.cirrus.com>
 <20170901104345.4syoutjbskq75v55@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D2838266998
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 16:57:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170901104345.4syoutjbskq75v55@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, brian.austin@cirrus.com, tiwai@suse.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 01, 2017 at 11:43:45AM +0100, Mark Brown wrote:
> On Fri, Aug 18, 2017 at 11:00:19AM -0500, Li Xu wrote:
> 
> This is mostly good, there's a couple of stylistic issues - please send
> incremental patches fixing them:
> 
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_1,
> > +				   CS43130_MUTE_MASK, 0);
> > +		switch (cs43130->dev_id) {
> > +		case CS43130_CHIP_ID:
> > +		case CS4399_CHIP_ID:
> > +			regmap_multi_reg_write(cs43130->regmap, unmute_seq,
> > +					       ARRAY_SIZE(unmute_seq));
> > +		}
> 
> I'd expect to see break statements at the end of each case in a switch -
> this is an issue throughout the driver.

OK.  Will add "break" keyword to all cases, unless case is already returning.

> 
> > +	if (cs43130->reset_gpio)
> > +		gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
> 
> The check here isn't needed and isn't done elsewhere in the driver, best
> to remove it for consistency.

OK.  Will remove check.
