From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Fri, 19 Feb 2010 09:40:26 +0000
Message-ID: <20100219094026.GK2032@sirena.org.uk>
References: <20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5063610391D
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 10:40:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 19, 2010 at 09:17:01AM +0100, Jaroslav Kysela wrote:
> On Thu, 18 Feb 2010, Lennart Poettering wrote:

> > I'd really prefer if those boost switches would be turned into binary
> > volume elements which carry normal dB information like any other
> > volume element. After all they are just a volume element, with only
> > two steps.

> I like this idea.

Me too, in fact I've already been doing it for drivers I've been working
on.
