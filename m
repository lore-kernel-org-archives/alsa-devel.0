From: Mauricio Cirelli <cirelli.mauricio@gmail.com>
Subject: Questions about DAPM Routing for STA309A DSP Driver
Date: Wed, 24 Aug 2016 14:36:36 -0300
Message-ID: <CAJxDekNSBp0yCFYKvOg=r4+0tGpf6X19fCBHQMiShUThyfr+jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id F059D26710D
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 19:36:37 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id l89so1172923lfi.2
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 10:36:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA Community,

I am new to this community and have a basic knowledge on ASoC architecture.
I have worked a few times with Freescale's boards and the SGTL5000 Codec
driver.

Now, time has come for me to develop a ASoC Codec Driver for an Audio DSP
(ST Microelectronics STA309A). Obviously, this driver should work only on
the Playback stream. This chip supports up to 8 playback channels (I2S
format) and has up to 8 output channels. There are also 8 internal
channels, whose inputs can be one of the 8 playback channels and outputs
are connected to one of each 8 output channels like this:

Playback Channel X --> Input Channel Y --> Output Channel Z

This DSP has several controls to apply effects and modify volume on each
channel internal channel individually. I have been able to implement
snd_kcontrol_new for them successfully and I am able to control them from
the userspace correctly.

The part I am still in doubt on how to proceed is related to this channel
routing. From what I have researched, this could be designed on top of DAPM
Widgets and DAPM Routes in a way that the machine-level driver could
configure this routing according to the specific board and the userspace
would not be required to deal with this stuff.

I want to develop a device driver following the ASoC architecture so I can
use it in different boards and in a way it could be useful for other
developers.

Here is what I was sketching up for this snd_soc_codec_driver:

static const char *input_names[8] = { "DIN1", "DIN2", "DIN3", "DIN4",
"DIN5", "DIN6", "DIN7", "DIN8" };
static const char *internal_names[8] = { "INT1", "INT2", "INT3", "INT4",
"INT5", "INT6", "INT7", "INT8" };

/* Playback Channel to Internal DSP Channel Mapping */
static SOC_ENUM_SINGLE_DECL(int1mux, STA309A_C12IM, 0, input_names);
static const struct snd_kcontrol_new int1mux_ctrl =
SOC_DAPM_ENUM("INT1MUX", int1mux);
.... replicated to all 8 internal channels

/* Internal DSP Channel to Output Channel Mapping */
static SOC_ENUM_SINGLE_DECL(out1mux, STA309A_C12OM, 0, internal_names);
static const struct snd_kcontrol_new out1mux_ctrl =
SOC_DAPM_ENUM("OUT1MUX", out1mux);
.... replicated to all 8 output channels

static const struct snd_soc_dapm_widget sta309a_dsp_dapm_widgets[] = {
    SND_SOC_DAPM_MUX("INT1MUX", SND_SOC_NOPM, 0, 0, &int1mux_ctrl),
.... added 8 internal channel muxes

    SND_SOC_DAPM_MUX("OUT1MUX", SND_SOC_NOPM, 0, 0, &out1mux_ctrl),
.... added 8 output channel muxes
};

Now I am lost on how to declare the possible routes. It should be possible
to route each playback channel to any of the 8 possible internal channels
and the internal channels to any of the 8 possible output channels. Note
that this DSP supports Cross-Overs, so one can route a playback channel to
one or more internal channels. Analogously, one can route an internal
channel to one or more output channels.

I have not started to develop the machine-level driver, but any thoughts on
how to design it would be very helpful. In the machine-level driver, I
would like to define the DSP routing for an specific board. How can I do it?

Thank you very much.


Mauricio Cirelli
