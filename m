From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
Date: Thu, 07 May 2015 13:11:16 +0200
Message-ID: <554B4854.7090209@metafoo.de>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk> <s5ha8ymy3e2.wl-tiwai@suse.de>
 <20150405162034.GH13898@n2100.arm.linux.org.uk>
 <s5h4mouy14a.wl-tiwai@suse.de>
 <20150405172608.GA12732@n2100.arm.linux.org.uk> <554A493C.5080106@iki.fi>
 <20150507104102.GA2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 47587261546
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 13:11:16 +0200 (CEST)
In-Reply-To: <20150507104102.GA2067@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Anssi Hannula <anssi.hannula@iki.fi>, Takashi Iwai <tiwai@suse.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05/07/2015 12:41 PM, Russell King - ARM Linux wrote:
[...]
>>> What I'm concerned about is that when the ALSA parameter refining
>>> starts, we start with (eg) 2-8 channels, 32-192kHz.  Given that,
>>> if we invoke the channel restriction before the rate restriction,
>>> we would end up limiting to 2 channel at 32-192kHz.  If we apply
>>> the restrictions in the opposite order, we'd restrict to 6
>>> channel, 32-48kHz.  Neither are obviously correct in this
>>> circumstance, and I don't really see a way to solve it given my
>>> understanding of the way ALSA's parameter refinement works.
>>>
>>> I suspect this is why most HDMI drivers are implemented such that
>>> they take the maximum capabilities over all SADs, which would end
>>> up restricting audio in the above case to: up to 6 channels, at
>>> 32, 44.1, 48, 96 and 192kHz, even though 6 channel @ 192kHz isn't
>>> hasn't been indicated as supported.
>>>
>>> Most of this is speculation though, based off what is in the
>>> documentation.  As I say, I don't have enough real-world examples
>>> to get a feel for what manufacturers _actually_ do to give a hint
>>> as to how the documentation should be interpreted.
>
> ... so this is probably less than speculation.
>
> So, ALSA gurus, how do we handle this?  How do we arrange the parameter
> resolution such that ALSA can permit _either_ 2 channels at 192kHz or 6
> channels at 48kHz, but not 6 channels at 192kHz?  Right now, I don't
> see how that's possible.

That's pretty straight forward and can be done using custom rules linking 
the number of channels to the sample rate. Have a look at 
snd_ac97_pcm_double_rate_rules() this is pretty much the same constraint.

- Lars
