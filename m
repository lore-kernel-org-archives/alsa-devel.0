From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Sharing PXA SSP ports
Date: Wed, 22 Jun 2011 14:10:36 +0100
Message-ID: <20110622131036.GH23666@sirena.org.uk>
References: <BANLkTikxz95HyKt0+0gjeByNah0-N+vBLg@mail.gmail.com>
	<20110622130517.GF23666@sirena.org.uk>
	<BANLkTikKiXtzHPbn1JqQJvJxfWG7d=pV1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BD9EF1039E6
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 15:10:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikKiXtzHPbn1JqQJvJxfWG7d=pV1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 03:09:06PM +0200, Daniel Mack wrote:
> On Wed, Jun 22, 2011 at 3:05 PM, Mark Brown

> > This seems like the DAI driver should deal with things. ?It needs to
> > join up the input and output paths anyway as there's shared clocks and
> > so on.

> So does it need modification, or do you say it should work already? I
> can care for fixing this up if necessary - is there any other DAI
> driver that does that and that could serve as an example?

There's probably some of the i.MX drivers doing this.  Depending on the
driver and hardware implementation it can just work with no special
code.
