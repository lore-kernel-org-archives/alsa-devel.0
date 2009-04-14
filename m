From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Help for writting an ASoC driver
Date: Tue, 14 Apr 2009 14:36:29 +0100
Message-ID: <20090414133629.GJ12678@sirena.org.uk>
References: <fb44c3530904071018o542cb622k6ab9b939b3144c78@mail.gmail.com>
	<20090407221935.GB8465@sirena.org.uk>
	<fb44c3530904071626q22e41db2s76f6089771de74c2@mail.gmail.com>
	<fb44c3530904131050s397c080bs8dffb61120c47de4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72C4D24335
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 15:36:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fb44c3530904131050s397c080bs8dffb61120c47de4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2009 at 12:50:07PM -0500, Ernesto Torres wrote:

Please do not top post.

> from omap_pcm_hw_params:
>     err = omap_request_dma(dma_data->dma_req, dma_data->name,
>                    omap_pcm_dma_irq, substream, &prtd->dma_ch);

> With twl4030 it successfully calls omap_pcm_dma_irq, but with my codec it
> never get called, am I forgetting to set some value?

You probably have an error in your machine driver (or possibly codec
driver if that's not one that's been tested by other people).  It is
likely that some earlier part of the setup process is returning an
error.

Also try testing with the standard ALSA applications to eliminate the
possibility of bugs in your application.
