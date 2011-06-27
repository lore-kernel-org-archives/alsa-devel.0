From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 27 Jun 2011 13:07:44 +0100
Message-ID: <20110627120743.GA20707@sirena.org.uk>
References: <4DFF4D15.6050809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09298244E6
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 14:07:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DFF4D15.6050809@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:

> 1) We're continuing the path with /dev/input devices

> 2a) We'll rewrite these devices to be read-only ALSA mixer controls

> 2b) We'll rewrite these devices to be something within ALSA, but not 
> exactly mixer controls.

> For options 2a) and 2b) I guess the existing /dev/input thing should be 
> deprecated and/or removed. So part of decision should maybe be based on 
> information about how widespread the usage of these devices are 
> currently...?

So, this discussion seems to have ground to a halt.  Summarising briefly
it seems that Lennart and Kay both seem adamant that they don't want a
unified jack object visible to userspace, they want to glue the objects
together via some implicit means.  Lennart mentioned that there is some
support for at least some of this functionality in PulseAudio already
but didn't provide any details yet - does anyone else know what happens
here or have time to go look at the code?

In kernel I'm concerned that we'll still need to have a unified object
due to the need to share the detection between multiple subsystems, if
one driver can report for multiple subsystems.  This seems likely to
mean that we'll end up with some sort of in kernel object for many if
not all jacks.

I'm also concerned that an implicit system may be hard to use from
userspace, if only in terms of figuring out what the rules are for
matching things up.
