From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Tue, 29 May 2018 06:34:52 +0200
Message-ID: <1159debf-8082-b9c7-842b-39b9086161ff@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
 <8760375jsj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 773E4267196
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 06:34:53 +0200 (CEST)
In-Reply-To: <8760375jsj.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tuesday, May 29, 2018 03:35 AM, Kuninori Morimoto wrote:
>> The simple-card driver currently hard-codes the clk_id parameter in
>> snd_soc_dai_set_sysclk() to 0. Make this configrable for both CPU and
>> codec dai sub-nodes.
>>
>> This still has the limitation that only one clk_id can be configured, but it
>> should help some more platforms to use simple-card in favor to a more
>> specific machine driver.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>   Documentation/devicetree/bindings/sound/simple-card.txt |  3 +++
>>   include/sound/simple_card_utils.h                       |  1 +
>>   sound/soc/generic/simple-card-utils.c                   |  3 +++
>>   sound/soc/generic/simple-card.c                         | 10 ++++++----
>>   4 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
>> index a4c72d09cd45..c8d268285a9e 100644
>> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
>> @@ -94,6 +94,9 @@ Optional CPU/CODEC subnodes properties:
>>   - system-clock-direction-out		: specifies clock direction as 'out' on
>>   					  initialization. It is useful for some aCPUs with
>>   					  fixed clocks.
>> +- system-clock-index			: index of the system clock to use when
>> +					  the mclk frequency is on the CPU/CODEC
>> +					  DAI. Defaults to 0.
> 
> I'm not a DT guy, but I think DT doesn't want to have index directly ?
> I don't know detail, but I guess DT want to have like
> 
> 	system-mclock = <&xxxx 3>

Hmm, no. That index doesn't describe a particular output of a clock 
phandle but an internal detail of the CPU or CODEC DAI on the other end. 
Most DAIs will use 0 here, like your code had it before.

The DAI can be both a producer and a consumer of a clock, depending on 
the audio clocking setup, and these details are not exposed in DT.



Thanks,
Daniel
