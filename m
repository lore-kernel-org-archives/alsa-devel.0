From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 13:06:23 +0000
Message-ID: <20100217130623.GD2032@sirena.org.uk>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<ad2655cb1002170355n7d2df930ha6cf036b6e00218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E6CF103889
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:06:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ad2655cb1002170355n7d2df930ha6cf036b6e00218@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 11:55:17AM +0000, James Courtier-Dutton wrote:
> On 16 February 2010 23:56, Lennart Poettering <mznyfn@0pointer.de> wrote:
> >
> > The reason I was asking how Jaroslav chose the 0dB position for his
> > measurements was purely because I wanted to do my own measurements for
> > that Aureon card. The dbmeasure tool I wrote for stuff like that puts
> > 0dB at max amplification, however Jaroslav didn't, so I was wondering
> > how he chose 0dB then.
> >
> > Lennart
> >
> 
> I think the digital side is clear. So I will not go into that.
> 
> I think we need to separate the analogue side into a number of categories:
> 1) Standard consumer line-out levels.
> 2) Standard pro line-out levels.
> 3) Consumer line-in levels.
> 4) Pro line-in levels.
> 5) Consumer mic levels.
> 6) Pro mic levels.
> 7) Consumer speaker levels.
> 8) Pro speaker levels.

There's also headphones there, though for both speakers and headphones
it's questionable if we want to do anything.

> On the analogue side, I believe the 0dB gain point is intended to be
> the point at which one can be fairly sure that the distortion will be
> low for a sensible full scale input.

Generally 0dB is pass through (which does also tend to be the optimal
performance point).  Actual expected gain levels will vary depending on
application - for example, a microphone input will usually need an
amplifier with fairly high gain in the path to get the signal to a level
usable by the rest of the system.
