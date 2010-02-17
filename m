From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 00:43:08 +0000
Message-ID: <20100217004308.GC23623@sirena.org.uk>
References: <alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 766852452A
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 01:43:09 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1NhY0T-0000Xr-3X
	for alsa-devel@alsa-project.org; Wed, 17 Feb 2010 00:43:09 +0000
Content-Disposition: inline
In-Reply-To: <20100217001047.GB6766@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 01:10:47AM +0100, Lennart Poettering wrote:
> On Wed, 17.02.10 12:47, Eliot Blennerhassett (linux@audioscience.com) wrote:

> > For our cards this is adjustable, but lets say for consumer cards it is
> > fixed.  This information is not currently available via the ALSA
> > API.

> I wonder how realistic it would even be to add an API for
> this. i.e. can we even know the refernce level? On many cards most
> likely not. For example, for my integrated USB speakers speaking of a
> reference voltage would already be misleading...

Like you say even where we know the actual level it's not practically
useful unless it's physically exposed somewhere the user can see it.

For things like line jacks where it is relevant these things do actually
get documented relatively often, and obviously measurements are possible
where they aren't.  I'm not sure how interesting it is unless the system
also supports configuration, though.
