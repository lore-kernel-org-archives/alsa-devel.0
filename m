From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: add support for
	multiple	cards/codecs in debugfs
Date: Wed, 30 Sep 2009 13:39:38 +0100
Message-ID: <20090930123938.GC12101@sirena.org.uk>
References: <1254306259-8098-1-git-send-email-peter.ujfalusi@nokia.com>
	<1254306259-8098-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090930104628.GA12101@sirena.org.uk>
	<200909301421.46742.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B2968103805
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 14:39:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200909301421.46742.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 30, 2009 at 02:21:46PM +0300, Peter Ujfalusi wrote:

> Yes, when I have moved to 2.6.31 it was kind of weird to have the 
> snd_soc_init_card(socdev) called from the codec driver itself, which I still not 
> feel too comfortable with...

That was always happening anyway, the function just got renamed.

> I have in my board two codecs, using separate sound cards for each.
> One card - one codec.
> So far DAPM and in general ASoC behaved quite well in all possible scenarios.

I can't remember off-hand what they are but there are some issues you'll
run into if you look hard enough - I certainly wouldn't say that it's a
supported configuration.  Device probe/removal is where the issues are
if I remember correctly, it can work but it's fragile.

> Btw. do you have some information about this upcoming reorganization, to see 
> what is coming?

Probably from an external point of view it'll have a dev_name added to
all the strings in the DAPM maps for deduplication when used in the
board drivers (which are the only things that ought to need to know
about more than one device).  For the cards the soc-audio device will go
away and the card device will be used directly, possibly with only the
DAIs being directly referenced from the machine driver.

It's much more of an upheaval internally.

> All of that being said, it would be still nice to at least fix the current 
> situation in some way, since the current implementation is clearly not behaving 
> correctly.

> Does it help, if I use the dev_name() instead of the codec->name for the 
> directory for now?

I'd use both, the dev_name() is rather illegible by itself.
