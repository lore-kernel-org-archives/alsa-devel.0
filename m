From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
Date: Fri, 8 Sep 2017 10:41:56 +0200
Message-ID: <0844824e-ae66-2337-8d58-7bd835f564a2@denx.de>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <20170908054235.GA9603@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908054235.GA9603@Asurada-CZ80>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org, max.krummenacher@toradex.com, arnaud.mouiche@invoxia.com, mpa@pengutronix.de, mail@maciej.szmigiero.name
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

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
> 
> Forgot to mention, I think that it's better to wait for a couple of
> Tested-by from those who use the TDM mode of SSI before applying it.

Although, I'm not the PCM user, I've tested your patch and it works :-)

Tested-by: Łukasz Majewski <lukma@denx.de>

Test HW: imx6q + tfa9879 codec

> 
> Thanks
> Nicolin
> 


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
