From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 16:48:34 +0000
Message-ID: <1269276514.3754.21.camel@odin>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003221646.08974.peter.ujfalusi@nokia.com>
	<20100322150602.GD1379@rakim.wolfsonmicro.main>
	<201003221731.14380.peter.ujfalusi@nokia.com>
	<20100322161928.GA30295@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 564CE10385E
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 17:48:41 +0100 (CET)
Received: by pxi7 with SMTP id 7so2051359pxi.5
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 09:48:40 -0700 (PDT)
In-Reply-To: <20100322161928.GA30295@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-03-22 at 16:19 +0000, Mark Brown wrote:
> On Mon, Mar 22, 2010 at 05:31:14PM +0200, Peter Ujfalusi wrote:
> 
> > How I see this: we can go and introduce new controls, DAPM widgets for all type 
> > just for the sake of the TWL codec. But at the end it will be still TWL 
> > specific.
> 
> > I'm not saying that other codecs could not use some generic way (in a way, that 
> > you have described) to make their amps muted when they are not needed.
> > What I'm saying, is that I don't see a generic way which can handle the TWL 
> > codec.
> 
> Could you please be more specific about what you believe is going on
> with TWL4030 here?  It would really help if you could be more specific
> about how you see the register cache getting updated.

I think Peter means that without making changes to the current IO model
or reverting the removal of the old PGA code there is no generic way of
handling this atm.

So we should probably look at bringing back the PGA code (now that there
is a user) so that the patch can be updated to use it.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
