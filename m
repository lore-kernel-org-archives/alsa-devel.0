From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] Add support for tlv320aic3007 to
	tlv320aic3x codec.
Date: Fri, 20 Aug 2010 12:08:41 +0100
Message-ID: <20100820110840.GF13668@rakim.wolfsonmicro.main>
References: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 724CC1038E2
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 13:08:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 12:47:53PM +0800, Randolph Chung wrote:
> This patch adds support for the tlv320aic3007 codec to the tlv320aic3x
> driver.
> 
> The tlv320aic3007 is similar to the aic31, but has an additional class-D
> speaker amp. The speaker amp control register overlaps with the mono
> output register of other codecs in this family, so we add logic to
> identify the actual codec being registered to set things up accordingly.

Applied but...

> +static const struct i2c_device_id aic3x_i2c_id[] = {
> +	[AIC3X_MODEL_3X] = { "tlv320aic3x", 0 },
> +	[AIC3X_MODEL_33] = { "tlv320aic33", 0 },
> +	[AIC3X_MODEL_3007] = { "tlv320aic3007", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);

The more idiomatic way to write this stuff is:

	{ "tlv320aic3007", AIC3X_MODEL_3007 }

and then look at the id field in the probe() function.  Could you send a
followup patch doing that, please?
