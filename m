From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Regression with .set_bias_level in pcm512x?
Date: Wed, 14 Jan 2015 10:40:11 +0100
Message-ID: <54B6397B.5040702@metafoo.de>
References: <0bea1026e90a46769a573470a3efc935@EMAIL.axentia.se>
 <54B622D8.90008@metafoo.de>
 <680a9f057a904cef8c06c631f233025e@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-243.synserver.de (smtp-out-243.synserver.de
 [212.40.185.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 6252C2608EA
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 10:40:11 +0100 (CET)
In-Reply-To: <680a9f057a904cef8c06c631f233025e@EMAIL.axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/14/2015 10:31 AM, Peter Rosin wrote:
> Hi!
>
> Lars-Peter Clausen wrote:
>> On 01/13/2015 11:49 PM, Peter Rosin wrote:
>>> Hi!
>>>
>>> I'm working on adding support for DAIFMT_CBM_CFM and
>> DAIFMT_CBM_CFS to
>>> pcm512x, and it works nicely in the 3.10 kernel + Atmel-patches were I
>>> have developed the code. Now I'm trying to forward-port it and test it
>>> on
>>> 3.18 + other-Atmel-patches in preparation for submission. However,
>>> there seems to be a regression in that the (pre-existing)
>>> pcm512x_set_bias_level callback is never called in the 3.18 version.
>>>
>>> I see that there has been some core work on set_bias_level, and
>>> suspect it has something to do with dapm and components, but I think
>>> someone else will find the problem much quicker than I am able to.
>>>
>>> I have feebly tried to revert 0bd2ac3dae74ee25c5ea171cb572731c7a89c248
>>> and 68f831c2724ab72c0088471b2ed1dc99e81948ef, but that didn't help.
>>> That also seems a bit backwards. So, what needs to be done in the
>>> pcm512x driver to have set_bias_level called?
>>
>> It's unlikely that these commits have anything to do with it.
>
> Agreed, I just wanted to show that I at least did try some things...
>
>> I think it is more likely that the DAPM state (for whatever reason) never
>> actually changes. Check the state of the DAPM context and all the widgets in
>> /sys/kernel/debug/asoc/your_card/... and compare their state when the
>> system is idle to when it should not be idle.
>
> There is indeed something strange going on with dapm. When things should be
> active, I have this (for the non-working 3.18 variant):
>
> $ cat codec\:pcm512x.0-004c/dapm/Playback \
> 	codec\:pcm512x.0-004c/dapm/DACL \
> 	codec\:pcm512x.0-004c/dapm/OUTL \
> 	dapm/DAC1 \
> 	dapm/MIX1 \
> 	dapm/MUX1 \
> 	dapm/OUT1 \
> 	dapm/AIFINL
> Playback: Off  in 1 out 0
>   stream Playback active
>   out "static" "DACR"
>   out "static" "DACL"
> DACL: Off  in 1 out 0
>   in  "static" "Playback"
>   out "static" "OUTL"
> OUTL: Off  in 1 out 0
>   in  "static" "DACL"
>   out "static" "DAC1"
> DAC1: Off  in 1 out 0
>   in  "static" "OUTL"
>   out "static" "MIX1"
> MIX1: Off  in 1 out 0
>   in  "static" "DAC1"
>   out "Mixer" "MUX1"
> MUX1: Off  in 1 out 0
>   in  "Mixer" "MIX1"
>   out "static" "OUT1"
> OUT1: Off  in 1 out 0
>   in  "static" "MUX1"
> AIFINL: Off  in 0 out 0
>   stream Playback inactive
>
> When things are inactive, all "in 1" change to "in 0", and the top "stream Playback"
> change to "inactive".
>
> bias_level of both the card and the codec are "Off", regardless.
>
> For reference, I have attached my current card driver, which is given this:
>
> 	sound {
> 		compatible = "axentia,asoc-linea-tse850";
>
> 		axentia,model = "TSE850 @ Linea";
> 		axentia,audio-routing =
> 			"DAC1", "OUTL",
> 			"DAC2", "OUTR";
>
> 		axentia,ssc-controller = <&ssc0>;
> 		axentia,audio-codec = <&pcm5142>;
>
> 		gpios = <&pioA 9 GPIO_ACTIVE_LOW>,
> 			<&pioA 8 GPIO_ACTIVE_LOW>,
> 			<&pioA 10 GPIO_ACTIVE_LOW>,
> 			<&pioA 11 GPIO_ACTIVE_LOW>;
>
> 		status = "okay";
> 	};
>
> I suspect that it has something to do with the snd_soc_dapm_add_routes call in
> linea_pcm512x_init? (I "stole" that piece from omap-abe-twl6040)


There does not seem to be a audio sink in your DAPM graph. You have a source 
which is the Playback stream, hence a one the "1" for "in". But a widget 
will only power up if it is on a active path from a source to a sink. Try to 
add a speaker, lineout or similar widget to the end of your graph.

- Lars
