From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Export functions for
 threshold configuration
Date: Mon, 12 Mar 2012 12:10:30 +0000
Message-ID: <1331554230.13303.14.camel@odin>
References: <1331550064-28349-1-git-send-email-peter.ujfalusi@ti.com>
	<20120312115954.GF3110@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog134.obsmtp.com [74.125.149.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 338B7103F60
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 13:10:46 +0100 (CET)
Received: by werj55 with SMTP id j55so4115408wer.14
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 05:10:32 -0700 (PDT)
In-Reply-To: <20120312115954.GF3110@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-03-12 at 11:59 +0000, Mark Brown wrote:
> On Mon, Mar 12, 2012 at 01:01:04PM +0200, Peter Ujfalusi wrote:
> > ABE has certain requirements towards the FIFO configuration in McBSP.
> > Make it posssible to configure the McBSP FIFO threshold from outside of
> > the McBSP driver stack.
> 
> You should always submit things like this along with the changes which
> use them, it's much easier to see if they're sensible when the users are
> there.  Without seeing how this is used it's hard to tell if this is
> sensible or if it should be abstracted in some way and we don't want to
> have half of the bodges sitting around if we end up doing things a
> different way.

I agree, but in this case the ABE series will be huge. We're trying to
break this into smaller and more digestible chunks rather than a massive
series. 

The commit message here should have been more descriptive and described
the ABE use case.

Liam
