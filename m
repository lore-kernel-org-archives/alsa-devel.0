From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: OMAP: Add checking to detect
	bufferless pcms
Date: Wed, 22 Apr 2009 12:01:28 +0300
Message-ID: <bd7b27490904220201u2c9da4dgce14c2da368f0f08@mail.gmail.com>
References: <49EE7962.6080008@samsung.com>
	<bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
	<20090422084349.GB10356@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 0095824624
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 11:01:29 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1690079bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2009 02:01:29 -0700 (PDT)
In-Reply-To: <20090422084349.GB10356@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, Joonyoung Shim <jy0922.shim@samsung.com>, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2009 at 11:43 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Wed, Apr 22, 2009 at 11:30:32AM +0300, Jarkko Nikula wrote:
>
> > Is this something where DAI driver or another end of connection is used
> to
> > provide clocking and the whole setup is then controlled with ALSA PCM
> API?
> > Somehow I have the feeling that would there be a better way to achieve it
> > than with dummy bufferless transfer?
>
> The host isn't transferring any data at all in these cases.  Ideally
> we'd support multiple platforms and there'd be a dummy platform driver
> to go with the dummy DAI driver.
>

Probably it's better to extend this patch to other architectures as well (at
least DaVinci) where possible in order to be more consistent. I just noticed
that also PXA is having the same feature.


-- 
Jarkko
