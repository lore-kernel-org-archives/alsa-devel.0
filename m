From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] ASoC: adau17x1: Implemented
 safeload support
Date: Mon, 13 Aug 2018 12:44:55 +0200
Message-ID: <92897f5f-7bc6-305e-522b-b966b3659b78@metafoo.de>
References: <20180813073359.3374-1-robertr@axis.com>
 <20180813073359.3374-2-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AA082673A0
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2018 12:44:55 +0200 (CEST)
In-Reply-To: <20180813073359.3374-2-robertr@axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Rosengren <robert.rosengren@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Rosengren <robertr@axis.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

On 08/13/2018 09:33 AM, Robert Rosengren wrote:
> From: Danny Smith <dannys@axis.com>
> 
> Safeload support has been implemented which is used
> when updating for instance filter parameters using
> alsa controls. Without safeload support audio can
> become distorted during update.
> 
> Signed-off-by: Danny Smith <dannys@axis.com>
> Signed-off-by: Robert Rosengren <robertr@axis.com>

Hi,

Thanks for implementing this. Some comments inline.

[...]
> +static int adau17x1_safeload(struct sigmadsp *sigmadsp, unsigned int addr,
> +	const uint8_t bytes[], size_t len)
> +{
> +	uint8_t buf[4];
> +	unsigned int i;
> +	int ret;
> +
> +	/* target address is offset by 1 */
> +	unsigned int addr_offset = addr - 1;
> +
> +	/* write safeload addresses */
> +	for (i = 0; i < len / 4; i++) {
> +		memcpy(buf, bytes + i * 4, 4);

Is this memcpy really required or could we just write bytes directly in a
single regmap_raw_write()? I believe the adau17x1 will auto increment the
register addresses.

And I suppose we also need to handle the case when len is not a multiple of 4.

> +		ret = regmap_raw_write(sigmadsp->control_data,
> +			ADAU17X1_SAFELOAD_DATA(i), buf, 4);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* write target address */
> +	buf[0] = (addr_offset >> 24) & 0xff;
> +	buf[1] = (addr_offset >> 16) & 0xff;
> +	buf[2] = (addr_offset >> 8) & 0xff;
> +	buf[3] = (addr_offset) & 0xff;

This could be slightly simplified using

	put_unaligend_be32(addr_offset, buf);

> +	ret = regmap_raw_write(sigmadsp->control_data,
> +		ADAU17X1_SAFELOAD_TARGET_ADDRESS, buf, 4);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* write nbr of words to trigger address */
> +	buf[0] = 0x00;
> +	buf[1] = 0x00;
> +	buf[2] = 0x00;
> +	buf[3] = i & 0xff;
Same here I guess

> +	ret = regmap_raw_write(sigmadsp->control_data,
> +		ADAU17X1_SAFELOAD_TRIGGER, buf, 4);
> +
> +	return ret;
> +}
