From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: Fix divide by
	zero	error during 1st execution
Date: Thu, 24 Sep 2009 07:36:22 -0700
Message-ID: <20090924143621.GA5105@sirena.org.uk>
References: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090923171039.GB3457@sirena.org.uk>
	<4ABACEEF.8080000@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl01-sjpop.stsn.net (s-utl01-sjpop.stsn.net [72.254.0.201])
	by alsa0.perex.cz (Postfix) with SMTP id 07BC61038BD
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 16:37:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4ABACEEF.8080000@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2009 at 06:44:15PM -0700, Troy Kisky wrote:

> I think you were waiting for me to remove the need for the
> comment:

> +	/*
> +	 * dma_params must be first because rtd->dai->cpu_dai->private_data
> +	 * is cast to a pointer of an array of struct davinci_pcm_dma_params in
> +	 * davinci_pcm_open.
> +	 */

> Which is doable.

> Do you still want this fixed?

Yes, please - I merged the patch because the bug fix really ought to be
in .32 but it'd still be good to get the code cleaned up even if that
has to wait for .33.
