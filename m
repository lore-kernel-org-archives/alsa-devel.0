From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Add clocking option
Date: Fri, 29 Jul 2016 14:08:43 +0300
Message-ID: <51f927cf-def9-8d15-9433-acba44057aa1@ti.com>
References: <1469534710-4006-1-git-send-email-s.mueller-klieser@phytec.de>
 <901be45a-6380-3710-1ee5-e3d192b822e3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 360242684DA
 for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2016 13:08:50 +0200 (CEST)
In-Reply-To: <901be45a-6380-3710-1ee5-e3d192b822e3@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Stefan_M=c3=bcller-Klieser?= <s.mueller-klieser@phytec.de>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/28/16 14:48, Peter Ujfalusi wrote:
>> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio=
.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>> index 46bc982..96d6244 100644
>> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>> @@ -39,6 +39,10 @@ Optional properties:
>>    		 please refer to pinctrl-bindings.txt
>>  - fck_parent : Should contain a valid clock name which will be used as =
parent
>>  	       for the McASP fck
>> +- ahclkx-en: In case the MCASP runs in slave mode, e.g. i2s SCK and WS =
slave,
>> +             we can still provide the MCLK to a codec PLL using the AHC=
LKX
>> +             transmit clock output. This setup can be activated by usin=
g this
>> +             property. Clock master mode remains unaffected.
> =

> _if_ we hack this around in the driver I would rather have something like:
> hclk-source: Source of HCLK internal clock when McASP is clock master.
> With a new DT binding header file with defines:
> =

> /* Source of High-frequency transmit/receive clock */
> #define MCASP_CLK_HCLK_AHCLK		0 /* AHCLKX/R */
> #define MCASP_CLK_HCLK_AUXCLK		1 /* Internal functional clock */
> =

> Basically my old patches for McASP clock selection but w/o the improving =
the
> simple card.
> The only change would be that we ignore the set_sysclk's clk_id parameter=
 and
> use the private clk_id we got via DT when the dir is SND_SOC_CLOCK_IN.
> Oh, and set the PDIR also when AUXCLK is selected for HCLK.
> In the DT you would have for your setup:
> =

> hclk-source =3D MCASP_CLK_HCLK_AUXCLK;
> =

> Or something like that.
> =

> But I think in this way we can work around the simple-card posed limitati=
on a
> bit better, but it is still a questionable workaround.

the other issue is that if we add the DT property, we need to support that =
in
the future, even if we have moved to CCF for clock selection...

> =

> I have attached my local patches for reference.
> =

>>  =

>>  Example:
>>  =

>> diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/p=
latform_data/davinci_asp.h
>> index 85ad68f..c878836 100644
>> --- a/include/linux/platform_data/davinci_asp.h
>> +++ b/include/linux/platform_data/davinci_asp.h
>> @@ -44,6 +44,11 @@ struct davinci_mcasp_pdata {
>>  	int clk_input_pin;
>>  =

>>  	/*
>> +	 * Activate AHCLKX clock output in slave mode.
>> +	 */
>> +	bool ahclkx_en;
>> +
>> +	/*
>>  	 * This flag works when both clock and FS are outputs for the cpu
>>  	 * and makes clock more accurate (FS is not symmetrical and the
>>  	 * clock is very fast.
>> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davin=
ci-mcasp.c
>> index 237dc67..aba888e 100644
>> --- a/sound/soc/davinci/davinci-mcasp.c
>> +++ b/sound/soc/davinci/davinci-mcasp.c
>> @@ -94,6 +94,7 @@ struct davinci_mcasp {
>>  =

>>  	int	sysclk_freq;
>>  	bool	bclk_master;
>> +	bool    ahclkx_en;
>>  =

>>  	/* McASP FIFO related */
>>  	u8	txnumevt;
>> @@ -605,6 +606,10 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_=
dai *dai, int clk_id,
>>  		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
>>  		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
>>  		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
>> +	} else if (mcasp->ahclkx_en) {
>> +		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
> =

> It is safe to set this bit as well.
> =

>> +		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
>> +		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
>>  	} else {
>>  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
>>  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
>> @@ -1610,6 +1615,8 @@ static struct davinci_mcasp_pdata *davinci_mcasp_s=
et_pdata_from_of(
>>  	if (ret >=3D 0)
>>  		pdata->op_mode =3D val;
>>  =

>> +	pdata->ahclkx_en =3D of_property_read_bool(np, "ahclkx-en");
>> +
>>  	ret =3D of_property_read_u32(np, "tdm-slots", &val);
>>  	if (ret >=3D 0) {
>>  		if (val < 2 || val > 32) {
>> @@ -1851,6 +1858,7 @@ static int davinci_mcasp_probe(struct platform_dev=
ice *pdev)
>>  	mcasp->version =3D pdata->version;
>>  	mcasp->txnumevt =3D pdata->txnumevt;
>>  	mcasp->rxnumevt =3D pdata->rxnumevt;
>> +	mcasp->ahclkx_en =3D pdata->ahclkx_en;
>>  =

>>  	mcasp->dev =3D &pdev->dev;
>>  =

>>
> =

> =

> =

> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =



-- =

P=E9ter
