From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 5/5] ASoC: rsnd: dma: use extended audio dmac registers
 when available
Date: Wed, 13 Mar 2019 15:36:49 +0900
Message-ID: <51be4cda-aa39-ce95-e7ef-404d9b02f188@mentor.com>
References: <20190313055811.26135-1-jiada_wang@mentor.com>
 <87h8c7gv73.wl-kuninori.morimoto.gx@renesas.com>
 <87ef7bguqn.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ef7bguqn.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

On 2019/03/13 15:33, Kuninori Morimoto wrote:
> 
> Hi Jiada
> 
>>> Some of SoCs have both basic and extended dmac registers set
>>> basic set only supports busif0 ~ busif3, in order to use
>>> busif4 ~ busif7, extended audio dmac registers need to be used.
>>>
>>> This patch changes to use extended dmac registers set when it is
>>> available in device-tree.
>>>
>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>> ---
>>
>> 1st of all, if you want to post this kind of patch-set,
>> you *should* post driver side patch 1st, and if it was accepted,
>> you need to post SoC side patch. Then, you need to indicate
>> to SoC maintainer which branch/commit should be based.
>> Otherwise, it will 100% breaks git-bisect.
> 
> Grr, orz
> my head was 100% broken.
> This time, your patch doesn't breaks git-bisect.
> I'm so sorry.
> 
right, no problem.
anyway, keep driver change before dts change,
is always a good practice

Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto
> 
