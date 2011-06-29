From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 29 Jun 2011 00:21:48 -0700
Message-ID: <20110629072011.GB25977@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E0A00E3.5000102@canonical.com> <s5hr56dykve.wl%tiwai@suse.de>
	<4E0AD0A6.7010901@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A173824718
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 09:21:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0AD0A6.7010901@canonical.com>
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

On Wed, Jun 29, 2011 at 08:13:42AM +0100, David Henningsson wrote:

> However, if we manage to expose all the routing between PCMs, volume
> controls and ports, we can make an even better PulseAudio, because
> we can solve other problems as well, such as the volume control
> naming problem. But figuring out how to do that in the best way
> API-wise and so on, I guess that will take some time.

This is really a totally separate question, there's so much routing
within the devices that the jacks are just not a particularly
interesting part of it.

> >If only the same functionality is required as currently done in the
> >input-jack layer, re-implementing the jack-detection elements in ALSA
> >control API is pretty easy.

> Yes, but it is not clear to me that this is the decision, and what
> we actually want to do. So far I have only seen Kay and Lennart
> advocating for it and Mark against it. I started off this thread
> because I needed a decision, but so far no clear decision has been
> made.

I'm not against having the information in ALSA, or really against using
separate APIs.  My main concern is being able to group the objects back
together again for use both in kernel (when the hardware overlaps) and
in userspace in an understandable fashion and I've not seen anything
that I'm as comfortable with as a directly visible object exported from
the kernel.  If ALSA chooses to export some subset of the information
that's kind of orthogonal to that issue.

I do have to say I like not having to use alsa-lib to get the
information but that's even less of a big deal.
