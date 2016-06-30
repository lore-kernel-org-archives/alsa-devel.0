From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: jack connection decision
 with different insertion logic
Date: Thu, 30 Jun 2016 15:51:51 +0800
Message-ID: <5774CF97.4010203@nuvoton.com>
References: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmUhvWrm6ivTs4Ujp2_A8o81A12L0gPUDay0Bv9PVAkbug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 253642654F6
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 09:51:55 +0200 (CEST)
In-Reply-To: <CAOMFOmUhvWrm6ivTs4Ujp2_A8o81A12L0gPUDay0Bv9PVAkbug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, AC30 YHChuang <YHCHuang@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi
On 6/29/2016 11:45 AM, Anatol Pomozov wrote:
> Hi
>
> On Tue, Jun 28, 2016 at 8:20 PM, John Hsu <KCHSU0@nuvoton.com> wrote:
>   
>> The original design only covers the jack insertion logic is active low.
>> Add more condition to cover no matter the logic is active low and high.
>>
>> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
>> ---
>>  sound/soc/codecs/nau8825.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
>> index 3f30e6e..a2f0d03 100644
>> --- a/sound/soc/codecs/nau8825.c
>> +++ b/sound/soc/codecs/nau8825.c
>> @@ -1345,10 +1345,18 @@ EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
>>
>>  static bool nau8825_is_jack_inserted(struct regmap *regmap)
>>  {
>> -       int status;
>> +       int status, jkdet, res;
>>
>>         regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
>> -       return !(status & NAU8825_GPIO2JD1);
>> +       regmap_read(regmap, NAU8825_REG_JACK_DET_CTRL, &jkdet);
>> +
>> +       /* return jack connection status according to jack insertion logic
>> +        * active high or active low.
>> +        */
>> +       res = !(status & NAU8825_GPIO2JD1) * !(jkdet & NAU8825_JACK_POLARITY) +
>> +               (status & NAU8825_GPIO2JD1) * (jkdet & NAU8825_JACK_POLARITY);
>>     
>
> It makes more sense to use a more boolean-like expression. Something like
>
>       return !!(status & NAU8825_GPIO2JD1) == !!(jkdet & NAU8825_JACK_POLARITY);
> (hope I translated expression above correctly)
>
> or even better to introduce readable bool flags:
>       bool active_high = !!(jkdet & NAU8825_JACK_POLARITY);
>       bool is_high = !!(status & NAU8825_GPIO2JD1);
>       return active_high == is_high;
>
>   

Yes, it'll be more readable. I have a question. Why to add !! in
front of bit wise operation? What does it mean?
