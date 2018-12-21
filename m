From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Fri, 21 Dec 2018 15:05:51 +0200
Message-ID: <5f783336-1786-862c-b238-2309381bfd94@gmail.com>
References: <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
 <20181220153613.GC9325@sirena.org.uk>
 <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
 <20181221105741.GB4996@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 1987B267AC5
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:05:54 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id b11so5266475wmj.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 05:05:54 -0800 (PST)
In-Reply-To: <20181221105741.GB4996@sirena.org.uk>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/21/18 12:57 PM, Mark Brown wrote:
 >> Should we then accept, that some pops will be generated and hope that
 >> they'll be suppressed by the digital_mute callback?
 > It's probably easiest.

All right then; I'll just add the one line, setting
.ignore_pmdown_time = 1 to the machine driver and leave it at that.
I've been using the card with just the digital_mute patch for several
weeks and no pop got through, so it seems to be good enough, even with
just that.

First, I'd like to thank you for your support both in troubleshooting
this issue and in reviewing the patch I submitted.  I fully appreciate
I wasn't the easiest man to work with, being new to all of this and
mostly clueless, so your help is very much appreciated.

Now, I apologize in advance, but I'll ask you if you can comment on the
following final issue I have with this driver, which I was determined
to ignore, but can't: I've already mentioned that I'm using a card
made for the Raspberry Pi, and I can't really apply my patch there
as-is, because they seem to have changed the pcm512x CODEC driver,
without pushing the changes upstream.  You can see the patch in
question here:

https://github.com/raspberrypi/linux/commit/c53a137bd151130e29d7fc43947ac3e579a29ce4#diff-723fa079c49ec85d48e290fe84994b36

(My patch, by the way, does run without the above change if you use
the card without the external crystals, so I was able to test it in
the form I submitted it in.)

I can apply the patch via merge, so bothering with this is not at all
necessary, but if this change is useful, perhaps it's worth submitting
another patch for it.  I doubt this though, as it looks a bit hackish
to me.

To provide you with some context: The card uses a 24.576MHz crystal
for 48kHz-derived sampling rates, and it supports the S24_LE format,
which leads to non-integer LRCK dividers, and somewhat
faster-than-normal playback.  A solution to this, would be to play
24bit samples as 32-bit with the MSB zeroed out, as the chip supports
this.  As far as I understand it, the patch implements this, by
sending stereo streams as TDM data with two slots, one for each
channel, wide enough for the physical size of the sample, which
"happens" to be 32bits.  On the machine driver size the following is
done:

width = snd_pcm_format_physical_width(params_format(params));
ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x03, 0x03,
                                channels, width);
ret = snd_soc_dai_set_tdm_slot(rtd->codec_dai, 0x03, 0x03,
                                channels, width);

This works, but I'm not sure TDM is meant for things like that.
Anyway, if you think it's worth disucssing this, I can start a new
thread if you prefer.  If there's a straightforward way to fix this at
the machine driver level, that'd be even better, as it would allow me
to get rid of the divergence between the Pi and mainline kernel,
without bothering the latter.  If none of the above is the case, I can
happily just merge the patch as-is.
