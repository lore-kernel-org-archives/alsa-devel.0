From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 17:00:43 +0000
Message-ID: <20100322170043.GB16836@rakim.wolfsonmicro.main>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003221646.08974.peter.ujfalusi@nokia.com>
	<20100322150602.GD1379@rakim.wolfsonmicro.main>
	<201003221731.14380.peter.ujfalusi@nokia.com>
	<20100322161928.GA30295@rakim.wolfsonmicro.main>
	<1269276514.3754.21.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EFC4510385E
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 18:00:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269276514.3754.21.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 22, 2010 at 04:48:34PM +0000, Liam Girdwood wrote:

> I think Peter means that without making changes to the current IO model
> or reverting the removal of the old PGA code there is no generic way of
> handling this atm.

Well, you need to add new control types anyway so they know not to do
the writes so making them DTRT is fairly trivial.

> So we should probably look at bringing back the PGA code (now that there
> is a user) so that the patch can be updated to use it.

The issue with the old PGA code is that it's fundamentally mono but a
substantial proportion of the output paths really are stereo and want to
export stereo control to userspace but DAPM is pretty much mono all the
way.  Decoupling the mute from the PGA solves that, and lets us use this
with other widget types if that's useful (though virtual PGAs could
cover that too).
