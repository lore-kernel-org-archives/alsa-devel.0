From: =?windows-1252?Q?S=E9bastien_Bourdeauducq?= <sb@m-labs.hk>
Subject: Re: baytrail-pcm-audio: audio broken on Lenovo
 Thinkpad Tablet 10
Date: Mon, 30 Mar 2015 22:19:29 +0800
Message-ID: <55195B71.6080108@m-labs.hk>
References: <54E2DE80.1060308@m-labs.hk> <54E4A6D9.30005@linux.intel.com>
 <54E77B97.9050506@m-labs.hk> <54EB240C.5020105@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ssl.serverraum.org (ssl.serverraum.org [88.198.40.39])
 by alsa0.perex.cz (Postfix) with ESMTP id B6BE4260555
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 16:20:07 +0200 (CEST)
In-Reply-To: <54EB240C.5020105@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/23/2015 08:58 PM, Jarkko Nikula wrote:
>> Is there a way I can try sound/soc/codecs/rt5670.c instead? I edited it
>> so that it attaches to my ACPI ID (and rt5640 doesn't), but that did not
>> work. I noticed that the kernel has some Baytrail-specific modules for
>> RT564x, and I guess those would need to be changed as well - but it's
>> not straightforward.
>>
> Basically three changes are needed:
> =

> 1. Hack add "10EC5640" to rt5670.c as you have done
> 2. Add a new machine driver sound/soc/intel/sst-acpi.c/byt-rt5670
>    I guess cht_bsw_rt5672.c can be used as a starting point for audio
>    routes and byt-rt5640.c for dai link definitions.mess
> 3. Hack change sound/soc/intel/sst-acpi.c so that "10EC5640" loads
>    the new machine driver instead of byt-rt5640.

Thanks. I did that and I get the following in the kernel log:
[    6.831422] byt-rt5670 byt-rt5670: ASoC: CPU DAI baytrail-pcm-audio
not regis
tered
[    6.831443] byt-rt5670 byt-rt5670: snd_soc_register_card failed -517
[    6.831453] platform byt-rt5670: Driver byt-rt5670 requests probe
deferral

[    6.884013] baytrail-pcm-audio baytrail-pcm-audio: error: invalid DMA
engine
0
[    6.884023] baytrail-pcm-audio baytrail-pcm-audio: sst_dma_new failed -22


Note: it seems to me that all Baytrail machines will have this "error:
invalid DMA engine" message. AFAICT it is emitted from sst-firmware.c
because sst->pdata->dma_engine is 0 and in sst-acpi.c the function
sst_acpi_probe does not set it for Baytrail because resindex_dma_base is
-1 in sst_acpi_baytrail_desc.

[    6.924094] baytrail-pcm-audio baytrail-pcm-audio: FW version:
04.05.13.a0
[    6.924106] baytrail-pcm-audio baytrail-pcm-audio: Build type: a0
[    6.924109] baytrail-pcm-audio baytrail-pcm-audio: Build date: Apr  2
2014 14:14:39
[    6.931503] byt-rt5670 byt-rt5670: rt5670-aif1 <-> baytrail-pcm-audio
mapping ok
[    6.931624] byt-rt5670 byt-rt5670: ASoC: no source widget found for
ssp2 Tx
[    6.931629] byt-rt5670 byt-rt5670: ASoC: Failed to add route ssp2 Tx
-> direct -> AIF1 Playback
[    6.931636] byt-rt5670 byt-rt5670: ASoC: no source widget found for
codec_out0
[    6.931640] byt-rt5670 byt-rt5670: ASoC: Failed to add route
codec_out0 -> direct -> ssp2 Tx
[    6.931647] byt-rt5670 byt-rt5670: ASoC: no source widget found for
codec_out1
[    6.931650] byt-rt5670 byt-rt5670: ASoC: Failed to add route
codec_out1 -> direct -> ssp2 Tx
[    6.931656] byt-rt5670 byt-rt5670: ASoC: no source widget found for
ssp2 Rx
[    6.931660] byt-rt5670 byt-rt5670: ASoC: Failed to add route ssp2 Rx
-> direct -> codec_in0
[    6.931666] byt-rt5670 byt-rt5670: ASoC: no source widget found for
ssp2 Rx
[    6.931670] byt-rt5670 byt-rt5670: ASoC: Failed to add route ssp2 Rx
-> direct -> codec_in1
[    6.931677] byt-rt5670 byt-rt5670: ASoC: no sink widget found for ssp2 Rx
[    6.931680] byt-rt5670 byt-rt5670: ASoC: Failed to add route AIF1
Capture -> direct -> ssp2 Rx

My byt-rt5670 is there:
https://gist.github.com/sbourdeauducq/8c5da8ac0da13e21ee31

I have to say that I am unfamiliar with Intel SST and I'm don't quite
know what I am doing there. I wish sound devices were straightforward
DMA-to-DAC devices instead of this complicated DSP architecture which
AFAICT boils down to a glorified memcpy/resampler under Linux (this
seems to be a pattern with this SoC though; I had a look at how to get
the MIPI cameras to work on this machine and it's an even worse mess).

> However, above changes may not make audio working since there has been
> couple other new Baytrail based machines with correct codec but audio
> seems to not move between the DSP and codec chip.

Despite the error messages, the audio device is created and userspace
applications can send data into it, but no sound is coming out. I also
have to say that the settings in alsamixer are a terrible mess which
seems not to originate from my hacks.

> One assumption is if they use another SSP port than SSP2. Unfortunately
> it's difficult to test since Linux DSP FW is hard-coded for SSP2.

If only there were no DSP in the first place...

S=E9bastien
