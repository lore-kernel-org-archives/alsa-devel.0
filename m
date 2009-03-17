From: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Subject: Re: [alsa-devel] Bugs on aspire one A150
Date: Tue, 17 Mar 2009 11:05:00 +0100
Message-ID: <20090317100500.GA16029@rhlx01.hs-esslingen.de>
References: <s5hwsappi44.wl%tiwai@suse.de> <s5hprghphid.wl%tiwai@suse.de> <20090316170015.GA9776@rhlx01.hs-esslingen.de> <s5hljr5pex0.wl%tiwai@suse.de> <20090316173000.GA25647@rhlx01.hs-esslingen.de> <s5hiqm9pe1g.wl%tiwai@suse.de> <20090316180638.GB25647@rhlx01.hs-esslingen.de> <s5htz5tyzyg.wl%tiwai@suse.de> <20090316212227.GA29471@rhlx01.hs-esslingen.de> <s5hfxhczinh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hfxhczinh.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Mar 17, 2009 at 08:57:06AM +0100, Takashi Iwai wrote:
> At Mon, 16 Mar 2009 22:22:27 +0100,
> Andreas Mohr wrote:
> > 
> > Hi,
> > 
> > On Mon, Mar 16, 2009 at 09:28:39PM +0100, Takashi Iwai wrote:
> > > The question is whether the left / right channels recorded from
> > > digital mic are really raw data, or they are for modified data
> > > (for differential, etc)...  It's hard to guess without the actual
> > > data.
> > 
> > I don't quite follow you here. Is there anything I could do about this?
> 
> The mic array on a laptop is used for beam forming and noise
> suppressions.  These require the software manipulation, of course. 
> The question is what kind of data is read from the hardware.  Thus,
> providing the raw streams for both mic inputs makes sense.

Makes sense indeed.

> Obviously the stream read from the codec chip is a PCM while usually
> the digital mic gives the output as PDM.  So PDM -> PCM isn't needed
> here.  But, still a question is why a phase inversion in the second
> channel.  Whether it's intentional (e.g. to make the further
> conversion easier) or not.
> 
> Would be interesting if you can figure out which digital-mic component
> is used on your laptop (and if we can have any chip information by
> luck).

Well, as some manufacturers/types of digital microphones I found Akustica
(AKU 1126 / 2000 / 2001 / 2002 / 2004 / 2103), Analog Devices (ADMP421), National Semiconductor
(digital microphones, amplifiers LMV1024, LMV1026) [1], [2], [3] and
Andrea Digital Array Microphones.

ALC268 specs [4] say that they actually support interfacing
LMV1024/1026, SPD0205ND (what the heck is this one?), AKU2000.

Umm wait, Aspire One has ALC269. ALC269 datasheet doesn't say anything
about microphone manufacturers.

Note that eeepc models 901++ have ALC269 as well
and - surprise, surprise - an inverted noise cancellation issue as well!!!!!:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/331130

"Dreamcom 10 Laptop" [7]: " integrated Realtek HD audio processor, two
built-in Akustica digital microphones and two built-in stereo speakers"

This was the only reference up and down that I could find to _any_
notebook's microphone manufacturer listing. I suspect that
Aspire One has an Akustica microphone array as well since Akustica
seems to be the leading brand (hmm, any ideas about where the
second microphone is located if at all existing, but it must exist!!?
- probably at the front bottom?). 
Note that I found that the 16bit inverted data is NOT exactly a sum
of 0x10000, IOW those _are_ two _separate_, inverted streams of audio data
(for noise cancellation somehow I guess).
OH WAIT!! If most Acer models have _both_ microphones at the screen
bezel (left and right side) yet Aspire One has them (as I'd guess) at
the top of the bezel (known) and at the front bottom, then this would
mean - hold your breath - that the microphone array's physical properties
(regarding noise cancellation) are moved by 90 degrees,
possibly exactly explaining the malfunctioning (this would explain why
Aspire One and eeepcs have issues whereas other Aspire models
probably don't have them!?!?).
Hmm OTOH providing an audio source from somewhere on the
left side / right side of the netbook doesn't suddenly provide any audio,
thus it's probably a nice theory ;)
But OTOH the fact remains that those netbooks have a drastic microphone
geometry design change versus the normal Acer notebooks, thus it likely is
the reason for this issue somehow, somewhere.


Another very widely used brochure phrase was
"Acer PureZone technology with two built-in stereo microphones featuring
beam forming, echo cancellation, and noise suppression technologies"
I couldn't locate more pointers to details here though.


Insightful Apple OS X ALC269 adaptation descriptions: [5].

Windows Vista (ick!) microphone array discussions: [6].


[1]. http://www.national.com/nationaledge/apr03/article.html (background explanations!)
[2]. https://www.national.com/appinfo/amps/microphone.html
[3]. http://www.national.com/GER/news/item/1,4300,50,00.html
[4]. https://nmso.mdg.ca/specsheets/Intel_ALC268_Sound.pdf
[5]. http://ipis-osx.wikidot.com/internal-sound
[6]. http://windowsteamblog.com/blogs/windowsvista/archive/2007/11/09/microphone-arrays-digital-microphones.aspx
[7]. http://www.lcr-europe.org/meter/12/stereo+speaker.html


Andreas
