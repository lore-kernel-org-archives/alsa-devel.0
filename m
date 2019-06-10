From: AS50 KCHsu0 <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: fix fake interruption when
	booting
Date: Mon, 10 Jun 2019 11:33:52 +0800
Message-ID: <b35cc100-5faa-9eb6-6218-5046d2a0afa2@nuvoton.com>
References: <20190610021229.12005-1-KCHSU0@nuvoton.com>
 <20190610024029.12193-1-KCHSU0@nuvoton.com>
 <CAFv8NwLHkP9zrHNbinz=8D9Gsf6Z8oTGN=CE-BX__72EhE6=Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 3A7BBF896CE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2019 05:34:03 +0200 (CEST)
In-Reply-To: <CAFv8NwLHkP9zrHNbinz=8D9Gsf6Z8oTGN=CE-BX__72EhE6=Dg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <alsa-devel@alsa-project.org>, WTLI@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>, Yu-hsuan Hsu <yuhsuan@google.com>, YHCHuang@nuvoton.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


On 6/10/2019 10:56 AM, Cheng-yi Chiang wrote:
> On Mon, Jun 10, 2019 at 10:40 AM John Hsu <KCHSU0@nuvoton.com> wrote:
>> There is no pull-up resistor at IRQ line where it connects from
>> the codec to SoC. When booting, the signal of IRQ pin will keep low
>> which makes the SoC invoke the ISR repeatedly because the IRQ is
>> registered trigger low. It will not stop until the codec sets up
>> the interruption and pulls the signal high. In the patch,
>> nau8825 will internally pull the signal to high at booting in case
>> the fake interrupts happen.
>>
>> What steps will reproduce the problem?
>> Boot device
>> What is the expected output?
>> A lot of interrupts without any events
>> What do you see instead?
>> The fake interrupts are gone
>> How frequently does this problem reproduce?
>> Always
>>
> I guess you don't need these descriptions.


Yes, I add it by referring to the comment of ChromeOS.

I can remove it.


>> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
> Please add my Tested-by.
> Thanks!


OK, I will add it.


>> ---
>>   sound/soc/codecs/nau8825.c | 4 ++++
>>   sound/soc/codecs/nau8825.h | 2 ++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
>> index 47e65cf99879..83ec841f7865 100644
>> --- a/sound/soc/codecs/nau8825.c
>> +++ b/sound/soc/codecs/nau8825.c
>> @@ -1881,6 +1881,10 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
>>                  NAU8825_JACK_EJECT_DEBOUNCE_MASK,
>>                  nau8825->jack_eject_debounce << NAU8825_JACK_EJECT_DEBOUNCE_SFT);
>>
>> +       /* Pull up IRQ pin */
>> +       regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
>> +               NAU8825_IRQ_PIN_PULLUP | NAU8825_IRQ_PIN_PULL_EN,
>> +               NAU8825_IRQ_PIN_PULLUP | NAU8825_IRQ_PIN_PULL_EN);
>>          /* Mask unneeded IRQs: 1 - disable, 0 - enable */
>>          regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK, 0x7ff, 0x7ff);
>>
>> diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
>> index f6074c618569..3f41897ed3f6 100644
>> --- a/sound/soc/codecs/nau8825.h
>> +++ b/sound/soc/codecs/nau8825.h
>> @@ -171,6 +171,8 @@
>>   #define NAU8825_JACK_POLARITY  (1 << 1) /* 0 - active low, 1 - active high */
>>
>>   /* INTERRUPT_MASK (0xf) */
>> +#define NAU8825_IRQ_PIN_PULLUP (1 << 14)
>> +#define NAU8825_IRQ_PIN_PULL_EN (1 << 13)
>>   #define NAU8825_IRQ_OUTPUT_EN (1 << 11)
>>   #define NAU8825_IRQ_HEADSET_COMPLETE_EN (1 << 10)
>>   #define NAU8825_IRQ_RMS_EN (1 << 8)
>> --
>> 2.21.0
>>


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
