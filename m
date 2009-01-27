From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 15:25:57 +0000
Message-ID: <20090127152556.GF11870@sirena.org.uk>
References: <200901271519.47119.anarsoul@gmail.com>
	<20090127150040.GD11870@sirena.org.uk>
	<200901271720.03880.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A4C81037F0
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 16:25:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901271720.03880.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 05:19:53PM +0200, Vasily Khoruzhick wrote:

> Uh-oh, I didn't thought that it will be so complicated to decide when turn one 
> gpio line to 0 or 1 :) Btw, I'm thinking about using own write- and read- 
> wrappers for uda1380, in this way I can check on each read/write whether 
> codec power is enabled.

Are you really cutting all power to the codec or just the analogue
supplies?  Normally the digital is powered off a separate supply shared
with other bits of the system.

> > That sounds like something in the teardown path should be done on
> > startup as well.  Can't think of any obvious gotchas there, though I'd
> > be looking at the codec and machine drivers since the CPU driver for the
> > S3C24xx is used in quite a few designs.

> Sorry, but what is "teardown path"?

When playback is stopped.
