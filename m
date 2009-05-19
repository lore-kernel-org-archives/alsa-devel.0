From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/3 - RESEND] ASoC: TWL4030: Add control
	for selecting codec operation mode
Date: Tue, 19 May 2009 08:26:37 +0300
Message-ID: <200905190826.37962.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E8403@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 537DB245FC
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 07:26:46 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E8403@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 18 May 2009 19:52:55 ext Lopez Cruz, Misael wrote:
> Add a control for selecting the codec operation mode. TWL4030 codec
> has two modes:
> - Option 1. Audio only (4 audio DACs)
> - Option 2. Voice/Audio (2 audio DACs and voice ADC/DAC)
>
> Control is restricted when a stream is ongoing, since codec's
> operation mode cannot be changed on-the-fly.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---

> +int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
...
> +	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
> +		;
> +	if (ucontrol->value.enumerated.item[0] > e->max - 1)
> +		return -EINVAL;

I would still switch these... I know that this is the sequence also in soc-
core.c in the snd_soc_put_enum_double function.

If it is OK for Mark, than

Acked-by: Peter Ujflausi <peter.ujfalusi@nokia.com>
