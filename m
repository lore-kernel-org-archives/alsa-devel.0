From: Liam Girdwood <lrg@ti.com>
Subject: Re: Proposed changes to soc core to allow multiple
 codecs bound together on a single bus
Date: Mon, 6 Jun 2011 11:47:09 +0100
Message-ID: <4DECB02D.2000309@ti.com>
References: <BANLkTimBmj+BROhu9b-+wQRXUQa6ABpOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D34A824340
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 12:47:13 +0200 (CEST)
In-Reply-To: <BANLkTimBmj+BROhu9b-+wQRXUQa6ABpOBQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 04/06/11 01:04, Caleb Crome wrote:
> Hi all,
>   I finally got my multi-codec board up and running, but by hacking the
> codec driver in a very nasty way.   It would be much preferable to modify
> the soc core so that multiple codecs can be easily instantiated on a single
> bus.
> 
> Problem overview
> -----------------------------
> The problem is this:  a single CPU DAI is connected to multiple codecs.
>  Each codec is assigned a different TDM slot on the TDM bus. All codecs are
> bound together and expected to start at the same time and have the same
> clocks, etc.
> 
> Either the CPU or one of the codecs can be the master, all other devices are
> slaves.  Each codec, as it transmits, must tri-state its output when not
> transmitting valid data, so that the other codecs may transmit in their
> given time slot.
> 
> I think from user-space, these codecs should really be bound pretty tightly
> together, so they may be opened as a single 'sound card' with the sum of the
> channels available.  My card is an 8 codec (2 channel/codec) card, so it
> should appear as a 16-channel sound card that opens/closes all in one go.
> 
> Currently, I don't see a way in the soc core to handle this kind of
> situation.  It seems that when you add multiple codecs onto one host DAI,
> you may only open one codec at a time.  The others are not available.
> 
> There are a few variations on this general theme:
> *  1 cpu DAI, many codecs, all sharing the same data in and data out pins
> (TDM/network mode) (like the McBSP)
> * 1 cpu DAI, many codecs, but the cpu dai may have more than 1 data pin
> (like the McASP on TI parts).  Shared clocks.
> * multiple cpu DAIs bound together on the same clocks, multiple codecs.
> 
> What is the proper way to add this functionality to the SOC API?
> 
> Perhaps a specification like this:
> static char *my_codec_dais[] = {
>      "tlv320aic3x-hifi.0",   <---- in this case, the '.0'
>      "tlv320aic3x-hifi.1",    ---- means that it's slot 0
>      "tlv320aic3x-hifi.2",    ---- on the TDM bus.
>      "tlv320aic3x-hifi.3",
> };
> static char *my_codec_names[] = {
>      "tlv320aic3x-codec.2-0018", <--- codec on i2c bus 2, addr 0x18
>      "tlv320aic3x-codec.2-0019", <--- codec on i2c bus 2, addr 0x19
>      "tlv320aic3x-codec.2-001a", <--- codec on i2c bus 2, addr 0x1a
>      "tlv320aic3x-codec.2-001b", <--- codec on i2c bus 2, addr 0x1b
> };
> static struct snd_soc_dai_link my_dai[] = {
>      .name = "my_dai_name",
>      .stream_name = "my_stream_name",
>      .cpu_dai_name = "omap-mcbsp-dai.2",
>      .platform_name= "omap-pcm_audio",
>      .codec_dai_name = my_codec_dais,
>      .num_codec = ARRAY_SIZE(my_codec_dais),
>      .codec_name = my_codec_names,
>      .ops = &my_ops,
> };
> 
> 
> The core will parse the dai name for the slot order, and pass it on to the
> codec during hw_params.  Then the codec can properly set the TDM slot on the
> hardware interface.
> 
> It will also pass the cpu dai the number of slices that are configured, so
> it knows how many slots to be expecting.
> 
> This means that the snd_soc_pcm_runtime, and probably a bunch of other
> places, will need to keep track of multiple codecs, and multiple dai's, and
> functions like 'hw_params' will need to loop through multiple codec_dai's,
> so each codec and cpu dai can be configured correctly.
> 
> I suspect this would be a pretty major change to the SOC core, and
> non-trivial.
> 
> 
> Any thoughts on this, or if I'm totally barking up the wrong tree here?
> 
> Thanks,
>   -Caleb

The ASoC DSP support I'm working on atm does something similar here. We take 1 frontend (FE) alsa PCM and can map multiple backend (BE) DAIs to it. The PCM operations are all synchronised for each DAI, i.e. calls to hw_params(), trigger() etc are called on each BE at the same time as the FE. 

This could be used to perform the multiple calls to configure each of your codecs, I dont think there would be many changes required to do this.

The stable code is on my dsp branches here

git.kernel.org/pub/scm/git/linux/kernel/lrg/asoc-2.6.git

The WIP branch for upstreaming atm is here (will be rebased frequently)

https://gitorious.org/omap-audio/linux-audio

Thanks

Liam
