From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 5/8] ASoC: Ux500: Add MSP I2S-driver
Date: Fri, 27 Apr 2012 10:45:59 +0200
Message-ID: <4F9A5CC7.2040508@stericsson.com>
References: <1334914386-27482-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423182911.GU8318@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E39110BE2F
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 10:46:40 +0200 (CEST)
In-Reply-To: <20120423182911.GU8318@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/23/2012 08:29 PM, Mark Brown wrote:

> On Fri, Apr 20, 2012 at 11:33:06AM +0200, Ola Lilja wrote:
> 
>> Add driver for running I2S with the MSP-block.
> 
> This depends on the change for the debug print function.  Otherwise
> there's a bunch of relatively minor stuff but overall this looks
> generally good.


Good to hear!

> 
>> +static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	int ret = 0;
>> +	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
>> +
>> +	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
>> +		snd_soc_stream_str(substream));
>> +
>> +	/* Don't enable regulator if it's MSP1/3 */
> 
> Why not?


Other blocks take this regulator and when the driver needs to go into low-power
mode this other block will disable the regulator. However, for now I think we
can safely remove this special-case and take the regulator even for MSP1/3.

> 
>> +static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
>> +				struct snd_soc_dai *dai)
>> +{
> 
>> +	if (drvdata->reg_enabled) {
>> +		ret = regulator_disable(drvdata->reg_vape);
>> +		if (ret < 0)
>> +			dev_err(dai->dev,
>> +				"%s: ERROR: Failed to disable regulator (%d)!\n",
>> +				__func__, ret);
>> +		drvdata->reg_enabled = 0;
>> +	}
> 
> This looks like the driver is going to get confused with bidirectional
> audio - if one direction stops then it'll turn the regulator off.


Yes, will fix this.

> 
>> +	/* Don't enable regulator if it's MSP1/3 */
>> +	if (!drvdata->reg_enabled && (drvdata->msp->id != MSP_1_I2S_CONTROLLER)
>> +		&& (drvdata->msp->id != MSP_3_I2S_CONTROLLER)) {
> 
> This seems confused, you're enabling in multiple places...
> 


Indeed. Will fix.

>> +static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
>> +				struct snd_pcm_hw_params *params,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	unsigned int mask, slots_active;
>> +	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
>> +
>> +	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n",
>> +			__func__, dai->id, snd_soc_stream_str(substream));
>> +
>> +	switch (drvdata->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +	case SND_SOC_DAIFMT_I2S:
>> +		if (params_channels(params) != 2) {
>> +			dev_err(dai->dev,
>> +				"%s: Error: I2S requires ch = 2 (ch = %d)!\n",
>> +				__func__, params_channels(params));
>> +			return -EINVAL;
>> +		}
> 
> Should really set up constraints for this, though in principle format
> can change at runtime (though it rarely does).  Perhaps we should do
> something special if the configuration happens on init...


OK, I will try to rewrite these checks to use constraints instead.

> 
>> +		if (params_channels(params) != slots_active) {
>> +			dev_err(dai->dev,
>> +				"%s: Error: Channels to slots mismatch (ch = %d, slots = %d)!\n",
>> +				__func__, params_channels(params),
>> +				slots_active);
>> +			return -EINVAL;
>> +		}
> 
> Similarly here.
> 
>> +	drvdata->reg_vape = regulator_get(NULL, "v-ape");
>> +	if (IS_ERR(drvdata->reg_vape)) {
> 
> No, this should be using the struct device.  Regulators should always
> be requested in the context of their consumer.  You could use
> devm_regulator_get() too (there's a clock one too, but only in -next).


OK, I'll look into that.

> 
>> +	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp, platform_data);
>> +	if (!drvdata->msp) {
> 
> Should be no need to cast away from void.


OK, will change.

> 
>> +
>> +	ux500_msp_i2s_cleanup_msp(pdev, drvdata->msp);
>> +	devm_kfree(&pdev->dev, drvdata);
> 
> You're missing the point of devm_ here! :)


Ah! =)
