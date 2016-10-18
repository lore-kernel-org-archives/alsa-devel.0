From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: configuring machine specific DAPM for codec +
	headset jack detect
Date: Tue, 18 Oct 2016 14:28:02 -0700
Message-ID: <CAJ+vNU38_WTHazhSF4SnFMbTZAiCkzoFThmc7O-=OFGp7kUfKA@mail.gmail.com>
References: <CAJ+vNU2a5G8HxJjZ+0g_NkC1jtMg1jKVq6xOfWqx94tbyA=rLA@mail.gmail.com>
 <20161018110236.GD10208@sirena.org.uk>
 <CAJ+vNU2x-i77=VEskXGECYTqK4PdBBn1Z9Y5FE=_vmU6iNNtOg@mail.gmail.com>
 <20161018183037.GF10208@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id CCB822659AA
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 23:28:04 +0200 (CEST)
Received: by mail-io0-f175.google.com with SMTP id q192so12217728iod.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 14:28:04 -0700 (PDT)
In-Reply-To: <20161018183037.GF10208@sirena.org.uk>
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

On Tue, Oct 18, 2016 at 11:30 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 18, 2016 at 11:16:40AM -0700, Tim Harvey wrote:
<snip>
>> I'm not quite understanding the DAPM widgets in the driver. These
>> registers are configured by:
>>         SND_SOC_DAPM_PGA("Left HP Out", HPLOUT_CTRL, 0, 0, NULL, 0),
>>         SND_SOC_DAPM_PGA("Right HP Out", HPROUT_CTRL, 0, 0, NULL, 0),
>
>> yet those don't show up in amixer as controls so they are somehow used
>> internally.
>

Ok, I see how the routing maps these together.

> DAPM widgets are not controls, they're purely internal to the kernel.
> The kernel will power up any DAPM widgets that form part of a complete
> audio path from input to output or which are forced on.
>
>> Looking at the tlv32aic3105 datasheet
>> (http://www.ti.com/lit/ds/symlink/tlv320aic3105.pdf) Register 51
>> (0x33) has its mute control in bit3 so I would expect that bit to be
>> cleared before and set after applying this stuff. Is there a missing
>> SND_SOC_DAPM* in that driver perhaps?
>
> You *can* hook mutes into DAPM with _AUTODISABLE controls but it's
> rarely required.

Can you give me more detail? I'm unable to figure out how to add mute
control to the tlv320aic3x.c driver. I would think it would be
something like adding:

Register the following DAPM  widgets:
SND_SOC_DAPM_PGA("Left Mute", HPLOUT_CTRL, 3, 0, NULL, 0),
SND_SOC_DAPM_PGA("Right Mute", HPROUT_CTRL, 3, 0, NULL, 0),

Add following to routing:
{"HPLOUT", NULL, "Left Mute"},
{"HPROUT", NULL, "Right Mute"},

>
>> Incidentally, the board I'm working with has a DC biased headphone. If
>> I modify the board to AC bias the headphone the pop goes away, but I'm
>> thinking that isn't really the right solution and that there is
>> something instead missing from the tlv320aic3x.c driver that should be
>> muting/unmuting the outputs around the above register changes.
>
> I'm not sure what you mean by DC and AC bias here, sorry.  Do you mean
> VMID referenced vs ground referenced?  If it's that then it sounds like
> the driver ought to be biasing the headphones in set_bias_level()
> probably based on some DT information, though I'd also say that I can't
> think of any reason why you wouldn't want ground referenced outputs so
> perhaps I'm missing something.

I mean that the HP out of the codec is directly coupled to the
headphone vs via a DC blocking capacitor. The outputs are
ground-references (single-ended: HPLCOM and HPRCOM are hooked to GND)

I'm certainly no audio expert but have been told that DC coupled
headphones have better quality than AC coupled (which kind of makes
sense to me) but when you have DC coupled headphones the headphone
goes from 0 to 1.4V abruptly when R51.0 and R65.0 are set. I don't
think muting is going to help as I would think it would just move the
pop to when the output is un-muted (because the pop is caused by the
abrupt DC level change).

Am I missing something obvious here? Would DC biased outputs only make
sense in a case where you disable the pmdown_time completely?

>
>> Regarding the ts3a227e headset detect/config switch
>> (http://www.ti.com/lit/ds/symlink/ts3a227e.pdf), what is the proper
>> way to hook that into the Linux input layer via the simple-sound-card
>> driver? The ts3a227e_enable_jack_detect function exported from the
>> ts3a227e.c driver is only currently called by two machine drivers that
>> have explicit support. I suppose if I want to add support for this
>> using simple-sound-card I would need to add a custom dt binding to
>> that driver?
>
> There was a thread a while back where Dylan Reid proposed a custom jack
> binding ("Add a gpio jack device" IIRC) but that ground to a halt.
> Right now I'd expect a custom machine driver for something like this
> which is obviously not ideal but is going to be a lot easier for you to
> implement.

Ok - that makes sense. I will stick with a machine driver.

Thanks,

Tim
