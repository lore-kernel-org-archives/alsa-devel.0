From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 16:29:50 +0000
Message-ID: <1294676990.11031.10.camel@dplaptop.localdomain>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFC9824515
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 17:30:09 +0100 (CET)
In-Reply-To: <1294675292-6289-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 10:01 -0600, Timur Tabi wrote:
> -	reg = cs4270_read_reg_cache(codec, CS4270_MUTE);
> +	reg = snd_soc_read(codec, CS4270_MUTE);
>  	reg &= ~CS4270_MUTE_AUTO;
> -	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
> +	ret = snd_soc_write(codec, CS4270_MUTE, reg);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "i2c write failed\n");
>  		return ret;
> @@ -582,9 +521,9 @@ static int cs4270_probe(struct snd_soc_codec *codec)
>  	 * re-enabled it by using the controls.
>  	 */
>  
> -	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
> +	reg = snd_soc_read(codec, CS4270_TRANS);
>  	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
> -	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
> +	ret = snd_soc_write(codec, CS4270_TRANS, reg);

It'd be better to use snd_soc_update_bits() for all these.

Thanks,
Dimitris
