From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register
 dai and pcm directly
Date: Tue, 06 Nov 2012 17:32:32 +0800
Message-ID: <5098D930.8030403@atmel.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
 <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
 <20121106084814.GC5044@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A69426172D
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 10:33:20 +0100 (CET)
In-Reply-To: <20121106084814.GC5044@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 11/6/2012 16:48, Mark Brown wrote:
> On Tue, Nov 06, 2012 at 01:57:53PM +0800, Bo Shen wrote:
>
>>   static struct platform_device at91sam9260_ssc_device = {
>> -	.name	= "at91rm9200_ssc",
>> +	.name	= "at91rm9200_ssc_dai",
>>   	.id	= 0,
>>   	.dev	= {
>
> No, this isn't converting things to device tree which presumably is the
> goal here and obviously just doing the rename doesn't accomplish an
> enormous amount.  What I said was that you should instantiate the ASoC
> adaption when the machine driver needs to use them.  You shouldn't even
> need a separate device for this.

Maybe this is not the best solution, but just abstract audio as a 
separate device. The other's still keep as a ssc library.

> Please do look at other platforms with similar hardware and do something
> similar to them.

I take some reference (e.g: freescale, marvell, invidia soc, this RFC 
implement is similar with them), but don't find the similar hardware 
with us. Please help provide the information who's HW is similar with 
us. Thanks.

BRs,
Bo Shen
