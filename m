From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: Instantiate all DAPM widgets at
	once
Date: Thu, 28 Apr 2011 21:07:37 +0100
Message-ID: <20110428200737.GE16837@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F382D24154
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 22:07:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304009173-5786-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 06:46:13PM +0200, Lars-Peter Clausen wrote:
> Currently after each codec or auxdev has been probed its DAPM widgets are
> instantiated.
> 
> Since widgets are kept in a per card list and routes can interconnect between
> widgets from different DAPM contexts on the same card it is possible that
> snd_soc_dapm_new_widgets is run on an incomplete DAPM configuration which might
> cause unnecessary register writes and/or cause audible problems.
> 
> This patch addresses the issue by instantiating all widgets from all DAPM contexts
> after all components of the card have been initialized.

Except it doesn't because...

> +static inline int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
> +{
> +	return snd_soc_dapm_card_new_widgets(dapm->card);
> +}

...we can still instantiate widgets at any time, and lots of code will
do just that (and needs to do that because it needs the widgets to be
present in order to allow paths to be added).

There's also the fact that this mixes in the functional change to move
the instantiation of the widgets around with the argument change and a
rename, it'd be better to split the two of those out so we can clearly
see the functional change.
