From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_iv/iv 1/1] ASoC: Add optional name_prefix to
 struct snd_soc_dev_map
Date: Fri, 29 Oct 2010 14:42:45 -0700
Message-ID: <20101029214244.GK3921@opensource.wolfsonmicro.com>
References: <1288353823-22075-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 945E9244D4
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 23:42:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353823-22075-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 29, 2010 at 03:03:43PM +0300, Jarkko Nikula wrote:

> @@ -547,6 +548,9 @@ struct snd_soc_dev_map {
>  
>  	/* machine stream operations */
>  	struct snd_soc_ops *ops;
> +
> +	/* optional name prefix for kcontrols and widgets */
> +	const char *name_prefix;

This is another issue with using the DAI links to map these things - as
previously discussed we want to be able to support CODEC<->CODEC DAI
links, and we don't have a way to associate controls with specific DAI
links on multi-DAI devices.
