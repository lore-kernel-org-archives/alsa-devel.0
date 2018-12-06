From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
Date: Thu, 6 Dec 2018 16:32:23 +0900
Message-ID: <590d14cc-4d08-514a-6edc-2b4bad3c1993@mentor.com>
References: <20181205074932.28098-1-jiada_wang@mentor.com>
 <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
 <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
 <878t13jx6y.wl-kuninori.morimoto.gx@renesas.com>
 <011cfbf7-70d0-a649-52de-1689cdb5a10b@mentor.com>
 <871s6vjkaz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s6vjkaz.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


On 2018/12/06 14:38, Kuninori Morimoto wrote:
> Hi Jiada
>
>> SMSTPCR922 controls input of two clocks "S0D1ϕ" and "S0D4ϕ",
> Ahh, OK I could check it via Block diagram.
> But it is "Module stop" for these, anyway.
> "Module stop" and "S0D1ϕ/S0D4ϕ" are completely different clocks.
Yes, "module stop" is different from "S0D1ϕ/S0D4ϕ",
both clk_i and avb_counter8's parent clock is same "module stop" clock,
which is <&cpg CPG_MOD 922>, it is a shared gate clock between
avb_counter8 and clk_i


>
>> "S0D4ϕ" is input to BRGA,
>> "S0D1ϕ" is input to avb_counter8
> It seems we need to update "clk_i" portion first for this purpose.
> Then, we need to consider about Gen2 vs Gen3, etc, etc...
> It seems we can't keep patch simple...
Yes, I know it's not simple, so I want to discuss with you,
how we can proceed on this topic,
by adding avb_counter8, rcar audio can support arbitrary clock rate,
which is a desired feature, IMO

>>> 3rd, we need to create new clock/handler for
>>> avb_counter8 / audio_clk_div3 / avb_div8 for "internal" purpose,
>>> and need to create avb_adg_syn[] clock for "external" purpose for EAVB/IF.
>>> Your code is creating / registering adg->clkavb[],
>>> but it is for avb_counter8 in my understanding.
>>> We don't need to register it as formal clock IMO.
>> I agree, besides avb_counter8 there are other clocks which need to be
>> added as you have mentioned,
>> in this patch-set, I only added avb_counter8, because I want to keep
>> the patch-set simple,
>> other clocks can be added later.
> No, No, No.
> avb_counter8 is just "internal" clock, and one of
> parent clock for avb_div8 which is needed for avb_adg_syn[].
> We need to control/register is avb_adg_syn[], not avb_counter8.
>
> Your approach on this patch is very "Quick-Hack".
> I have no objection for out-of-tree patches.
> But, "Quick-Hack approach with changing formal DT on upstream"
> is nightmare.
>
>> avb_counter8 is registered as formal clock is because,
>> there is use case that EAVB-IF may use avb_div8, and avb_counter8 is
>> input to avb_div8.
>> if keeps avb_counter8 'internal', I am not sure how EAVB-IF can set
>> clock rate for avb_counter8
> EAVB/IF driver setups avb_adg_syn[].
> Then, ADG considers/searchs avb_counter8/avb_div8/audio_clk_div3
> settings internally.
> Don't control avb_counter8 directly from EAVB.
OK, I think I understand your point,
which avb_counter8 / avb_div8/audio_clk_div3 need to be used,
only need to be considered by adg internally.

Thanks,
Jiada

> Best regards
> ---
> Kuninori Morimoto
