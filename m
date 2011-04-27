From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Allow platform drivers to
	have	no ops structure
Date: Wed, 27 Apr 2011 20:05:03 +0100
Message-ID: <20110427190503.GF12249@sirena.org.uk>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<BANLkTimJvDiXxX1GXrHGEZ0kDe3aNMX3pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3268D243EB
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 21:05:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimJvDiXxX1GXrHGEZ0kDe3aNMX3pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 12:17:46AM +0530, Jassi Brar wrote:

Please delete unneeded context, makes it much easier to find your
text...

> I have nothing against this approach, but just a thought...
> Is there any option like having 'dummy' versions of cpu,
> codec and dma dais, maybe ops too, and have machine
> drivers explicitly use them. That will preserve what has always been
> expected off of ASoC drivers and keep the
> core 'simple' (not to mean the checks you add above are
> serious overhead).

I considered that, my thought was mostly that it's better for the core
to do a bit of work than for each user to have to do typing.  I'd
probably have gone the other way if we weren't already having to check
to see if the op itself was there - this is why there's a dummy driver
created and substituted in where there's no platform at all.  Had I done
the second patch first I'd probably never have written this one but it
seemed like something someone might come up with another sane use case
for some time.

In the DAIs we're actually substituting a dummy ops in but we shouldn't
really be doing that as it ought to be possible for the drivers to be
const.
