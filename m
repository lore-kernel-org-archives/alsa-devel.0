From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 28 Jun 2011 23:59:41 -0700
Message-ID: <20110629065940.GA25977@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E0A00E3.5000102@canonical.com> <s5hr56dykve.wl%tiwai@suse.de>
	<20110629025916.GA22472@opensource.wolfsonmicro.com>
	<s5h39ittd4c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C05C010385C
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 08:59:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h39ittd4c.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2011 at 07:34:11AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It needs a subset of the current information - it should report only
> > audio events, so pretty much only headphone, microphone or line out
> > presence.

> Is that really all for PA, for now, and even for future?
> That's my primary question.  Was this clarified in the thread...?

Well, that was what Kay and Lennart were keen on - the information for a
given subsystem should be reported via that subsystem so all the other
information we're reporting currently should be going via some other
subsystem.  

Like I keep saying I still don't have a clear picture as to how this
would actually be implemented in userspace and how practical it is.

> >  Anything else needs to be reported via a different API and
> > figured out by userspace, and the input device should stay there for
> > button press events.

> The first and the second part are independent, IMO.
> That is, whether using the input-jack device in future is an open
> question.  It might be better to re-implement in a new API in a
> unified way, for example.

You're missing my point here.  The point is not the switches, the point
is the buttons on the jacks - they need to go via the input API and not
the ALSA API.

> Of course, keeping the old API is mandatory, so we'll still keep
> the input-jack code in future, though.

That too.
