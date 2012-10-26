From: Bo Shen <voice.shen@atmel.com>
Subject: Re: Question about move atmel audio part to DT support
Date: Fri, 26 Oct 2012 09:26:18 +0800
Message-ID: <5089E6BA.2090902@atmel.com>
References: <5080F54F.4000600@atmel.com> <50810CC8.4050009@atmel.com>
 <20121025164008.GQ18814@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A859265085
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 03:27:22 +0200 (CEST)
In-Reply-To: <20121025164008.GQ18814@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, "Lin, JM" <JM.Lin@atmel.com>, "Ferre,
 Nicolas" <Nicolas.FERRE@atmel.com>, linux-sound@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 10/26/2012 0:40, Mark Brown wrote:
> On Fri, Oct 19, 2012 at 04:18:16PM +0800, Bo Shen wrote:
>
>> Cc:
>>     linux-arm-kernel mailing list
>>     devicetree-discuss mailing list
>>     alsa-devel mailing list
>>     linux-sound mailing list
>
> Better to resend for things like this rather than double quote.

Got it. Thanks.

>>
>>>    Atmel audio part has three platform device:
>>>      -> atmel ssc: ssc library (different SOC has different number)
>>>      -> atmel ssc dai: dai for audio
>>>      -> atmel pcm: for pdc or dma transfer (now only support pdc, dma
>>> support will add soon)
>
>>>   In DT support kernel, I don't find any similar case. So, if I want to
>>> keep ssc as library, and use dai to register pcm. Then the dts file will
>>> like:
>
> I'm not seeing anything at all unusual about the above situation - it'd
> help if you could explain what you think is complex here?

This is only a little different with others. We have one more DT node: 
dai in dts file. I am worry about this won't be acceptable.

Anyway, I have sent out the patches. Please help review the code if 
possible.
Thanks.

BRs,
Bo Shen
