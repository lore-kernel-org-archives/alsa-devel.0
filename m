From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Thu, 9 Apr 2015 01:22:47 -0700
Message-ID: <20150409082246.GB62585@Asurada-CZ80>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
 <55258272.2010205@metafoo.de>
 <CAOMZO5AxT9dgE=QaH18FUYD5CbMvn67XpMo4dH6T0v9Qen-RRg@mail.gmail.com>
 <55262C9D.5080005@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ADD7265268
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:22:51 +0200 (CEST)
Received: by pdbnk13 with SMTP id nk13so145283204pdb.0
 for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2015 01:22:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55262C9D.5080005@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Russell King <linux@arm.linux.org.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 09, 2015 at 09:39:09AM +0200, Lars-Peter Clausen wrote:

> The whole thing is a bit confusing. The message you get is what
> you'd get if the 'dapm' sub-directory in the card debugfs directory
> can not be created. One of the few reasons why it would fail is if
> it already existed, but we should never register two dapm contexts
> for the card, so that's a bit strange. One of the few reasons I can
> imagine this could happen is if the parent directory could not be
> created and now we try to create multiple dapm directories at the
> top-level.
> 
> Try to do some more debugging and see why and where exactly things
> go wrong. Can you also try this:
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index b6f8820..7810262 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -1898,6 +1898,11 @@
>  {
>  	struct dentry *d;
> 
> +	if (!parent) {
> +		dev_warn(dapm->dev, "No debugfs parent!\n");

I tried, yes, the parent is NULL. And I did a little tracing and found
that the card->debugfs_root, which is NULL, should be initialized in
the soc_init_card_debugfs() while snd_soc_dapm_debugfs_init() seems
to access this card->debugfs_root before calling soc_init_card_debugfs().

I think I must have missed something over here....

Thank you
Nicolin
