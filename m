From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v2 6/6] ASoC: rsnd: add avb clocks
Date: Tue, 4 Dec 2018 17:35:31 +0900
Message-ID: <64d0b9f1-ca23-425e-68d1-31ce9d6ab168@mentor.com>
References: <20181203112427.18324-1-jiada_wang@mentor.com>
 <87o9a22hjt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87o9a22hjt.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

Thanks for your comments,
I will address your findings in next version

Thanks,
Jiada

On 2018/12/04 10:52, Kuninori Morimoto wrote:
> Hi Jiada
>
>> There are AVB Counter Clocks in ADG, each clock has 12bits integral
>> and 8 bits fractional dividers which operates with S0D1ϕ clock.
>>
>> This patch registers 8 AVB Counter Clocks when clock-cells of
>> rcar_sound node is 2,
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> (snip)
>> +struct clk_avb {
>> +	struct clk_hw hw;
>> +	unsigned int idx;
>> +	struct rsnd_mod *mod;
>> +	/* lock reg access */
>> +	spinlock_t *lock;
>> +};
>> +
>> +#define to_clk_avb(_hw) container_of(_hw, struct clk_avb, hw)
> I like "hw_to_avb()"
>
>> +static struct clk *rsnd_adg_clk_src_twocell_get(struct of_phandle_args *clkspec,
>> +						void *data)
>> +{
>> +	unsigned int clkidx = clkspec->args[1];
>> +	struct rsnd_adg *adg = data;
>> +	const char *type;
>> +	struct clk *clk;
>> +
>> +	switch (clkspec->args[0]) {
>> +	case ADG_FIX:
>> +		type = "fixed";
>> +		if (clkidx >= CLKOUTMAX) {
>> +			pr_err("Invalid %s clock index %u\n", type,
>> +			       clkidx);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		clk = adg->clkout[clkidx];
>> +		break;
>> +	case ADG_AVB:
>> +		type = "avb";
>> +		if (clkidx >= AVB_CLK_NUM) {
>> +			pr_err("Invalid %s clock index %u\n", type,
>> +			       clkidx);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		clk = adg->clkavb[clkidx];
>> +		break;
>> +	default:
>> +		pr_err("Invalid ADG clock type %u\n", clkspec->args[0]);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return clk;
>> +}
> In this function
> 1) I don't think you need to use "char *type".
> 2) If you use "clkidx = clkspec->args[1]", having same name for "clkspec->args[0]"
>     is readable.
> 3) please use dev_err() instad of pr_err()
>     I think data can be priv, and you can use rsnd_priv_to_adg(), rsnd_priv_to_dev()
>
>> +static void clk_avb_div_write(struct rsnd_mod *mod, u32 data, int idx)
> (snip)
>> +static u32 clk_avb_div_read(struct rsnd_mod *mod, int idx)
> To reduce confusion, and be more redable code,
> I think these function can be
>
> 	clk_avb_div_write(struct rsnd_adg *adg, u32 data);
> 	clk_avb_div_read(struct rsnd_adg *adg);
>
>> +static int clk_avb_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			    unsigned long parent_rate)
>> +{
>> +	struct clk_avb *avb = to_clk_avb(hw);
>> +	unsigned int div = clk_avb_calc_div(rate, parent_rate);
>> +	u32 val;
>> +
>> +	val = clk_avb_div_read(avb->mod, avb->idx) & ~AVB_DIV_MASK;
>> +	clk_avb_div_write(avb->mod, val | div, avb->idx);
>> +
>> +	return 0;
>> +}
> Why do we need to care about ~AVB_DIV_MASK area ?
> These are 0 Reserved, I think.
>
>> +static const struct clk_ops clk_avb_ops = {
>> +	.enable = clk_avb_enable,
>> +	.disable = clk_avb_disable,
>> +	.is_enabled = clk_avb_is_enabled,
>> +	.recalc_rate = clk_avb_recalc_rate,
>> +	.round_rate = clk_avb_round_rate,
>> +	.set_rate = clk_avb_set_rate,
>> +};
> This is not a big deal, but I like tab aligned ops
>
>> +static struct clk *clk_register_avb(struct device *dev, struct rsnd_mod *mod,
>> +				    unsigned int id, spinlock_t *lock)
>> +{
>> +	struct clk_init_data init;
>> +	struct clk_avb *avb;
>> +	struct clk *clk;
>> +	char name[AVB_CLK_NAME_SIZE];
>> +	const char *parent_name = ADG_CLK_NAME;
>> +
>> +	avb = devm_kzalloc(dev, sizeof(*avb), GFP_KERNEL);
>> +	if (!avb)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	snprintf(name, AVB_CLK_NAME_SIZE, "%s%u", AVB_CLK_NAME, id);
>> +
>> +	avb->idx = id;
>> +	avb->lock = lock;
>> +	avb->mod = mod;
>> +
>> +	/* Register the clock. */
>> +	init.name = name;
>> +	init.ops = &clk_avb_ops;
>> +	init.flags = CLK_IS_BASIC;
>> +	init.parent_names = &parent_name;
>> +	init.num_parents = 1;
>> +
>> +	avb->hw.init = &init;
>> +
>> +	/* init DIV to a valid state */
>> +	clk_avb_div_write(avb->mod, avb->idx, AVB_MAX_DIV);
> Please check parameter, I think you want to do is
>
> 	- clk_avb_div_write(avb->mod, avb->idx, AVB_MAX_DIV);
> 	+ clk_avb_div_write(avb->mod, AVB_MAX_DIV, avb->idx);
>
> Best regards
> ---
> Kuninori Morimoto
