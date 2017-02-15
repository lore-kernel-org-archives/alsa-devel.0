From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v1 3/3] ASoC: zx-96p22: add zte's aud96p22
 controller driver
Date: Wed, 15 Feb 2017 11:24:25 +0000
Message-ID: <20170215112425.GC30007@localhost.localdomain>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
 <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D8E261740
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 12:23:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, tiwai@suse.com, srinivas.kandagatla@linaro.org, bardliao@realtek.com, lars@metafoo.de, axel.lin@ingics.com, Paul.Handrigan@cirrus.com, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, devicetree@vger.kernel.org, arnd@arndb.de, yesanishhere@gmail.com, xie.baoyou@zte.com.cn, nh6z@nh6z.net, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oder_chiou@realtek.com, linux-kernel@vger.kernel.org, petr@barix.com, broonie@kernel.org, jun.nie@linaro.org, shawnguo@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 15, 2017 at 06:55:10PM +0800, Baoyou Xie wrote:
> This patch adds aud96p22 controller driver for zte's SoC family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
<snip>
> +static int zx_aud96p22_i2c_write(struct i2c_client *i2c_client,
> +				 const void *data, size_t count)
> +{
> +	int xfer;
> +
> +	xfer = i2c_master_send(i2c_client, data, count);
> +	if (xfer == count)
> +		return 0;
> +	else if (xfer < 0)
> +		return xfer;
> +	else
> +		return -EIO;
> +}
> +
> +static int zx_aud96p22_i2c_read(struct i2c_client *i2c_client,
> +				unsigned char addr)
> +{
> +	int xfer;
> +
> +	xfer = i2c_smbus_read_word_data(i2c_client, addr);
> +	if (xfer < 0)
> +		dev_warn(&i2c_client->dev, "transfer error %d\n", xfer);
> +
> +	return xfer;
> +}
> +

Is there any reason this isn't using regmap? It looks like it
should be, have a look at any of the other mainline CODECs for an
example.

Thanks,
Charles
