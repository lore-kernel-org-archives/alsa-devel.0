From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Auto setup TDM when needed. Add
	frame_width	and rx/tx masks to set_tdm_slots.
Date: Tue, 9 Jun 2009 10:10:45 +0100
Message-ID: <20090609091044.GA25490@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244495244.17327.184.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 185C6245AC
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 11:10:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244495244.17327.184.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 06:07:24PM -0300, Daniel Ribeiro wrote:

> Untested, RFC only version of patch.
> (plus some minor copynpaste and whitespace fixes)

> Am I on the right direction? :)

Yes, looks sensible.  I've not checked the driver code at all.

> +++ b/sound/soc/soc-core.c
> @@ -2130,17 +2130,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
>  /**
>   * snd_soc_dai_set_tdm_slot - configure DAI TDM.
>   * @dai: DAI
> - * @mask: DAI specific mask representing used slots.
> + * @tx_mask: DAI specific mask representing TX slots.
> + * @rx_mask: DAI specific mask representing RX slots.

I'd change the wording to be something like "bitmask representing active
slots".

>  {
> -	if (dai->ops->set_sysclk)
> -		return dai->ops->set_tdm_slot(dai, mask, slots);
> +	if (dai->ops->set_tdm_slot)

Should check that there are ops too.

> +		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
> +				slots, frame_width);

It might be nice to provide a default implementation for non-TDM if no
implementation is provided but that could be done later if it makes
sense.  I don't think it'll make much difference, though.

>  int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
>  {
> -	if (dai->ops->set_sysclk)
> +	if (dai->ops->set_tristate)

Separate patch, please.  This is fixed already, though.
