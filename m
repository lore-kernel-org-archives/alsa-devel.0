From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/8] sound:asoc:spdif_in: Add spdif IN
	support
Date: Tue, 20 Mar 2012 15:55:27 +0000
Message-ID: <20120320155526.GG3445@opensource.wolfsonmicro.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<568712727a6488bb0c16cf9031fa498059974e6e.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8662838102416147331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AB6C1042D2
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 16:55:31 +0100 (CET)
In-Reply-To: <568712727a6488bb0c16cf9031fa498059974e6e.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, spear-devel@list.st.com, Vipin Kumar <vipin.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============8662838102416147331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Content-Disposition: inline


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 05:03:48PM +0530, Rajeev Kumar wrote:

This looks good, a few minor things but almost good to go.

> This patch implements the spdif IN driver for ST peripheral

S/PDIF.

> +	if (irq_status & SPDIF_IRQ_FIFOWRITE)
> +		pr_err("spdif in: fifo write error\n");
> +	if (irq_status & SPDIF_IRQ_EMPTYFIFOREAD)
> +		pr_err("spdif in: empty fifo read error\n");
> +	if (irq_status & SPDIF_IRQ_FIFOFULL)
> +		pr_err("spdif in: fifo full error\n");
> +	if (irq_status & SPDIF_IRQ_OUTOFRANGE)
> +		pr_err("spdif in: out of range error\n");

dev_err().

> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				resource_size(res), pdev->name)) {
> +		dev_warn(&pdev->dev, "Failed to get memory resourse\n");
> +		return -ENOENT;
> +	}
> +
> +	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
> +	if (!host) {
> +		dev_warn(&pdev->dev, "kzalloc fail\n");
> +		return -ENOMEM;
> +	}

Good to see this - this is the sort of stuff I was looking for in the
I2S driver.

> +	host->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(host->clk))
> +		return PTR_ERR(host->clk);

> +	pdata = dev_get_platdata(&pdev->dev);

Should really be error checking in case you didn't get your platform
data.

> +	ret = devm_request_irq(&pdev->dev, host->irq, spdif_in_irq, 0,
> +			"spdif-in", host);
> +	if (ret) {

I'm really not enthused about the idea of using devm_request_irq() here
- what steps are you taking to make sure that the IRQ can't possibly
fire after you've started tearing down the device.  In general it's
relatively hard to use devm_request_irq() safely.

> +#define SPDIF_IN_DEV_PM_OPS NULL

Just remove this if it's unconditionally empty.

> +static int __init spdif_in_init(void)

module_platform_driver().

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKhnAAoJEBus8iNuMP3dxfIP/jih9EW68QTrYmjdVaWsF/wE
4gh6ZuV1CUqiYCKztxp65OnnQQaWEgmVWdbf0ADwR2Aicb2TiRYvBj41cvOV7JWZ
hst/5v4mnW2pTZ41Hd8v++8rdTRWU4iqofDqa1TNI+DJp0T6GZVcakLUUBwOcq+g
wYKaxZcW2fnjJRX3Ayo8BppR54uwWQYWicoVWA2TJ1TXJmeFxIzKSlS/3Ow+NM1E
OIENtEQgIAtVXtP7nYmYg5ChAqYsyVloAWdQMXGsVjyqmigzVvd0GcvmlbKnMzT5
PE/4CxFdIKa1IL9aX3dVL8BjAPYL5TpM1K4a7dtGLFOR4hG9HO5IQA6S/4Yjcm2c
8EP2GyzC9jp0+GMZRnMeoVfJmz2qLX+1UK/HL+xMGQh0A1S6c6s8zg1fF2ghaklc
f0ZqE4/u2pqxMeqBX9uVehtB7OXt4dZa2910jpwKvQXdTyiPGL2ZK+PyLhr6TgOX
gSuiUszykNQ+Jol2xH10VRlAqRlprvKQ/PJcwBOT7Flc96+kbftK1ogIaLhrnur5
TTFYT/pHSJrjgN3cZ33EIKbLcZ9C5JEflXJGhsMxQRKWHv6tvf65054wj4aTGgva
8j6GGEv4tF0tdVkw/bav3f+jn3ppIN3AtS0CoIR+r7TxXffVih7xPnJYXGsyCJlt
Re5xIk5lCoaqZzqbR6x8
=BaiF
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--

--===============8662838102416147331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8662838102416147331==--
