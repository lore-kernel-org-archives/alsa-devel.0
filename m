From: Matthias Reichl <hias@horus.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Sat, 22 Dec 2018 15:44:23 +0100
Message-ID: <20181222144423.ugwgr5ab3run673a@camel2.lan>
References: <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
 <20181220153613.GC9325@sirena.org.uk>
 <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
 <20181221105741.GB4996@sirena.org.uk>
 <5f783336-1786-862c-b238-2309381bfd94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9E326798A
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 15:44:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5f783336-1786-862c-b238-2309381bfd94@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 21, 2018 at 03:05:51PM +0200, Dimitris Papavasiliou wrote:
> Now, I apologize in advance, but I'll ask you if you can comment on the
> following final issue I have with this driver, which I was determined
> to ignore, but can't: I've already mentioned that I'm using a card
> made for the Raspberry Pi, and I can't really apply my patch there
> as-is, because they seem to have changed the pcm512x CODEC driver,
> without pushing the changes upstream.  You can see the patch in
> question here:
> 
> https://github.com/raspberrypi/linux/commit/c53a137bd151130e29d7fc43947ac3e579a29ce4#diff-723fa079c49ec85d48e290fe84994b36

I didn't upstream the patch as I wasn't really satisfied with it
and also think it's quite hackish.

Back then when the Hifiberry folks submitted their machine driver
to the RPi kernel they sneaked in a change to the pcm512x which
forced S24 data to use 64fs clocking
https://github.com/raspberrypi/linux/pull/1152

This change had the nasty side effect that using pcm512x eg in slave
mode with the simple card driver broke as the setup on both sides
no longer matched. bcm2835 by default uses 32/48/64fs for 16/24/32
bit data - like most drivers do (also upstream pcm512x driver). pcm512x
with the change used 32/64/64fs - something that's not possible to
express in simple-card's binding.

So that change had to go and after dropping it we realized some control
over fs was needed if the machine driver wanted to support S24_LE
(just dropping S24_LE support and relying on alsalib to do automatic
24->32bit conversion would have been another option).

Doing that via the set_bclk_ratio interface would probably have been
the cleaner approach, OTOH set_tdm_slot had the nice feature that
it already had simple card DT bindings - so I (ab)used that.

I don't have a Hifiberry DAC+ card (or other cards with on-board
oscillators plus pcm512x in master mode) so I haven't looked into
better solutions. Main focus was to have some workaround that didn't
cause collateral damage but allowed the card to keep working.

I wouldn't mind at all if you do a proper implementation and submit it
upstream so the downstream patch can be dropped. 

so long,

Hias

> 
> (My patch, by the way, does run without the above change if you use
> the card without the external crystals, so I was able to test it in
> the form I submitted it in.)
> 
> I can apply the patch via merge, so bothering with this is not at all
> necessary, but if this change is useful, perhaps it's worth submitting
> another patch for it.  I doubt this though, as it looks a bit hackish
> to me.
> 
> To provide you with some context: The card uses a 24.576MHz crystal
> for 48kHz-derived sampling rates, and it supports the S24_LE format,
> which leads to non-integer LRCK dividers, and somewhat
> faster-than-normal playback.  A solution to this, would be to play
> 24bit samples as 32-bit with the MSB zeroed out, as the chip supports
> this.  As far as I understand it, the patch implements this, by
> sending stereo streams as TDM data with two slots, one for each
> channel, wide enough for the physical size of the sample, which
> "happens" to be 32bits.  On the machine driver size the following is
> done:
> 
> width = snd_pcm_format_physical_width(params_format(params));
> ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x03, 0x03,
>                                channels, width);
> ret = snd_soc_dai_set_tdm_slot(rtd->codec_dai, 0x03, 0x03,
>                                channels, width);
> 
> This works, but I'm not sure TDM is meant for things like that.
> Anyway, if you think it's worth disucssing this, I can start a new
> thread if you prefer.  If there's a straightforward way to fix this at
> the machine driver level, that'd be even better, as it would allow me
> to get rid of the divergence between the Pi and mainline kernel,
> without bothering the latter.  If none of the above is the case, I can
> happily just merge the patch as-is.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
