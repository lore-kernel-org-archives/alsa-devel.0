From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 07/12] ASoC: core: Change
 SOC_SINGLE/DOUBLE_VALUE representation
Date: Tue, 4 Oct 2011 16:37:06 +0100
Message-ID: <20111004153705.GP6934@opensource.wolfsonmicro.com>
References: <1317728389-22062-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 100CC10388B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 17:37:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317728389-22062-8-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 02:39:44PM +0300, Peter Ujfalusi wrote:
> SOC_SINGLE/DOUBLE_VALUE is used for mixer controls, where the
> bits are within one register.
> Assign .rreg to be the same as .reg for these types.

Just a general note about your changelogs - the indentation is really
random, normally we have a blank line between paragraphs and have
similar line lengths within paragraphs.

> With this change we can tell if the mixer in question:
> is mono:
>  mc->reg == mc->rreg && mc->shift == mc->rshift

> is stereo, within single register:
>  mc->reg == mc->rreg && mc->shift != mc->rshift

> is stereo, in two registers:
>  mc->reg != mc->rreg && mc->shift == mc->rshift

reg != rreg should be enough.

> +static inline int snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
> +{
> +	if (mc->reg == mc->rreg && mc->shift == mc->rshift)
> +		return 0;
> +	/*
> +	 * mc->reg == mc->rreg && mc->shift != mc->rshift, or
> +	 * mc->reg != mc->rreg && mc->shift == mc->rshift means that the control
> +	 * is stereo (bits in one register or in two registers)
> +	 */
> +	return 1;
> +}

bool.
