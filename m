From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Thu, 23 Feb 2012 08:25:06 +0100
Message-ID: <4F45E9D2.3090205@canonical.com>
References: <20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
	<20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
	<20120213154458.GB3494@opensource.wolfsonmicro.com>
	<s5hwr7qzl6g.wl%tiwai@suse.de>
	<20120213192309.GG3494@opensource.wolfsonmicro.com>
	<s5hk43e24la.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id A84D62415A
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 08:25:08 +0100 (CET)
In-Reply-To: <s5hk43e24la.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 02/22/2012 05:52 PM, Takashi Iwai wrote:
> At Tue, 14 Feb 2012 08:20:50 +0100,
> David Henningsson wrote:
>> I would vote for "C2", although I would probably prefer "[location] base
>> [channel]" over "[location] base [direction] [channel]", as direction is
>> superfluous given "base". This is also what the current implementation
>> offers, and what I've based my PulseAudio patches on.
>
> Actually, C>  B, thus we may take an approach of C optionally.
> In both cases, we'd need an id string or such (e.g. "Jack" suffix) to
> indicate that it's a jack kctl.  If this is satisfied, the rest prefix
> and suffix can be fully optional.
>
> That is, for those who don't need the additional information (yet),
> just pass the base name.  For multiple items, use the multiple
> indices.  This is equivalent with B.
>
> For those who care about the multiple items (e.g. HD-audio), they can
> pass the more verbose name.  It's C.
>
> The rest is the job of the user-space side parser.  It'll gather all
> items with "Jack" suffix, then trim location, direction or channel
> prefix/suffix.  It shouldn't be too hard.
>
> Yes, it's redundant.  One can represent it in both ways via TLV or
> name string.  But it works even now (before the TLV definitions),
> that's the point.

I agree with this reasoning.

>> A and B requires additional work as we would need an API in alsa-lib
>> from where you can read and interpret the TLVs, and stuff like amixer
>> needs to understand it too make it reasonable easy to work with and
>> test. And C gives the option to add TLVs later whenever we feel the need
>> for it, so it seems to be an all-win.
>
> Honestly speaking, I think the plan A isn't that bad.  The suffix
> look-up and filtering as mentioned above looks slightly messy.
> It'd be much simpler in both kernel and user-space implementations.
> The biggest drawback is that David would need to rewrite his patch to
> match with this scheme :)  And, of course, it's not visible with the
> current alsa-utils stuff.  The verbose name string would be visible by
> alsactl or whatever even in the current version, yes.

And it requires some specification on how this TLV will look like, my 
head isn't completely clear on that. But maybe you got that all figured out?

But let me stress that the matching is actually what's most important to 
PulseAudio at this point: assume we have one 'Front Mic Jack' and one 
'Rear Mic Jack' - when the rear mic is plugged in, and the user wants to 
change the mic gain, PulseAudio should make sure that 'Input Source' is 
set to 'Rear Mic' and that it changes 'Rear Mic Boost', 'Capture' and 
nothing else. (And, for HDMI, we also need to match against the correct 
PCM device.)

That's why I like C best so far, because I can match on the names. (And 
yes, that I don't have to rewrite my patch a second time is an added 
bonus :-) )

>> Also; as this graph exposing thing is unlikely to be implemented in all
>> layers of the audio stack any time soon, maybe C2 is also the one that
>> gives the most obvious matching between mixer kcontrols and jack
>> kcontrols? I'd like to move in this direction; not only because we
>> currently do not have the graph, but also because that even if we have
>> it, userspace apps choosing not to implement it will have a good option.
>
> IMO, this graph things should be considered separately at this
> moment.  The name string itself won't be always enough to identify the
> connected kctls.  If any, we can add a new TLV to represent the
> associated kctls, as the driver already knows which widget NID is
> assigned to which control.  This would be simpler and more robust, I
> guess.

Hmm, but for that to actually work out reliably, we're going to need
1) all inputs and outputs, not only those with jacks. So we can know if 
there is a 'speaker' or not, and
2) deal with multiple DACs and ADCs somehow. Or are you assuming we 
always use the first DAC/ADC here?
3) a reliable way to tell that we can use this method for mixer probing 
or if we should fall back to the current method.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
