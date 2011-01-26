From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: Add optional pointer to machine
 audio routes to snd_soc_card
Date: Wed, 26 Jan 2011 13:35:22 +0000
Message-ID: <20110126133522.GC8501@opensource.wolfsonmicro.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
	<1296043097-11720-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C82F52456F
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 14:35:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296043097-11720-2-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 26, 2011 at 01:58:15PM +0200, Jarkko Nikula wrote:

> +		/*
> +		 * use the last codec and dapm context of it when setting up
> +		 * the common audio map
> +		 */
> +		codec = list_first_entry(&card->codec_dev_list,
> +					 struct snd_soc_codec, card_list);
> +		temp = codec->name_prefix;
> +		codec->name_prefix = NULL;
> +		ret = snd_soc_dapm_add_routes(&codec->dapm,
> +					      card->route, card->num_routes);

Rather than faff around like this it seems we should just bite the
bullet and add a DAPM context for the card.

Probably also worth doing the same thing as this for widgets - the
combination of these two would eliminate almost all machine init()
functions.
