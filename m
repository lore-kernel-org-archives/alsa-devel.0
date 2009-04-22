From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: OMAP: Add checking to
	detect	bufferless pcms
Date: Wed, 22 Apr 2009 09:43:49 +0100
Message-ID: <20090422084349.GB10356@sirena.org.uk>
References: <49EE7962.6080008@samsung.com>
	<bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D34F245EA
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 10:43:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, Joonyoung Shim <jy0922.shim@samsung.com>, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2009 at 11:30:32AM +0300, Jarkko Nikula wrote:
> On Wed, Apr 22, 2009 at 4:56 AM, Joonyoung Shim <jy0922.shim@samsung.com>wrote:

> > +       /* return if this is a bufferless transfer e.g.
> > +        * codec <--> BT codec or GSM modem -- lg FIXME */
> >        if (!dma_data)
> > -               return -ENODEV;
> > +               return 0;

> I see exactly similar lines in s3c24xx-pcm.c but don't point now the use
> case where this is used and I don't have idea what is this all about.

The use case is for dummy DAIs used to represent bluetooth and similar -
they aren't going to do any DMA so don't pass anything to the platform.

> Is this something where DAI driver or another end of connection is used to
> provide clocking and the whole setup is then controlled with ALSA PCM API?
> Somehow I have the feeling that would there be a better way to achieve it
> than with dummy bufferless transfer?

The host isn't transferring any data at all in these cases.  Ideally
we'd support multiple platforms and there'd be a dummy platform driver
to go with the dummy DAI driver.
