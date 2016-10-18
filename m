From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: configuring machine specific DAPM for codec +
	headset jack detect
Date: Tue, 18 Oct 2016 11:16:40 -0700
Message-ID: <CAJ+vNU2x-i77=VEskXGECYTqK4PdBBn1Z9Y5FE=_vmU6iNNtOg@mail.gmail.com>
References: <CAJ+vNU2a5G8HxJjZ+0g_NkC1jtMg1jKVq6xOfWqx94tbyA=rLA@mail.gmail.com>
 <20161018110236.GD10208@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A8CFC266CDA
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 20:16:42 +0200 (CEST)
Received: by mail-it0-f42.google.com with SMTP id 4so89835683itv.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 11:16:42 -0700 (PDT)
In-Reply-To: <20161018110236.GD10208@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2016 at 4:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 17, 2016 at 04:33:10PM -0700, Tim Harvey wrote:
>
>> I have a TI TLV320AIC3105 codec on a board connected to a TS3A227E
>> headset detect chip (which handles switching pins for OMTP vs std
>> jacks as well as jack detect and headset buttons). The AIC3105 doesn't
>> use several of the inputs and outputs yet those inputs and outputs
>> still have mux widgets volume widgets that are not 'off'.
>
>> Is there a way to easily disable them so they a) are not muxed into
>> mixers, b) have their gains set to 0, and c) are pruned from the list
>> of widgets so users don't have to muddle through them in mixers?
>
> No, you need to write that code if you want it - we do mark not
> connected things with the intention that someone could implement this
> but nobody did yet.

Hi Mark,

OK - that explains why 'snd_soc_dapm_disable_pin' and
'snd_soc_dapm_enable_pin' didn't have any noticeable affect when I was
calling those from a machine driver. I will plan on having to setup
all the ALSA controls manually in my OS configuration (Android in this
use case using tinyalsa_hal).

>
>> I am also fighting both a pop/click issue and am wondering if there is
>> any easy way to disable the DAPM power up/down sequence upon playback
>> start/complete (my application is not power sensitive). I'm still
>> trying to understand the source of the pop/click.
>
> You can ramp the power down time up but no, there's no way to disable it
> completely in the kernel - this is normally done in the sound server and
> tends to work better that way as starting and stopping the digital audio
> stream tends to be glitchy.

I haven't found where the power down time is specified/configured -
can you point me to that?

>
>> Additionally the TS3A227E requires MIC bias to be kept enabled in
>> order to detect headset button presses. I see that setting
>> idle_bias_off to false will keep the MIC bias enabled but I don't see
>> a way to specify that via device-tree.
>
> Your machine driver should force enable any widgets it needs.
> idle_bias_off should have no effect on microphone biases, if it does
> that sounds like a bug.

I have found the debuffs dapm_pop_time which I assume is intended to
help kernel devs find causes for pop's and it has helped me identify
where the pop occurs in the tlv320aic3x.c driver.

In my case I hear a pop at:
[  402.958518] tlv320aic3x-codec 2-0018: pop test : Queue Left HP
Mixer: reg=0xffffffff, 0x1/0x1
[  402.967170] tlv320aic3x-codec 2-0018: pop test : Queue Right HP
Mixer: reg=0xffffffff, 0x1/0x1
[  402.976351] tlv320aic3x-codec 2-0018: pop test : Queue Left HP Out:
reg=0x33, 0x1/0x1
[  402.984243] tlv320aic3x-codec 2-0018: pop test : Applying 0x1/0x1
to 33 in 2000ms
[  405.031626] tlv320aic3x-codec 2-0018: 33 <= 0d

The pop occurs whe HPLOUT Output Level Control Register (Register 51)
bit 0 is set indicating 'HPLOUT is fully powered up' and the same can
be heard when HPLROUT Register 65 bit 0 is set for the right side.

I'm not quite understanding the DAPM widgets in the driver. These
registers are configured by:
        SND_SOC_DAPM_PGA("Left HP Out", HPLOUT_CTRL, 0, 0, NULL, 0),
        SND_SOC_DAPM_PGA("Right HP Out", HPROUT_CTRL, 0, 0, NULL, 0),

yet those don't show up in amixer as controls so they are somehow used
internally.

Looking at the tlv32aic3105 datasheet
(http://www.ti.com/lit/ds/symlink/tlv320aic3105.pdf) Register 51
(0x33) has its mute control in bit3 so I would expect that bit to be
cleared before and set after applying this stuff. Is there a missing
SND_SOC_DAPM* in that driver perhaps?

Incidentally, the board I'm working with has a DC biased headphone. If
I modify the board to AC bias the headphone the pop goes away, but I'm
thinking that isn't really the right solution and that there is
something instead missing from the tlv320aic3x.c driver that should be
muting/unmuting the outputs around the above register changes.

Regarding the ts3a227e headset detect/config switch
(http://www.ti.com/lit/ds/symlink/ts3a227e.pdf), what is the proper
way to hook that into the Linux input layer via the simple-sound-card
driver? The ts3a227e_enable_jack_detect function exported from the
ts3a227e.c driver is only currently called by two machine drivers that
have explicit support. I suppose if I want to add support for this
using simple-sound-card I would need to add a custom dt binding to
that driver?

Regards,

Tim
