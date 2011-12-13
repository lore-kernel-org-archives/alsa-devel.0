From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Rename ALC5632 MICBIAS to common
	name convention.
Date: Tue, 13 Dec 2011 14:28:50 +0800
Message-ID: <20111213062848.GB7148@opensource.wolfsonmicro.com>
References: <1323719025-18304-1-git-send-email-leon@leon.nu>
	<20111213013606.GB15314@opensource.wolfsonmicro.com>
	<CALq1K=+AjQAUwUn8N6JKY-nRGwC+qre=0_9J-FknRNsx1eJT6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03E88103A90
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 07:28:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=+AjQAUwUn8N6JKY-nRGwC+qre=0_9J-FknRNsx1eJT6w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2011 at 08:25:29AM +0200, Leon Romanovsky wrote:
> On Tue, Dec 13, 2011 at 03:36, Mark Brown

> > > +SND_SOC_DAPM_SUPPLY("MICBIAS1", ALC5632_PWR_MANAG_ADD1, 3, 0, NULL, 0),
> > > +SND_SOC_DAPM_SUPPLY("MICBIAS2", ALC5632_PWR_MANAG_ADD1, 2, 0, NULL, 0),

> > What does the datasheet say the pins are called?
> MICBIAS
> http://ac100.wikispaces.com/file/view/alc5632_micbiases.PNG/285333934/alc5632_micbiases.PNG

OK - you should've said this in your changelog, that's what the
convention is, to use the pin names.
