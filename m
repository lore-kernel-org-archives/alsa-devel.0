From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] davinci: da8xx/omap-l1xx: match codec_name
	with i2c ids
Date: Mon, 24 Jan 2011 15:09:21 -0800
Message-ID: <87r5c15272.fsf@ti.com>
References: <1295619896-5498-1-git-send-email-sudhakar.raj@ti.com>
	<1295620708.3348.233.camel@odin> <8739oh6h5i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 63133103896
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 00:09:31 +0100 (CET)
Received: by mail-pv0-f181.google.com with SMTP id 12so1228306pvg.26
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 15:09:24 -0800 (PST)
In-Reply-To: <8739oh6h5i.fsf@ti.com> (Kevin Hilman's message of "Mon, 24 Jan
	2011 15:00:57 -0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, alsa-devel@alsa-project.org, dansharon@nanometrics.ca, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Kevin Hilman <khilman@ti.com> writes:

> Liam Girdwood <lrg@slimlogic.co.uk> writes:
>
>> On Fri, 2011-01-21 at 19:54 +0530, Rajashekhara, Sudhakar wrote:
>>> The codec_name entry for da8xx evm in sound/soc/davinci/davinci-evm.c
>>> is not matching with the i2c ids in the board file. Without this fix the
>>> soundcard does not get detected on da850/omap-l138/am18x evm.
>>> 
>>> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
>>> Tested-by: Dan Sharon <dansharon@nanometrics.ca>
>>> ---
>>> This patch applies to Linus's kernel tree.
>>> 
>>>  sound/soc/davinci/davinci-evm.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>> 
>>> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
>>> index 0c2d6ba..b36f0b3 100644
>>> --- a/sound/soc/davinci/davinci-evm.c
>>> +++ b/sound/soc/davinci/davinci-evm.c
>>> @@ -223,7 +223,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
>>>  	.stream_name = "AIC3X",
>>>  	.cpu_dai_name= "davinci-mcasp.0",
>>>  	.codec_dai_name = "tlv320aic3x-hifi",
>>> -	.codec_name = "tlv320aic3x-codec.0-001a",
>>> +	.codec_name = "tlv320aic3x-codec.1-0018",
>>>  	.platform_name = "davinci-pcm-audio",
>>>  	.init = evm_aic3x_init,
>>>  	.ops = &evm_ops,
>>
>> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
>
> Liam,
>
> I'm assuming you'll merge this one via the ASoC tree?
>

On second thought, these should probably merge for .38-rc3.

If you're OK with it, I can merge this and the platform fix together for
.38-rc3.

Kevin
