From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 29 Jun 2011 09:52:13 +0100
Message-ID: <4E0AE7BD.4080801@canonical.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E0A00E3.5000102@canonical.com> <s5hr56dykve.wl%tiwai@suse.de>
	<4E0AD0A6.7010901@canonical.com>
	<20110629072011.GB25977@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EBA3110386D
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 10:52:16 +0200 (CEST)
In-Reply-To: <20110629072011.GB25977@opensource.wolfsonmicro.com>
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

On 2011-06-29 08:21, Mark Brown wrote:
> On Wed, Jun 29, 2011 at 08:13:42AM +0100, David Henningsson wrote:
>
>> However, if we manage to expose all the routing between PCMs, volume
>> controls and ports, we can make an even better PulseAudio, because
>> we can solve other problems as well, such as the volume control
>> naming problem. But figuring out how to do that in the best way
>> API-wise and so on, I guess that will take some time.
>
> This is really a totally separate question,

The question is not totally separate as if we design an ALSA API, we 
might have this in the back of our minds in order to not build an API 
when adding this information later will be very difficult.

> there's so much routing
> within the devices that the jacks are just not a particularly
> interesting part of it.

I'm probably misunderstanding you here, because that sounds crazy. What 
sense would it make to display a routing graph if the jacks are not part 
of that graph?

>>> If only the same functionality is required as currently done in the
>>> input-jack layer, re-implementing the jack-detection elements in ALSA
>>> control API is pretty easy.
>
>> Yes, but it is not clear to me that this is the decision, and what
>> we actually want to do. So far I have only seen Kay and Lennart
>> advocating for it and Mark against it. I started off this thread
>> because I needed a decision, but so far no clear decision has been
>> made.
>
> I'm not against having the information in ALSA, or really against using
> separate APIs.

Ok.

> My main concern is being able to group the objects back
> together again for use both in kernel (when the hardware overlaps) and
> in userspace in an understandable fashion and I've not seen anything
> that I'm as comfortable with as a directly visible object exported from
> the kernel.

I'm not following. For userspace, you need to match the input layer 
against an ALSA sound card. You need to do that regardless of whether 
the buttons and the jacks are in the input layer, or if only the buttons 
are there. No difference in difficulty as I see it.

For the kernel part, I guess that if ASoC core (or ALSA core) is 
responsible for the splitting, and that the actual driver has an object 
covering both types of input (i e both jacks and buttons), that would be 
the most obvious way to solve the problem.

> I do have to say I like not having to use alsa-lib to get the
> information but that's even less of a big deal.

Ok, is that because Android does not use alsa-lib?

-- 
David Henningsson
http://launchpad.net/~diwic
