From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next 10/10] ASoC: rsnd: Add kctrl to configure dai's
 busif
Date: Tue, 2 Oct 2018 17:19:55 +0900
Message-ID: <abc5762e-8128-3a58-46e4-ca0f0072e7c0@mentor.com>
References: <20180927051229.18080-1-jiada_wang@mentor.com>
 <87h8iatqrn.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h8iatqrn.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, twischer@de.adit-jv.com, dragos_tarcatu@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/09/28 9:29, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your patch
>
>> ssi0, ssi1, ssi2, ssi3, ssi4 and ssi9 have busif0 to busif7,
>> currently only busif0 is used by all ssi.
>> But tdm split and tdm ex-split mode, which require busif1 to
>> busif7.
>>
>> This patch adds kctrl in ssi for dai-link, to make it possible
>> to configure the busif used by each dai-link.
>> Also adds rsnd_dma_addr_update() interface to make it possible
>> to update dma data address when there is change in condition
>> of dai connection.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> Do we really need to select BUSIF number by kctrl ??
> In other words, does *all* user need to know detail of SSI BUSIF connection ?
> I think it should be selected automatically somehow.
after some reconsideration, I think selection of BUSIF can be done 
automatically.

BUSIF other than 0 is only necessary when SSI works in TDM 
Split/Ex-Split mode.
but currently rcar audio doesn't support these modes,
I am planning in v2 update, add a dummy BUSIF selection function,
which only selects busif0 for now

Thanks,
Jiada
