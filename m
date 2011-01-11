From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Tue, 11 Jan 2011 17:28:40 +0000
Message-ID: <20110111172839.GE13429@opensource.wolfsonmicro.com>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
	<20110111171013.GK6541@sirena.org.uk>
	<s5hlj2r9x52.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E2D510386E
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:30:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hlj2r9x52.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 06:18:49PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Hrm, it'd be better to find some annotation for the pointer which lets
> > us have the reference.  We at a higher level only dereference the
> > pointer from the probe path, preventing the discard isn't a great
> > solution.

> Nah, that's way too complex for the time being.  I really prefer a
> warning-less code for such a case.

The array is ~25k so it's not a completely trivial amount of memory,
unfortunately.

> The whole __init stuff have lots of potential improvements.  But,
> improving it would cost pretty much.  And we don't want yet another
> new annotation...

Very true.  The other option is to refactor all the data structures to
appease it which is painful.
