From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [alsa-devel] [PATCH linux-next v2 9/9] ASoC: rsnd: add busif
 property to dai stream
Date: Tue, 9 Oct 2018 19:40:56 +0900
Message-ID: <c60ffb70-b70e-4764-3d64-d8d5bf67413d@mentor.com>
References: <20181003090136.4556-1-jiada_wang@mentor.com>
 <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
 <557e63d1-dbb7-4232-b53e-4a5499024180@mentor.com>
 <87pnwqpeni.wl-kuninori.morimoto.gx@renesas.com>
 <a5712f6a-a61b-f6c4-4f3d-a6d4a60bcfab@mentor.com>
 <87h8hward4.wl-kuninori.morimoto.gx@renesas.com>
 <ed602ba8-6dc5-005c-3267-47aa378b6c0a@mentor.com>
 <877eirbmcf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877eirbmcf.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

Thanks for your feedback

On 2018/10/09 16:47, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thanks for your feedback
>
>> 1ch:  (tdm_slots < 4) Basic mode, (tdm_slots >= 4) TDM Split mode
>> 2ch: (2 <= tdm_slots < 8) Basic mode, (tdm_slots >= 8) TDM Ex-Split mode
>> 4ch: (4 <= tdm_slots < 8) Basic mode, (tdm_slots >= 8) TDM Ex-Split mode
>> 6ch: (6 <= tdm_slots < 8) Basic mode, (tdm_slots == 8) TDM Extended
>> mode, (8 < tdm_slots) TDM Ex-Split mode
>> 8ch: (6 <= tdm_slots < 8) TDM Extended mode, (8 <= tdm_slots < 16)
>> Basic mode, (tdm_slots == 16) TDM Ex-Split
>> 10ch: TDM Ex-Split mode
>> 16ch: Basic Mode
> Sorry, but I couldn't understand what this table means ?
> For example, what does "1ch" mean ?
> It looks like "1ch playback by TDM"...
sorry for vague explanation,
by "1ch" I mean runtime 1 channel playback
for example:
if user plays 1 channel stream, by checking tdm_slots value,
if it is < 4, then it can't be working in Split mode, so driver will
automatically set SSI to work in Basic mode, otherwise, SSI will
work in TDM Split mode.

>> The reason I added rsnd_ssi_select_busif(io, chan) in rsnd_hw_params()
>> in patch ASoC: rsnd: add busif property to dai stream of v2 patch-set,
>> is because runtime channel is necessary information to determine which
>> BUSIFx to select,
>> (which is mentioned in above)
>> and at this stage (rsnd_hw_params()), all other control settings
>> (register setting, dma address calculation etc)
>> haven't been done, so corresponding dai-link can be considered to be
>> not active at this timing
>> but maybe you have better suggestion when to automatically select BUSIFx
> My image is like this.
>
> 	sound {
> 		compatible = "simple-scu-audio-card or new card";
> 		...
> 		simple-audio-card,convert-channels = <8>;
> 		...
> 		busif0: simple-audio-card,cpu@0 { sound-dai = <&rcar_sound 0>; };
> 		busif1: simple-audio-card,cpu@1 { sound-dai = <&rcar_sound 1>; };
> 		busif2: simple-audio-card,cpu@2 { sound-dai = <&rcar_sound 2>; };
> 		busif3: simple-audio-card,cpu@3 { sound-dai = <&rcar_sound 3>; };
> 		        simple-audio-card,codec { sound-dai = <&xxx>;          };
> 	};
>
> 	rcar_sound {
> 		dai0 { playback = <&ssiu0 ssi0>; }
> 		dai1 { playback = <&ssiu1 ssi0>; }
> 		dai2 { playback = <&ssiu2 ssi0>; }
> 		dai3 { playback = <&ssiu3 ssi0>; }
> 	};
After re-think about BUSIFx selection, I agree with you,
it shouldn't be random, and select it via device-tree, as you have 
already demonstrated
is a good idea

Based on our discussion so far, I think we both agree on the following 
points
1. Driver select SSI mode automatically (by checking tdm_slots, runtime 
channel, etc)
2. Driver parse BUSIFx for each dai-link from device-tree

I will review my v2 patch-set, drop changes violate to above two points


Thanks,
Jiada
> Best regards
> ---
> Kuninori Morimoto
