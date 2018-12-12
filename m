From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs35l36: Add support for
 Cirrus CS35L36 Amplifier
Date: Wed, 12 Dec 2018 17:07:41 +0000
Message-ID: <20181212170741.GS16508@imbe.wolfsonmicro.main>
References: <1544130287-7303-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CEDF3267C35
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 18:07:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1544130287-7303-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 06, 2018 at 03:04:46PM -0600, James Schulman wrote:
> Add driver support for Cirrus Logic CS35L36 boosted
> speaker amplifier
> 
> Signed-off-by: James Schulman <james.schulman@cirrus.com>
> ---

Again just a couple of very minor nit picks from me.

> +static int cs35l36_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				  unsigned int freq, int dir)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct cs35l36_private *cs35l36 =
> +			snd_soc_component_get_drvdata(component);
> +	int fs1, fs2, reg;
> +
> +	if (freq > CS35L36_FS_NOM_6MHZ) {
> +		fs1 = CS35L36_FS1_DEFAULT_VAL;
> +		fs2 = CS35L36_FS2_DEFAULT_VAL;
> +	} else {
> +		fs1 = 3 * ((CS35L36_FS_NOM_6MHZ * 4 + freq - 1) / freq) + 4;
> +		fs2 = 5 * ((CS35L36_FS_NOM_6MHZ * 4 + freq - 1) / freq) + 4;
> +	}
> +
> +	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
> +			CS35L36_TEST_UNLOCK1);
> +	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
> +			CS35L36_TEST_UNLOCK2);
> +
> +	regmap_read(cs35l36->regmap, CS35L36_TST_FS_MON0, &reg);
> +	reg &= ~(CS35L36_FS1_WINDOW_MASK | CS35L36_FS2_WINDOW_MASK);
> +	reg |= ((fs1 & CS35L36_FS1_WINDOW_MASK) |
> +		(fs2 << CS35L36_FS2_WINDOW_SHIFT & CS35L36_FS2_WINDOW_MASK));
> +	regmap_write(cs35l36->regmap, CS35L36_TST_FS_MON0, reg);

This is just open coding update_bits probably better to just use
update_bits.

> +
> +	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
> +			CS35L36_TEST_LOCK1);
> +	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
> +			CS35L36_TEST_LOCK2);
> +	return 0;
> +}
> +

> +typedef char CS35L36_MAX_NUM_REGS[__LINE__];

Not sure I am the greatest fan of this, is it perhaps just worth
combining the tables file and the regular file? Then you don't
need any fancyness.

Thanks,
Charles
