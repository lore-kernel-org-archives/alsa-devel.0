From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Alsa principles
Date: Mon, 13 Aug 2007 09:03:59 +0200
Message-ID: <1186988639.1421.1205060965@webmail.messagingengine.com>
References: <8e4fc8270708111546k328a0575h9e362ee01a2917ec@mail.gmail.com>
	<200708121502.09106.linux@audioscience.com>
	<46BF7116.7070408@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2D7971037EA
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Aug 2007 09:04:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46BF7116.7070408@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LCID Fire <lcid-fire@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

LCID Fire wrote:
> First - I didn't find any complete description about interleaved and
> non-interleaved transport. What is actually (in a nutshell) the
> difference and what the consequences of either approach?

When using interleaved access, the sample values that are to be sent at
the same to each channel arestored  right after another in the buffer,
i.e., like this:

> Channel1
> Channel2
> Channel3
> Channel4
> Channel5
> Channel6
> Channel1
> Channel2
> .
> .
> .

In ALSA, the set of samples for all channels is called a frame.  In this
example, a frame would consist of six samples.


When using non-interleaved access, you have effectively one buffer for
each channel, i.e., the entire buffer would look like this:

c1 c1 c1 ..... c2 c2 c2 ..... c3 c3 c3 .......

> snd_pcm_hw_params_set_format:
> So this is setting some kind of format!? I mean first off - which format
> should one set? There are a few dozens to choose from and the hardware
> will most likely not support all of them.

When using the "default" device that can automatically convert sample
formats, it will support all (well, most) of them.

> So how does one retrieve a list of the hardware supported formats?

snd_pcm_hw_params_test_format() or snd_pcm_hw_params_get_format_mask()

> And which one should be considered superior?

Whatever is easiest to handle in your program.

> I assume it does affect the buffer size eventually needed!?

Yes, if you measure the buffer size in bytes.

> snd_pcm_hw_params_get_channels_max:
> This one should IMO output the channels - but for a capture device
> (where often there is just a single stereo input) this would normally
> just return 2, right?

The "default" device can give you as many channels as you want.

> snd_pcm_hw_params_set_periods:
> And we are at the REAL confusing stuff. Here one can set "periods". But
> what is meant by a period?

It's a part of the buffer that gets transferred between two interrupts.
The OSS API calls this "fragments".

>And there's a count of periods set - what is this count used for?

It's a different method of setting the period size.  The three
parameters are related like this:

periods = buffer_size / period_size

The buffer and period sizes are measured in frames.

You could also set the buffer and period _length_, which are the same
values, but measured in microseconds.

> snd_pcm_readi:
> Since the buffer is a void* I assume that the format does affect the
> data needed for the buffer.

Yes.

> But having a buffer in userspace and a buffer set in alsa means it
> does copy at least twice.

ALSA's buffer is the hardware DMA buffer; there is only one copy
involved.


HTH
Clemens
