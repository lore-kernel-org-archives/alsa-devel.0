From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add driver for rt5631
Date: Tue, 6 Sep 2011 11:05:05 -0700
Message-ID: <20110906180501.GD2924@opensource.wolfsonmicro.com>
References: <1315305162-18206-1-git-send-email-johnnyhsu@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D456310383B
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 20:05:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315305162-18206-1-git-send-email-johnnyhsu@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johnnyhsu@realtek.com
Cc: alsa-devel@alsa-project.org, flove@realtek.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2011 at 06:32:42PM +0800, johnnyhsu@realtek.com wrote:

>  	switch (reg) {
> -	case RT5631_VENDOR_ID:
> -	case RT5631_VENDOR_ID1:
> -	case RT5631_VENDOR_ID2:
> -		return 0;
> -	default:
> +	case RT5631_RESET:
> +	case RT5631_INT_ST_IRQ_CTRL_2:
> +	case RT5631_INDEX_ADD:
> +	case RT5631_INDEX_DATA:
> +	case RT5631_EQ_CTRL:
>  		return 1;
> +	default:
> +		return 0;

This is an incremental patch against your previous driver, not a full
patch.  You should always send a patches which can be applied against
current kernels.

> -	pr_info("enter %s, syclk=%d\n", __func__, freq);
> +	dev_info(codec->dev, "enter %s, syclk=%d\n", __func__, freq);

This should be a debug level print at most, otherwise you just spam the
console.

>  	if (!freq_in || !freq_out) {
>  		dev_dbg(codec->dev, "PLL disabled\n");
> -		return -EINVAL;
> +		return 0;

I'd expect to see some sort of register write when the PLL is disabled?

>  /**
> - * rt5631_index_reg_show - sysfs file for dumping index registers of 2nd layer
> + * rt5631_index_reg_show: Show private register of rt5631 codec.
> + * @dev: device to query.
> + * @attr: device attribute.
> + * @buf: buffer to display.
> + *
> + * To show private registers which are not changed often by user.
> + * You have to access them through register 0x6a and 0x6c.
>   */
>  static ssize_t rt5631_index_reg_show(struct device *dev,
>  	struct device_attribute *attr, char *buf)

As I've told you repeatedly you should be using the standard facilities
for debug access to registers - you should not open coding this in your
driver.  Once again, ignoring review comments isn't helpful.
