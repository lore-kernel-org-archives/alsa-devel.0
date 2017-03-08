From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: bcm_2835: Simplify mono guard by
 returning error on mono
Date: Wed, 8 Mar 2017 22:35:52 +1100
Message-ID: <328ff79b-0014-16d0-b222-e61cf6a3d860@flatmax.org>
References: <1488970734-6596-1-git-send-email-flatmax@flatmax.org>
 <d86dad56-3291-6ac0-5109-eeb83e7f1215@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta22p.bpe.bigpond.com (nsstlmta22p.bpe.bigpond.com
 [203.38.21.22]) by alsa0.perex.cz (Postfix) with ESMTP id 3416726690D
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:36:01 +0100 (CET)
In-Reply-To: <d86dad56-3291-6ac0-5109-eeb83e7f1215@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Kauer <florian.kauer@koalo.de>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Florian Meier <florian.meier@koalo.de>, broonie@kernel.org, phil@raspberrypi.org, hias@horus.com, ckeepax@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 08/03/17 22:13, Florian Kauer wrote:
> I don't really see why it simplifies the code.
> Actually, the number of lines is even increased by this patch.
> And the logic will fail if ever params_channels would return something
> larger than 2.
>
>


The actual lines of code (excluding comments has shrunk from 9 to 5) - 
there is no point arguing that. The clock cycle count to execute the 
same logic has been reduced.

The channel count can't be larger then 2 because channels_min = 
channels_max = 2, check the bcm2835_i2s.c file.

If channel count is ever != 2 then someone is intentionally hacking - 
that is beyond our control and in the interests of the hackers - good 
luck to them.

This patch simplifies the code base and is entirely equivalent to the 
code it is replacing.
This patch is still entirely I2S compliant.

Is anyone interested in reducing code complexity ?

Matt


>
> On 08.03.2017 11:58, Matt Flax wrote:
>> This patch simplifies the bcm2835_i2s.c code when the driver returns
>> error on mono channel requests. It does this by testing for mono
>> instead of using a switch statement to test for stereo.
>>
>> The bcm2835_i2s driver can only work in stereo mode. Whilst leaving
>> the driver entirel compliant with the I2S protocol, it simplifies the
>> code by removing a few redundant lines of code.
>>
>> Signed-off-by: Matt Flax <flatmax@flatmax.org>
>> ---
>>  sound/soc/bcm/bcm2835-i2s.c | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
>> index 6ba2049..1e6a1da 100644
>> --- a/sound/soc/bcm/bcm2835-i2s.c
>> +++ b/sound/soc/bcm/bcm2835-i2s.c
>> @@ -310,15 +310,16 @@ static int bcm2835_i2s_hw_params(struct 
>> snd_pcm_substream *substream,
>>      ch1pos = data_delay;
>>      ch2pos = bclk_ratio / 2 + data_delay;
>>
>> -    switch (params_channels(params)) {
>> -    case 2:
>> -        format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>> -        format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>> -        format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
>> -        break;
>> -    default:
>> +    /* C
>> +     * Check we aren't setting channel 2 on a mono stream.
>> +     * We currently only support stereo
>> +     */
>> +    if (params_channels(params) == 1)
>>          return -EINVAL;
>> -    }
>> +
>> +    format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>> +    format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>> +    format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
>>
>>      /*
>>       * Set format for both streams.
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
