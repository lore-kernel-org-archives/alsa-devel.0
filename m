From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
	and ARM9 atmel boards.
Date: Mon, 6 Oct 2008 09:04:33 -0500
Message-ID: <200810060904.33431.geoffrey@pager.net>
References: <48E47D42.8080306@atmel.com> <48E62A89.8070803@atmel.com>
	<20081003143523.GE26035@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.30])
	by alsa0.perex.cz (Postfix) with SMTP id 0387F24459
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 16:05:11 +0200 (CEST)
Received: from mail.pager.net (lrs-ad1.longragesystems.local [192.168.1.254])
	by barracuda.pager.net (Spam Firewall) with ESMTP id C0376539CA
	for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2008 09:04:33 -0500 (CDT)
Received: from mail.pager.net (lrs-ad1.longragesystems.local [192.168.1.254])
	by barracuda.pager.net with ESMTP id fZBPlDLtAzPNBJkP for
	<alsa-devel@alsa-project.org>; Mon, 06 Oct 2008 09:04:33 -0500 (CDT)
In-Reply-To: <20081003143523.GE26035@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Friday 03 October 2008 09:35:24 am Mark Brown wrote:
> On Fri, Oct 03, 2008 at 04:22:01PM +0200, Sedji Gaouaou wrote:
> > If you are talking about the API to access ssc(ssc_writel and
> > ssc_readl), it was basically why I needed a new driver in the first
> > place. Indeed we wanted to use the same API across all atmel platforms.
>
> OK, that's good.  It'd be helpful if you could mention this in your
> patch descriptions - at the minute there's very little detail there
> which makes issues like this less clear than they could be.
>
> I'd still like to see this tested at least somewhat on AVR32, just to
> make sure.  Even a build test would be good.

Argh!  I was expecting to have to deal with some bitrot when I tried the patch 
on Friday, but instead I got board rot.  My board won't fire up properly 
anymore.

Has anyone here with an AVR32 toolchain tried to compile the patch, or do I 
need to go ahead and at least do this?

---
Geoffrey
