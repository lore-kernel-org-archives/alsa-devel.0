From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add stereo output
 support to audio jack
Date: Wed, 5 Jan 2011 16:39:00 +0000
Message-ID: <20110105163900.GD746@opensource.wolfsonmicro.com>
References: <1294242360-1903-1-git-send-email-jhnikula@gmail.com>
	<20110105155509.GC746@opensource.wolfsonmicro.com>
	<20110105182924.cf90b12c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9980E243AF
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 17:40:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110105182924.cf90b12c.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 06:29:24PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Having thought about it for at least a second I think we should have a
> > DAPM context in the cards for all the board-level stuff - does that seem
> > resonable?  The patch itself looks good:

> I don't know. Probably it would be good if machine widgets are in own
> context. Like having own debugfs/sysfs directory for them etc.

Yes, exactly.

> In this case it would be just enough if the tpa6130 is a codec driver
> having DAPM widgets. Then machine driver wouldn't need any these
> exported special tpa6130a2_ functions and soc-dapm could take care of
> power changes according to audio map and other info.

> But as far as I understood there's no any better way to get rid of pops
> in tpa6130a2.

As far as I remember from the previous discussion that had been that
making it a CODEC driver would be the simplest thing.  Peter said in
reply to my mail saying this:

| At least with my device I need to add some delay before enabling the amp, so
| anyway I need to ahve the DAPM_HP in the machine driver.

but it'd seem that the amp driver could do this just as well, possibly
based off platform data?
