From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v6] ASoC: TSCS42xx: Support Tempo
 Semiconductor's TSCS42xx audio CODECs
Date: Mon, 18 Dec 2017 09:50:48 +0000
Message-ID: <20171218095048.e5zwla65f2qqmroj@localhost.localdomain>
References: <20171217035439.5merfdxrjz6amscd@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 975AE2674F1
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 10:50:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171217035439.5merfdxrjz6amscd@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 16, 2017 at 09:54:50PM -0600, Steven Eckhoff wrote:
> Currently there is no support for TSCS42xx audio CODECs.
> 
> Add support for TSCS42xx audio CODECs.
> 
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> ---
> +/* D2S Input Select */
> +static char const * const d2s_input_select_text[] = {
> +	"Line 1", "Line 2"
> +};
> +
> +static const struct soc_enum d2s_input_select_enum =
> +SOC_ENUM_SINGLE(R_INMODE, FB_INMODE_DS, ARRAY_SIZE(d2s_input_select_text),
> +		d2s_input_select_text);
> +
> +static const struct snd_kcontrol_new d2s_input_mux =
> +SOC_DAPM_ENUM("D2S_IN_MUX", d2s_input_select_enum);
> +

Is this unused?

> +#define COEFF_RAM_CTL(xname, xcount, xhandler_get, xhandler_put, xaddr) \
> +{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
> +	.info = bytes_info_ext, \
> +	.get = xhandler_get, .put = xhandler_put, \

Given all users of this macro use coeff_ram_get and coeff_ram_put
might it just be worth sticking them in here?

> +	.private_value = (unsigned long)&(struct coeff_ram_ctl) { \
> +		.addr = xaddr, \
> +		.bytes_ext = {.max = xcount, }, \
> +	} \
> +}

Other than those two very minor comments, looks ok to me so I
think you can add:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
