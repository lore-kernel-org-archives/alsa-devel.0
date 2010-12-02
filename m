From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: soc-core: Generalize
 snd_soc_prefix_map and rename to snd_soc_codec_conf
Date: Thu, 2 Dec 2010 17:26:27 +0200
Message-ID: <20101202172627.556b88a5.jhnikula@gmail.com>
References: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291301583-15491-4-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2945A24498
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 16:25:43 +0100 (CET)
Received: by ewy19 with SMTP id 19so4360471ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 07:25:42 -0800 (PST)
In-Reply-To: <1291301583-15491-4-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu,  2 Dec 2010 14:53:03 +0000
Dimitris Papastamos <dp@opensource.wolfsonmicro.com> wrote:

> The snd_soc_codec_conf struct now holds codec specific configuration
> information.
> 
> A new configuration option has been added to allow machine drivers to
> override the compression type set by the codec driver.
> 
> In the absence of providing an snd_soc_codec_conf struct or when providing
> one but not setting the compress_type member to anything, the one supplied
> by the codec driver will be used instead.  In all other cases the one
> set in the snd_soc_codec_conf struct takes effect.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h  |   22 +++++++++++++++-------
>  sound/soc/soc-core.c |    6 +++---
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index a26cdf9..4409e97 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -579,9 +579,20 @@ struct snd_soc_dai_link {
>  	struct snd_soc_ops *ops;
>  };
>  
> -struct snd_soc_prefix_map {
> +struct snd_soc_codec_conf {
>  	const char *dev_name;

No any objections from my side. Good to generalize this struct.


Acked-by: Jarkko Nikula <jhnikula@gmail.com>
