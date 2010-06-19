From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 20:57:53 +0200
Message-ID: <20100619185753.GN17833@buzzloop.caiaq.de>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
	<20100619174259.GJ17833@buzzloop.caiaq.de>
	<AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>
	<20100619180956.GL17833@buzzloop.caiaq.de>
	<AANLkTikfeTzrOttiyI9BqqD3zHI7NXY8ScyXoY8Ruq8N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D45924631
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 20:57:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikfeTzrOttiyI9BqqD3zHI7NXY8ScyXoY8Ruq8N@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jordan johnston <triplesquarednine@gmail.com>
Cc: alsa-devel@alsa-project.org, Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Jun 19, 2010 at 02:30:03PM -0400, jordan johnston wrote:
> On Sat, Jun 19, 2010 at 2:09 PM, Daniel Mack <daniel@caiaq.de> wrote:
> 
> > (please don't remove any addresses from Cc:)
> 
> im not sure that  i follow what you mean here, can you explain???

Always use your email client's "reply-to-all" function, and do not just
send replies to me.

> ***  no i did not modify the driver to match this,  how do i do that???

Sorry, I didn't check properly. The driver clearly notes the
vendor/product ID of your device, that's why it is probed but fails.

This was added in commit 2b6f6c0d11 ("ALSA: snd-usb-us122l: add product
IDs of US-122MKII and US-144MKII"). Obviously, this patch wasn't tested
with real hardware (this is also what the commit log says), so it's no
surprise it doesn't work for you. I copied the author, and I'd vote for
reverting the patch until the driver is modified to actually support
what it claims to do.

> I set it to USB1.1  because i was under the impression that it will
> not work with echi_hcd,
> am i correct??

Well, according to the lsusb dump, the device is high-speed, so you
shouldn't need any tricks.

> my problem is that there really isn't any documentation that's
> up-to-date for this unit, the newest info i could find
> was a thread about the patches being submitted in December of last
> year.  but i figure by now that Zen should be up to date
> with the changes made, so i am still in the dark about this unit's status..

Who is Zen?

I think the answer to your question is quite simple but unfortunate:
TASCAM changed the protocol of the device in a newer version, and the
existing ALSA driver became incompatible with that. So there are only
two possibilites to fix this: either TASCAM will send patches to the
driver (which I think is unrealistic), or someone starts over and
reverse-engineers the protocol in order to make the driver support it.

As you happen to have the hardware - would you volunteer? :)

> Do you have contact information for him??  i am not sure how to go
> about the next steps you mention,
> but i would be more than willing to do what i can, if i was explained
> the process.
> like i said before i am not a good programmer, but i am decent enough
> with unix/linux and i do have XCode
> for OSX - if that's what i need for tracing?

Well, starting developing on the Linux kernel should be possible for you
then, and help is much appreciated :) There's a lot of documentation
around, and there is this and many other lists to get help on specific
topics. Just read Documentation/SubmittingPatches before you send :)

For tracing, you would either need a hardware analyzer (which you
probaly don't have) or a software tool. For Windows, tools like
http://www.usblyzer.com/ exist, but I never tried them myself. Maybe
give that one a try and analyze which packets go over the bus. As there
is no documentation, there is no other way than guessing what they're
doing. This can be really time-consuming and frustrating, unfortunately.

Good luck :)

Daniel
