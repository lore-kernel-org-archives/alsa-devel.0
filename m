From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] RFC: ASoC: Davinci: Fix data_type
	divide	by zero
Date: Fri, 11 Sep 2009 11:31:39 +0100
Message-ID: <20090911103139.GA19204@sirena.org.uk>
References: <1252547830-16585-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 145602462C
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 12:31:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252547830-16585-1-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: khilman@deeprootsystems.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2009 at 06:57:10PM -0700, Troy Kisky wrote:

> This applies on top of my last patchset to Kevin's temp/asoc branch

Could you please respin against what's in for-2.6.32 - this ought to get
fixed there but the other changes will need to wait for 2.6.33.

>  struct davinci_mcbsp_dev {
> +	/*
> +	 * dma_params must be first because rtd->dai->cpu_dai->private_data
> +	 * is cast to an array of struct davinci_pcm_dma_params ** in
> +	 * davinci_pcm_open.
> +	 */

Is it not possible to deal with this by going through the types
properly?  The comment sets off all sorts of alarm bells.
