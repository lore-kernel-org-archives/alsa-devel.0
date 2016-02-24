From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: Modify power management and
 add interrupt wakeup
Date: Thu, 25 Feb 2016 07:09:47 +0800
Message-ID: <56CE383B.4050306@nuvoton.com>
References: <1452237082-12767-1-git-send-email-KCHSU0@nuvoton.com>
 <20160108131358.GO6588@sirena.org.uk>
 <d255aac675d4418c87af834edc567021@NTHCML01B.nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C5342606F6
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 00:09:52 +0100 (CET)
In-Reply-To: <d255aac675d4418c87af834edc567021@NTHCML01B.nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,
This patch has cancel and only submit enhance codec suspend and resume 
patch.
Please review the following link for the patch. Many thanks.

http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/102924.html
[alsa-devel] [PATCH] ASoC: nau8825: fix interrupt fails and unstable 
after resume

On 1/8/2016 9:14 PM, Mark Brown wrote:
> On Fri, Jan 08, 2016 at 03:11:22PM +0800, John Hsu wrote:
>   
>> 1. Enhance codec suspend and resume sequence 2. Add interrupt wakeup 
>> function
>>     
>
> If this is two or more separate changes you should be sending two or more separate patches.  You also need a better changelog which describes what the patch is supposed to do, in what way is suspend and resume enhanced for example?
>
>   
>> +/**
>> + * nau8825_init_wakeup - set wakeup capability for codec
>> + *
>> + * @codec:  codec device component
>> + *
>> + * After this function done, codec can support system wakeup by button.
>> + */
>> +int nau8825_init_wakeup(struct snd_soc_codec *codec) {
>> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
>> +
>> +	device_init_wakeup(nau8825->dev, true);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nau8825_init_wakeup);
>>     
>
> You need a bit more explanation as to what's going on here.  Why is this not something the driver just does or if this should be done elsewhere why do we need the wrapper function?
>
>   
>> +int nau8825_irq_wakeup(struct snd_soc_codec *codec, int on) {
>> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
>>     
>
> Same thing here, this looks like an unclear interface.
>   
