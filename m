From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Don't check dummy dai in
	soc_dapm_dai_stream_event
Date: Fri, 03 Jul 2015 10:04:43 +0200
Message-ID: <5596421B.7080400@metafoo.de>
References: <1434512468-25555-1-git-send-email-shengjiu.wang@freescale.com>
 <5595031F.2090608@metafoo.de> <55950A51.2060605@metafoo.de>
 <20150702093255.GA17950@shlinux2> <55951E53.6000501@metafoo.de>
 <20150703065409.GA17206@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-003.synserver.de (smtp-out-003.synserver.de
 [212.40.185.3]) by alsa0.perex.cz (Postfix) with ESMTP id DA88026040E
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 10:04:48 +0200 (CEST)
In-Reply-To: <20150703065409.GA17206@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 07/03/2015 08:54 AM, Shengjiu Wang wrote:
> On Thu, Jul 02, 2015 at 01:19:47PM +0200, Lars-Peter Clausen wrote:
>> On 07/02/2015 11:32 AM, Shengjiu Wang wrote:
>>> On Thu, Jul 02, 2015 at 11:54:25AM +0200, Lars-Peter Clausen wrote:
>>>> On 07/02/2015 11:23 AM, Lars-Peter Clausen wrote:
>>>>> On 06/17/2015 05:41 AM, Shengjiu Wang wrote:
>>>>>> Dummy dai can be used by multiple sound card. But it only belong to one
>>>>>> card's dapm list. If another card use it, there will be dapm_assert_locked
>>>>>> warning.
>>>>>>
>>>>>> [   20.015782] WARNING: CPU: 1 PID: 661 at sound/soc/soc-dapm.c:124
>>>>>> dapm_assert_locked.isra.36+0x4c/0x58()
>>>>>> [   20.025249] Modules linked in:
>>>>>> [   20.028349] CPU: 1 PID: 661 Comm: aplay Not tainted
>>>>>> 4.1.0-rc6-next-20150605-00004-gaee05d8-dirty #92
>>>>>> [   20.037528] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>>>>>> [   20.044110] Backtrace:
>>>>>> [   20.046614] [<80012e00>] (dump_backtrace) from [<80012fa0>]
>>>>>> (show_stack+0x18/0x1c)
>>>>>> [   20.054229]  r6:809e8060 r5:00000000 r4:00000000 r3:00000000
>>>>>> [   20.060002] [<80012f88>] (show_stack) from [<807a0f74>]
>>>>>> (dump_stack+0x80/0x9c)
>>>>>> [   20.067293] [<807a0ef4>] (dump_stack) from [<8002b144>]
>>>>>> (warn_slowpath_common+0x7c/0xb4)
>>>>>> [   20.075427]  r5:0000007c r4:00000000
>>>>>> [   20.079065] [<8002b0c8>] (warn_slowpath_common) from [<8002b1a0>]
>>>>>> (warn_slowpath_null+0x24/0x2c)
>>>>>> [   20.087898]  r8:00000001 r7:88007c28 r6:ed94a680 r5:809e83e4 r4:ed83d6c0
>>>>>> [   20.094747] [<8002b17c>] (warn_slowpath_null) from [<8058403c>]
>>>>>> (dapm_assert_locked.isra.36+0x4c/0x58)
>>>>>> [   20.104101] [<80583ff0>] (dapm_assert_locked.isra.36) from [<805842ec>]
>>>>>> (dapm_mark_dirty+0x64/0xa4)
>>>>>> [   20.113165] [<80584288>] (dapm_mark_dirty) from [<805853a8>]
>>>>>> (soc_dapm_dai_stream_event.isra.42+0x30/0xc8)
>>>>>> [   20.122863]  r8:ed9b5dbc r7:00000000 r6:00000001 r5:00000001 r4:ed83d6c0
>>>>>> [   20.129706] [<80585378>] (soc_dapm_dai_stream_event.isra.42) from
>>>>>> [<80587e28>] (snd_soc_dapm_stream_event+0x78/0xa0)
>>>>>> [   20.140264]  r5:ee2ee62c r4:00000001
>>>>>> [   20.143918] [<80587db0>] (snd_soc_dapm_stream_event) from [<8058957c>]
>>>>>> (soc_pcm_prepare+0x138/0x21c)
>>>>>> [   20.153058]  r8:ed8d9480 r7:00000000 r6:ed9b0e00 r5:00000001
>>>>>> r4:ee2ee62c r3:00000000
>>>>>> ...
>>>>>>
>>>>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
>>>>>> ---
>>>>>>   sound/soc/soc-dapm.c |    3 +++
>>>>>>   1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>>>>>> index aa327c9..b618541 100644
>>>>>> --- a/sound/soc/soc-dapm.c
>>>>>> +++ b/sound/soc/soc-dapm.c
>>>>>> @@ -3856,6 +3856,9 @@ static void soc_dapm_dai_stream_event(struct
>>>>>> snd_soc_dai *dai, int stream,
>>>>>>   {
>>>>>>       struct snd_soc_dapm_widget *w;
>>>>>>
>>>>>> +    if (snd_soc_dai_is_dummy(dai))
>>>>>> +        return;
>>>>>> +
>>>>>
>>>>> While this will silence the lockdep warning the underlying issue is still
>>>>> there. When the dummy DAI is used in multiple cards for each card a set of
>>>>> widgets is created for the DAI which is then stored in
>>>>> dai->playback/capture_widget. This means the second card will overwrite the
>>>>> widgets created by the first card.
>>>>>
>>>>> The correct way to fix this is to not create any widgets for the dummy DAI.
>>>>> This also means you can remove the dummy check in
>>>>> dapm_connect_dai_link_widgets().
>>>>
>>>> Btw. this should affect more than just DAPM, if you have the dummy
>>>> DAI in multiple cards the dummy CODEC ends up getting attached to
>>>> both cards which should result in the component and CODEC list
>>>> getting corrupted.
>>>
>>> Why you think the codec list should be corrupted? I didn't meet this
>>> corruption. I check the codec list, there is only one "snd-soc-dummy" in it.
>>
>> I guess what avoids this is that we check component->probed and
>> don't probe again if it already has been probed. But there are still
>> assumptions all-throughout ASoC that assume that a CODEC is only
>> part of exactly one card. The dummy CODEC will need special handling
>> to make sure that it doesn't get added to any card.
>>
>> - Lars
>>
> I think that don't probe component which is dummy may reach the target. In
> this case we don't need to check the dummy dai in snd_soc_dapm_new_dai_widgets.

Yes.
