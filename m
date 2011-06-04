From: Caleb Crome <caleb@crome.org>
Subject: Proposed changes to soc core to allow multiple codecs
 bound together on a single bus
Date: Fri, 3 Jun 2011 17:04:12 -0700
Message-ID: <BANLkTimBmj+BROhu9b-+wQRXUQa6ABpOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.212.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 69A0E24489
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jun 2011 02:04:16 +0200 (CEST)
Received: by pxi10 with SMTP id 10so1619532pxi.8
	for <alsa-devel@alsa-project.org>; Fri, 03 Jun 2011 17:04:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,
  I finally got my multi-codec board up and running, but by hacking the
codec driver in a very nasty way.   It would be much preferable to modify
the soc core so that multiple codecs can be easily instantiated on a single
bus.

Problem overview
-----------------------------
The problem is this:  a single CPU DAI is connected to multiple codecs.
 Each codec is assigned a different TDM slot on the TDM bus. All codecs are
bound together and expected to start at the same time and have the same
clocks, etc.

Either the CPU or one of the codecs can be the master, all other devices are
slaves.  Each codec, as it transmits, must tri-state its output when not
transmitting valid data, so that the other codecs may transmit in their
given time slot.

I think from user-space, these codecs should really be bound pretty tightly
together, so they may be opened as a single 'sound card' with the sum of the
channels available.  My card is an 8 codec (2 channel/codec) card, so it
should appear as a 16-channel sound card that opens/closes all in one go.

Currently, I don't see a way in the soc core to handle this kind of
situation.  It seems that when you add multiple codecs onto one host DAI,
you may only open one codec at a time.  The others are not available.

There are a few variations on this general theme:
*  1 cpu DAI, many codecs, all sharing the same data in and data out pins
(TDM/network mode) (like the McBSP)
* 1 cpu DAI, many codecs, but the cpu dai may have more than 1 data pin
(like the McASP on TI parts).  Shared clocks.
* multiple cpu DAIs bound together on the same clocks, multiple codecs.

What is the proper way to add this functionality to the SOC API?

Perhaps a specification like this:
static char *my_codec_dais[] = {
     "tlv320aic3x-hifi.0",   <---- in this case, the '.0'
     "tlv320aic3x-hifi.1",    ---- means that it's slot 0
     "tlv320aic3x-hifi.2",    ---- on the TDM bus.
     "tlv320aic3x-hifi.3",
};
static char *my_codec_names[] = {
     "tlv320aic3x-codec.2-0018", <--- codec on i2c bus 2, addr 0x18
     "tlv320aic3x-codec.2-0019", <--- codec on i2c bus 2, addr 0x19
     "tlv320aic3x-codec.2-001a", <--- codec on i2c bus 2, addr 0x1a
     "tlv320aic3x-codec.2-001b", <--- codec on i2c bus 2, addr 0x1b
};
static struct snd_soc_dai_link my_dai[] = {
     .name = "my_dai_name",
     .stream_name = "my_stream_name",
     .cpu_dai_name = "omap-mcbsp-dai.2",
     .platform_name= "omap-pcm_audio",
     .codec_dai_name = my_codec_dais,
     .num_codec = ARRAY_SIZE(my_codec_dais),
     .codec_name = my_codec_names,
     .ops = &my_ops,
};


The core will parse the dai name for the slot order, and pass it on to the
codec during hw_params.  Then the codec can properly set the TDM slot on the
hardware interface.

It will also pass the cpu dai the number of slices that are configured, so
it knows how many slots to be expecting.

This means that the snd_soc_pcm_runtime, and probably a bunch of other
places, will need to keep track of multiple codecs, and multiple dai's, and
functions like 'hw_params' will need to loop through multiple codec_dai's,
so each codec and cpu dai can be configured correctly.

I suspect this would be a pretty major change to the SOC core, and
non-trivial.


Any thoughts on this, or if I'm totally barking up the wrong tree here?

Thanks,
  -Caleb
