From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 30 Jul 2009 20:11:01 +0100
Message-ID: <20090730191101.GA23214@rakim.wolfsonmicro.main>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<20090730135257.GE9975@sirena.org.uk>
	<20090730215546.4e184112.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4C9A2414D
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 21:11:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090730215546.4e184112.jhnikula@gmail.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, Eduardo Valentin <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 30, 2009 at 09:55:46PM +0300, Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 14:52:57 +0100
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > I'm OK with the ASoC changes.  It looks like there are some
> > dependencies on the OMAP changes in there so they should probably go
> > via the OMAP tree?

> Is Peter available or having a vacation? He would have better
> possibilities to say and test the PM changes. Now omap_pcm_pointer is
> very accurate and I would like that it remains accurate unless user
> especially wants low-power over it.

No idea; I've not seen him recently but there's not been much TWL4030 or
OMAP activity so that's not surprising.  It'd be nice (but not essential)
to be able to automatically dial back the accuracy when given enormous
buffers to play since that's normally a good indication that the data is
non-critical.

> My wife and kids are having vacation so my ability to review, test and
> understand those more fundamental changes is somewhat reduced.

I've no OMAP hardware I can readily do anything with so you're probably
still ahead of me for the OMAP-specifics.
