From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: The best-supported Pro Audio device?
Date: Wed, 27 Aug 2003 20:08:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308280008.h7S08OmC025251@oud>
References: <613233.1062002163618.JavaMail.nobody@wamui09.slb.atl.earthlink.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 27 Aug 2003 12:36:03 EDT."
             <613233.1062002163618.JavaMail.nobody@wamui09.slb.atl.earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ametts2@mindspring.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>--*-- What is the best-supported *Pro Audio* device in terms of solid ALSA dri
>ver support?  Not interested in Sound Blasters and chips on the motherboard --
> something along the lines of the Echo, M-Audio, or RME products.  But the ALS
>A drivers need to be stable -- and need to fully support the capabilities of h
>e respective device (i.e., on-board DSP, MIDI, or whatever).

the echo drivers are extremely new, and largely untested at this
point. they may even be incomplete.

the m-audio drivers are probably the oldest, and have been widely
tested. i don't know how well they support the latest incarnations of
the ice17XX chipsets. there is also a good control application for
these interfaces.

the rme drivers (i was the initial primary author) are stable and
complete for the original hammerfall series. they have been evolving
for the hdsp series. slightly older hdsp cards will work well, as do
newer kernels when used with the pcmcia interfaces (since this tends
to require up-to-date support for CardBus devices in the kernel as
much as anything specifically related to the hdsp). as with many
companies, rme unfortunately does not keep us 100% up to date on what
they are doing with their interfaces, and so as they change the
firmware it turns out that we lag behind, typically by a few
weeks. thomas charbonnel has done some fantastic work implementing
totalmix for linux, and so the only "hole" at the moment for these
cards appears to involve some issues with MIDI performance (and
firmware lags)

>--*-- Same question, smaller footprint:  If you were going to buy a modern lap
>top for use with ALSA, what would you buy?   What has the best chipset, with t
>he best ALSA driver support?

having no real laptop experience, i'll leave this to someone else. but
i would add that given your first question, i would forget about the
onboard chipset and use a hammerfall pcmcia interface.

Paul Davis <paul@linuxaudiosystems.com>                 Bala Cynwyd, PA, USA
Linux Audio Systems                                             610-667-4807
----------------------------------------------------------------------------
hybrid rather than pure; compromising rather than clean;
distorted rather than straightforward; ambiguous rather than
articulated; both-and rather than either-or; the difficult
unity of inclusion rather than the easy unity of exclusion.   Robert Venturi
----------------------------------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
