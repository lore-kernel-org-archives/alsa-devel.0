From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 30 Jul 2009 21:55:46 +0300
Message-ID: <20090730215546.4e184112.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<20090730135257.GE9975@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id CFA8A2442F
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 20:54:54 +0200 (CEST)
Received: by ewy8 with SMTP id 8so322701ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2009 11:54:53 -0700 (PDT)
In-Reply-To: <20090730135257.GE9975@sirena.org.uk>
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, Eduardo Valentin <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Jul 2009 14:52:57 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Jul 30, 2009 at 03:49:23PM +0300, Eduardo Valentin wrote:
> 
> > Patches 1-15 are McBSP changes and, for this reason, are intended to
> > be include in linux-omap tree.
> > Patches 16-20 are OMAP ASoC driver changes, so, they are for
> > alsa-devel.
> 
> I'm OK with the ASoC changes.  It looks like there are some
> dependencies on the OMAP changes in there so they should probably go
> via the OMAP tree?

Is Peter available or having a vacation? He would have better
possibilities to say and test the PM changes. Now omap_pcm_pointer is
very accurate and I would like that it remains accurate unless user
especially wants low-power over it.

I post few, more like minor notes than show stoppers to some of these
patches.

My wife and kids are having vacation so my ability to review, test and
understand those more fundamental changes is somewhat reduced.


-- 
Jarkko
