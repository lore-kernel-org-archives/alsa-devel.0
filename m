From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [alsa-devel] [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
Date: Wed, 2 Feb 2011 10:27:35 -0600
Message-ID: <0D753D10438DA54287A00B027084269764CEFD4529@AUSP01VMBX24.collaborationhost.net>
References: <1296603653.1504.9.camel@r60e> <20110202075434.GA2445@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110202075434.GA2445@acer>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mika Westerberg <mika.westerberg@iki.fi>, Alexander Sverdlin <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lennert Buytenhek <buytenh@wantstofly.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday, February 02, 2011 12:55 AM, Mika Westerberg wrote:
>>  /*************************************************************************
>> + * EDB93xx SPI peripheral handling
>> + *************************************************************************/
>> +static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
>> +{
>> +	int gpio_nreset;
>> +	int err;
>> +
>> +	if (machine_is_edb9301() || machine_is_edb9302()) {
>> +		gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
>> +	} else if (machine_is_edb9302a() || machine_is_edb9307a()) {
>> +		ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_HONIDE);
>> +		gpio_nreset = EP93XX_GPIO_LINE_DD2;
>> +	} else if (machine_is_edb9315a()) {
>> +		gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = gpio_request(gpio_nreset, spi->modalias);
>> +	if (err)
>> +		return err;
>> +	err = gpio_request(EP93XX_GPIO_LINE_EGPIO6, spi->modalias);
>> +	if (err)
>
> Should you call gpio_free() for gpio_nreset here?

Yes.  If the second gpio_request fails, the first gpio should be freed.

A cleaner way of handling the gpios would be to use gpio_request_array()
and remove the gpio knowledge from the codec driver completely.

Hartley
