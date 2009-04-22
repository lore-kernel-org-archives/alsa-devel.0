From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: OMAP: Add checking to
	detect	bufferless pcms
Date: Wed, 22 Apr 2009 10:26:18 +0100
Message-ID: <20090422092618.GC10356@sirena.org.uk>
References: <49EE7962.6080008@samsung.com>
	<bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
	<20090422084349.GB10356@sirena.org.uk>
	<bd7b27490904220201u2c9da4dgce14c2da368f0f08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AAFC24646
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 11:26:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490904220201u2c9da4dgce14c2da368f0f08@mail.gmail.com>
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
Cc: kyungmin.park@samsung.com, peter.ujfalusi@nokia.com, alsa-devel@alsa-project.org, bhmin@samsung.com, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2009 at 12:01:28PM +0300, Jarkko Nikula wrote:
> On Wed, Apr 22, 2009 at 11:43 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > The host isn't transferring any data at all in these cases.  Ideally
> > we'd support multiple platforms and there'd be a dummy platform driver
> > to go with the dummy DAI driver.

> Probably it's better to extend this patch to other architectures as well (at
> least DaVinci) where possible in order to be more consistent. I just noticed
> that also PXA is having the same feature.

Yes, though given that it's a bodge at the moment it'd need someone to
go through per architecture and check that the right thing is being
done.

When I've thought about doing it I've always decided it'd probably be
less hassle to fix the core not to need the bodge :/
