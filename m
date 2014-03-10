From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe
	code.
Date: Mon, 10 Mar 2014 07:57:38 +0100
Message-ID: <531D6262.3070201@metafoo.de>
References: <1393814545-15002-1-git-send-email-Li.Xiubo@freescale.com>
 <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
 <20140303045952.GO2411@sirena.org.uk>
 <5bc570ec866541a68df5813ffbe3168e@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140304043603.GI2411@sirena.org.uk>
 <0dbba1debfd149a6a5e3985349a95793@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id CB117264F02
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 07:56:58 +0100 (CET)
In-Reply-To: <0dbba1debfd149a6a5e3985349a95793@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 04:51 AM, Li.Xiubo@freescale.com wrote:
>> Subject: Re: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe code.
>>
>> On Mon, Mar 03, 2014 at 07:24:36AM +0000, Li.Xiubo@freescale.com wrote:
>>
>>>>>   	/* Default to using ALC auto offset calibration mode. */
>>>>>   	snd_soc_update_bits(codec, DA7213_ALC_CTRL1,
>>>>>   			    DA7213_ALC_CALIB_MODE_MAN, 0);
>>
>>>> This one will fail.
>>
>>> Sorry, I'm not very understand why will this fail ? Before the ASoC probe,
>>> the ASoC core will set the I/O.
>>> :)
>>
>> OK, that's now been refactored.
>
> @Mark, @Lars,
>
> Has there any other problems about this patch series? And this I had tested on
> our Vybrid-Twr board based on SGTL5000 codec and SAI drivers. If not, I can
> continue with my second patches series about " Remove set_cache_io entirely from
> ASoC probe".
>
> Thanks very much.
>


It looks good to me.
