From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 20:53:46 +0200
Message-ID: <4DFF973A.1080404@canonical.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CD091038A7
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 20:53:47 +0200 (CEST)
In-Reply-To: <20110620170739.GD32056@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 2011-06-20 19:07, Mark Brown wrote:
> On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:
>> As part of that I wrote a udev patch a few days ago, which nobody
>> commented on in alsa-devel [1], but was somewhat disliked by at
>
> Having dug out the mailing list archive I guess the fact that you just
> posted it to the list and didn't CC anyone on the patch didn't help
> here.

Therefore I cc:ed more people on this thread, which seems to at least 
got more attention, but risk falling into the ditch of endless 
discussion instead. Please prove me wrong :-)

> Looking at the patch the main thing that jumps out at me without
> any knowledge of the udev code is that the patch will end up classifying
> video output jacks as audio even if they've no audio capability which is
> obviously not correct.

In suggested implementation, they will only be marked audio jacks if 
their parent object is a sound card.

> I still don't entirely understand the technical issue you're trying to
> address here - this doesn't seem specific to audio.

I think this is a difference between embedded space and desktop space. 
In embedded space, a hardware designer can decide to connect the "take a 
camera picture" button to "line in jack detect" just because that saves 
him an extra GPIO chip (and "line in" isn't connected anyway). Those 
things don't happen on normal PC [1], but instead, things must be 
auto-detectable.

> As far as I can
> tell the issue is that some of the input devices on the system aren't
> being made available to the console user, presumably because there are
> some that shouldn't be made available to them, so the issue is that the
> heuristics that udev uses to decide if an input device should be root
> only aren't working correctly in at least this case.  It feels like if
> we understood why the heuristics are making a bad call here we might be
> able to come up with a better solution.

AFAICT, the current "heuristics", is to assign all input devices to root 
and root only.

>> For options 2a) and 2b) I guess the existing /dev/input thing should
>> be deprecated and/or removed. So part of decision should maybe be
>> based on information about how widespread the usage of these devices
>> are currently...?
> There's a reasonable amount of usage in the embedded space.

But maintaining two different implementations of input jacks without at 
least strongly deprecating one of them, lead to application programmers 
being confused, kernel being big and bloated, and so on...

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] Just because I said so, presumably someone comes up with a story 
about a PC vendor who has actually done just that...
