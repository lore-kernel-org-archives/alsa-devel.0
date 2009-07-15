From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: MAX9877: add MAX9877 amp driver
Date: Wed, 15 Jul 2009 10:22:40 +0900
Message-ID: <4A5D2F60.9090101@samsung.com>
References: <4A5C2829.50402@samsung.com>
	<20090714095426.GA16295@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A4FF244DC
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 03:22:50 +0200 (CEST)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KMS0006VUHTPC@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 10:22:41 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KMS00I88UHTL5@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 10:22:41 +0900 (KST)
In-reply-to: <20090714095426.GA16295@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 7/14/2009 6:54 PM, Mark Brown wrote:
> On Tue, Jul 14, 2009 at 03:39:37PM +0900, Joonyoung Shim wrote:
> 
> Overall this looks great, thanks.  Clearly it's not an ideal approach
> but it gets the job done and it can be adapted to use core features as
> they're added.
> 

Thank you for your review.

> A couple of relatively nitpicky issues below:
> 
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -188,3 +188,7 @@ config SND_SOC_WM9712
>>  
>>  config SND_SOC_WM9713
>>  	tristate
>> +
>> +# Amp
>> +config SND_SOC_MAX9877
>> +	tristate
> 
> I'd add it to SND_SOC_ALL_CODECS too - while it's not strictly a CODEC
> the point of the Kconfig option is to get build coverage and this driver
> will benefit from that as much as others.
> 

OK, i will add it.

>> +static const char *max9877_osc_mode[] = {
>> +	"1176KHz",
>> +	"1100KHz",
>> +	"700KHz",
>> +};
> 
> Would this be better as platform data for the device?
> 

I'm not sure about this, but if this would be platform data, does it
means the osc_mode should not be changed through a control?

>> +static const struct snd_kcontrol_new max9877_controls[] = {
>> +	SOC_SINGLE_EXT_TLV("MAX9877 Amp HP Left Playback Volume",
>> +			MAX9877_HPL_VOLUME, 0, 31, 0,
>> +			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
>> +	SOC_SINGLE_EXT_TLV("MAX9877 Amp HP Right Playback Volume",
>> +			MAX9877_HPR_VOLUME, 0, 31, 0,
>> +			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
> 
> Ideally these would be a SOC_DOUBLE_EXT_TLV() but we don't have that yet
> - would you mind sending a patch for that?
> 

I think these would be a SOC_DOUBLE_R_EXT_TLV() because HP Left register 
and HP Right register are different. If this is right, i will send a 
patch for this.

>> +/* This function is called from ASoC machine driver */
>> +int max9877_add_controls(struct snd_soc_codec *codec)
>> +{
>> +	return snd_soc_add_controls(codec, max9877_controls,
>> +			ARRAY_SIZE(max9877_controls));
>> +}
>> +
> 
> This should have an EXPORT_SYMBOL_GPL() to allow it to be used from
> machine drivers which are built modular.
> 

OK, i will add it.
