From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
Date: Fri, 8 Sep 2017 08:14:32 +0200
Message-ID: <03f12e5a-a010-b5ce-4fee-cf726ea4e4ee@invoxia.com>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <20170908054235.GA9603@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908054235.GA9603@Asurada-CZ80>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, lukma@denx.de, caleb@crome.org, max.krummenacher@toradex.com, mpa@pengutronix.de, mail@maciej.szmigiero.name
List-Id: alsa-devel@alsa-project.org


On 08/09/2017 07:42, Nicolin Chen wrote:
> On Thu, Sep 07, 2017 at 10:23:43PM -0700, Nicolin Chen wrote:
>> The set_sysclk() now is used to override the output bit clock rate.
>> But this is not a common way to implement a set_dai_sysclk(). And
>> this creates a problem when a general machine driver (simple-card
>> for example) tries to do set_dai_sysclk() by passing an input clock
>> rate for the baud clock instead of setting the bit clock rate as
>> fsl_ssi driver expected.
>>
>> So this patch solves this problem by firstly removing set_sysclk()
>> since the hw_params() can calculate the bit clock rate. Secondly,
>> in order not to break those TDM use cases which previously might
>> have been using set_sysclk() to override the bit clock rate, this
>> patch changes the driver to override it based on the slot number.
>>
>> The patch also removes an obsolete comment of the dir parameter.
>>
>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Forgot to mention, I think that it's better to wait for a couple of
> Tested-by from those who use the TDM mode of SSI before applying it.
I can check next monday or tuesday.
Arnaud
> Thanks
> Nicolin
