From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 14:05:49 +0100
Message-ID: <20100722130548.GI4737@rakim.wolfsonmicro.main>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<A1C7E76B4973664FBB6C554A75234AC62BEEEB72A5@NOK-EUMSG-02.mgdnok.nokia.com>
	<20100722120208.GF4737@rakim.wolfsonmicro.main>
	<A1C7E76B4973664FBB6C554A75234AC62BEEEB72A7@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FC2024451
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 15:05:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A1C7E76B4973664FBB6C554A75234AC62BEEEB72A7@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: matti.j.aaltonen@nokia.com
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 02:11:27PM +0200, matti.j.aaltonen@nokia.com wrote:

> >You've still not provided any information about what use this will be
> >put to.

> Yes, sorry I didn't get your point. I guess I tought that it's irrelevant, what
> the soc_card driver actually does. But it actually does this:

OK, so the DAI format for the CODEC changes dependant on the mode.  For
this I'd suggest just changing the function to actually export the DAI
format directly rather than requring all users to replicate the lookup
you've currently got in your driver.  This makes it clear what the
purpose of providing the export is and avoids external drivers needing
to know too much about the internals of this one.

In terms of what's relevant if someone's asking questions like this
they're normally trying to figure out what your high level goal is
because your code looks suspicous and are trying to understand the
purpose of the code so they can suggest a way of doing things that is
more in line with the intentions of the surrounding code.
