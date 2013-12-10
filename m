From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH V2] ASoC: add RT286 CODEC driver
Date: Tue, 10 Dec 2013 07:59:05 +0200
Message-ID: <CALq1K=KaJ9+7ZvOP3Jx9W2Z+2E520B5qeJhM0oJrK4wKeq3Hhw@mail.gmail.com>
References: <1386164488-32227-1-git-send-email-bardliao@realtek.com>
 <201312100141.rBA1fv6q001271@rtits1.realtek.com>
 <1121E117AD4ECE49880A389A396215BB939A8268C6@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D224265138
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 06:59:27 +0100 (CET)
Received: by mail-ve0-f173.google.com with SMTP id oz11so4477758veb.18
 for <alsa-devel@alsa-project.org>; Mon, 09 Dec 2013 21:59:26 -0800 (PST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB939A8268C6@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 10, 2013 at 4:46 AM, Bard Liao <bardliao@realtek.com> wrote:
>> -----Original Message-----
>> From: Leon Romanovsky [mailto:leon@leon.nu]
>> Sent: Wednesday, December 04, 2013 10:37 PM
>> To: Bard Liao
>> Cc: Mark Brown; Liam Girdwood; Oder Chiou; alsa-devel@alsa-project.org;
>> Flove
>> Subject: Re: [alsa-devel] [PATCH V2] ASoC: add RT286 CODEC driver
>>
>> On Wed, Dec 4, 2013 at 3:41 PM,  <bardliao@realtek.com> wrote:
>> > From: Bard Liao <bardliao@realtek.com>
>> >
>> > This patch adds the ALC286 codec driver.
>> >
>> > Signed-off-by: Bard Liao <bardliao@realtek.com>
>> >
>>
>> Please add change log while you are sending verX patch.
>
> Please see the change log as below.
> * Add platform data to determine if combo jack and/or IRQ is using or not.
> * Implement rt286_hw_read/write in regmap.
> * Configure codec in runtime instead of in probe.
> * Other minor changes (coding style, remove version control, remove empty functions, share code ...)
>
> Should I send another patch with these change log?
I don't think so, just remember it for future submissions.

>>
>>
>> > +
>> > +static unsigned int rt286_reg_cache[TOTAL_NODE_ID + 1] = {
>> You don't need TOTAL_NODE_ID + 1 in array declaration.
>
> Without "TOTAL_NODE_ID + 1", I should always set [NODE_ID_MIXER_IN2] = 0x0000, right?
> Ie. Assign the latest array item a value.
>
>>
>> > +       [NODE_ID_DAC_OUT1] = 0x7f7f,
>> > +       [NODE_ID_DAC_OUT2] = 0x7f7f,
>> > +       [NODE_ID_SPDIF] = 0x0000,
>> > +       [NODE_ID_ADC_IN1] = 0x4343,
>> > +       [NODE_ID_ADC_IN2] = 0x4343,
>> > +       [NODE_ID_MIC1] = 0x0000,
>> > +       [NODE_ID_MIXER_IN] = 0x000b,
>> > +       [NODE_ID_MIXER_OUT1] = 0x0002,
>> > +       [NODE_ID_MIXER_OUT2] = 0x0000,
>> > +       [NODE_ID_SPK_OUT] = 0x0000,
>> > +       [NODE_ID_HP_OUT] = 0x0000,
>> > +       [NODE_ID_MIXER_IN1] = 0x0000,
>> > +       [NODE_ID_MIXER_IN2] = 0x0000,
>> > +};
1. static variable is always initialized to 0x0 by C standard.
2. It is better to initialize all cache registers in one place
(rt286_reg_cache), including zero values. In such case TOTAL_NODE_ID +
1 is redundant.


>
> Thanks.
>



-- 
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
