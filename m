From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Alsa Driver on Coldfire
Date: Fri, 18 Apr 2008 12:23:41 +0100
Message-ID: <20080418112340.GB19457@rakim.wolfsonmicro.main>
References: <op.t9swu605hpbl6d@derby> <s5hwsmvea38.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 133A624ACC
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 13:23:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwsmvea38.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Simon Dunn <sdunn@mpc-data.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 12:22:35PM +0200, Takashi Iwai wrote:
> Simon Dunn wrote:

> > I've been given the job of writing a sound card driver using the alsa  
> > architecture for a
> > development platform that uses a coldfire chip.

> > on the web in general, so I'm wondering if anybody knows why the M68K  
> > architecture is
> > excluded?

> I don't remember exact reason, too.  It was so when ALSA was merged,
> IIRC.

I think I'd formed the impression from somewhere or other (probably
related to Debian m68k) that it was that there were no relevant drivers
for m68k that had been ported to ALSA so there wasn't much point
building it.  I could be misremembering, though.

With regard to ColdFire I'm guessing that this is an embedded system?
If so you might want to have a look at working with the ASoC framework
(see sound/soc and Documentation/sound/alsa/soc).
