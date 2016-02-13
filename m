From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V2 1/3] ASoC: bcm2835: move to use the
	clock framework
Date: Fri, 12 Feb 2016 16:47:22 -0800
Message-ID: <87bn7l3085.fsf@eliezer.anholt.net>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
 <1452602149-5875-2-git-send-email-kernel@martin.sperl.org>
 <87vb6dfjbu.fsf@eliezer.anholt.net> <56B88520.5060606@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865771187211991045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D3C42605FF
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2016 01:47:29 +0100 (CET)
In-Reply-To: <56B88520.5060606@martin.sperl.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Sperl <kernel@martin.sperl.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0865771187211991045==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Martin Sperl <kernel@martin.sperl.org> writes:

> On 28.01.2016 23:08, Eric Anholt wrote:
>> kernel@martin.sperl.org writes:
>>
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>
>>> Since the move to the new clock framework with commit 94cb7f76caa0
>>> ("ARM: bcm2835: Switch to using the new clock driver support.")
>>> this driver was no longer functional as it was manipulating the
>>> clock registers locally without going true the framework.
>>>
>>> This patch moves to use the new clock framework and also
>>> moves away from the hardcoded address offsets for DMA getting
>>> the dma-address directly from the device tree.
>>>
>>> Note that the optimal bclk_ratio selection to avoid jitter
>>> due to the use of fractional dividers, which is in the
>>> current version has been removed, because not all devices
>>> support these non power of 2 sized transfers, which resulted
>>> in lots of (downstream) modules that use:
>>>    snd_soc_dai_set_bclk_ratio(cpu_dai, sample_bits * 2);
>>>
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>> ---
>>>   sound/soc/bcm/bcm2835-i2s.c |  284 ++++++++++---------------------------------
>>>   1 file changed, 64 insertions(+), 220 deletions(-)
>>>
>>> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
>>> index 3303d5f..1c1f221 100644
>>> --- a/sound/soc/bcm/bcm2835-i2s.c
>>> +++ b/sound/soc/bcm/bcm2835-i2s.c
>>
>>> -	dev->i2s_regmap = regmap[0];
>>> -	dev->clk_regmap = regmap[1];
>>> +	/* get the clock */
>>> +	dev->clk_prepared = false;
>>> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(dev->clk)) {
>>> +		dev_err(&pdev->dev, "could not get clk: %ld\n",
>>> +			PTR_ERR(dev->clk));
>>> +		return PTR_ERR(dev->clk);
>>> +	}
>>> +
>>> +	/* Request ioarea */
>>> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	base = devm_ioremap_resource(&pdev->dev, mem);
>>> +	if (IS_ERR(base))
>>> +		return PTR_ERR(base);
>>> +
>>> +	dev->i2s_regmap = devm_regmap_init_mmio(&pdev->dev, base,
>>> +				&bcm2835_regmap_config);
>>> +	if (IS_ERR(dev->i2s_regmap))
>>> +		return PTR_ERR(dev->i2s_regmap);
>>> +
>>> +	/* Set the DMA address - we have to parse DT ourselves */
>>> +	addr = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
>>> +	if (!addr) {
>>> +		dev_err(&pdev->dev, "could not get DMA-register address\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	dma_base = be32_to_cpup(addr);
>>
>> Why aren't we just using mem->start like before?  That seems like an
>> independent change that should be justified on its own.  I'd be ready to
>> ack the patch if that change is removed.
>>
>
> Problem is that we need the VC4 bus-address (0x7e203000),
> which is the actual <reg> value from the device tree without any
> mapping.
>
> Not the ARM MMU visible address mappings that mem->start provides
> (typically 0x20203000 or 0x3f203000 for bcm2836)
>
> Nor the mapped address (base) available in the kernel (typically
> 0xdc......).

Now that I've noticed the BCM2835_VCMMU_SHIFT removal, this makes sense,
but when you put unrelated changes like this together you end up slowing
down the review process on your patches.  Please separate it out into a
separate commit.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWvn0bAAoJELXWKTbR/J7ooLQP/ihVXu/99vLG16wdEHWQOQ5l
mjcVnD1MVl2gRFKoS4qoLSCLcU5YByYeW5icS2WaWDRv8x+ImJQvaJAmCYNQ4Ysr
qLQ+L+2Cd73uoWPQPog5nNOdnthc8XRrZwWF4txKwpmKcVDAxfZmQ4aMuIruqfCo
lc7QDHvzhN0Bf4ViX0L+3eraZndrpDNRO5GnMQFhEOaknaesL2tfElFgXVg1pzHe
1FJ5Nwum2s4iGv7Lgu0u5pTqbdsasNUZ8BwOS57hXW/w6Lv1yJPHSPbLqs9JtEQF
pKGxiVdvM4YbdlCqnm0AEf556/SrX3/zOUU6jmjVMNC+uQO5bsjN71E+mas2E2t6
Y2b/4qHIbtJhrtzVVxp1xar8lJWk6j/XFVBJg7zbEv+1HH2N3YcgHHQiuSwzHD2z
V1GkwYdI6yCApD30xZDqkUL9b6g7Mr77ncmd8u+WIX/CqPiDCcLnJiduZ1+U6iI4
+3cZ3ugaL/akjK0py5lhB5xGcwfLWo3nNKgr71aXJH0Xf0t1dRcK9wGbsb0i3uC5
duMDOlawY1H5hek5sA7VCebMJtkCAS9bpGWe4Qy4pb2u5dAh2tklvsk0FOn6eAQ9
GUeNM2ML4bG+y01EUgPWSGfafTcFO35XTYdGbZKYyErgV/soULt/+Al8ak4N4XpZ
SI/eEeVEidcVesDAZ/Ei
=wJgW
-----END PGP SIGNATURE-----
--=-=-=--

--===============0865771187211991045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0865771187211991045==--
