From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] [ALSA] ASoC: Add max98925 codec driver
Date: Fri, 16 Jan 2015 22:12:01 +0100
Message-ID: <54B97EA1.10804@metafoo.de>
References: <1421356633-30617-1-git-send-email-yesanishhere@gmail.com>	<54B9465F.2060603@metafoo.de>
 <CABCoZhChrPckmnwZpfwyrirqZHWsMpUfU-HtMi744JCtPbuAQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-013.synserver.de (smtp-out-013.synserver.de
 [212.40.185.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 5227426048D
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:12:00 +0100 (CET)
In-Reply-To: <CABCoZhChrPckmnwZpfwyrirqZHWsMpUfU-HtMi744JCtPbuAQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish <yesanishhere@gmail.com>
Cc: Anish Kumar <anish.kumar@maximintegrated.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

On 01/16/2015 10:00 PM, anish wrote:
> On Fri, Jan 16, 2015 at 9:11 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 01/15/2015 10:17 PM, Anish Kumar wrote:
>>>
>>> From: Anish Kumar <anish.kumar@maximintegrated.com>
>>>
>>> This patch adds the max98925 codec driver.
>>>
>>> Signed-off-by: Anish Kumar <anish.kumar@maximintegrated.com>
>>
>>
>> Please make sure to submit drivers against the latest development version of
>> the ASoC tree
>> (http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=for-next).
>> This has a couple of outdated things and won't even compile.
>
> When i checked on IRC i was told that linux-next is good. Anyway will rebase
> it against this one.

Yes, that was me who said that. But this driver will neither compile against 
linux-next nor asoc/for-next.

Which raises another issue, the driver doesn't add any Makefile or Kconfig 
entries, so even if it would compile you still can compile it.


>>> +static struct snd_soc_codec_driver soc_codec_dev_max98925 = {
>>
>>
>> const
>>
>>> +       .probe            = max98925_probe,
>>> +       .set_bias_level   = max98925_set_bias_level,
>>
>>
>> You'll need at least some kind of DAPM, otherwise you CODEC won't do
>> anything.
>
> Yes this is most important comment. I wrongly mentioned this as codec
> but rather it is just mono Class DG audio amplifier  so it doesn't need
> any dapm connections. Mixer commands is good enough for this and i will
> change this in commit text as well.

Even a amplifier will have a output input and a audio output. Those should 
be properly modeled in DAPM.

>>
>>> +};
>>> +
>>
>> [...]
>>>
>>> +/* There should be a second MAX98925 on the board */
>>> +static struct i2c_board_info max98925_i2c_second[] = {
>>> +       {
>>> +               I2C_BOARD_INFO("max98925R", 0x32),
>>> +       }
>>> +};
>>> +
>>> +struct i2c_client *add_second_device(int busnum)
>>> +{
>>> +       struct i2c_client *i2c = NULL;
>>> +       struct i2c_adapter *adapter;
>>> +
>>> +       adapter = i2c_get_adapter(busnum);
>>> +       if (adapter != NULL)
>>> +               i2c = i2c_new_device(adapter, max98925_i2c_second);
>>> +
>>> +       return i2c;
>>> +}
>>
>> [...]
>>>
>>> +       /* Check for second MAX98925 */
>>> +       i2c_r = add_second_device(2);
>>
>>
>> If there are two devices instantiate them properly and create two CODEC
>> devices, not some kind of hackery like this.
>
> Ok but this is just audio amplifier do we  still need that?

Yes! There is no conceptual difference between a CODEC or an amplifier 
driver at that level.

- Lars
