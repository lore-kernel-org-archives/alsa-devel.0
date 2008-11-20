From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: twl4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 14:14:01 +0000
Message-ID: <20081120141401.GG4539@sirena.org.uk>
References: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
	<200811201602.44035.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FC08243A8
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:14:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811201602.44035.peter.ujfalusi@nokia.com>
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
Cc: ext naveen krishna ch <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 04:02:43PM +0200, Peter Ujfalusi wrote:

> My plan is to add _all_ (ok, almost all) the features we can get with
> TWLx030...
> So instead of having 'only' one possible route from DACl2/DACR2, I have
> implemented in a reverse order:

...

> With this mode one can enable whatever combination of routing he/she
> needs from TWL.

> Since these channels are really 'independent' inside of TWL, making the
> routing/mixing flexible (you might say extremely flexible) could make
> sense.

This is good - an ASoC codec driver should expose as much functionality
of the codec as possible and let user space configure it at runtime.
See for example the WM8900 or WM8990 drivers for examples of codecs with
fairly complex audio routing.

> CCing: Steve Sakoman who actually wrote the driver - could cc Mark Brown
> as well, but it seams that he is reading alsa-devel quite frequently ;)

It's still useful to keep people in CCs - it's not so bad with
alsa-devel but it does help to ensure that things don't get missed on
high volume mailing lists.
