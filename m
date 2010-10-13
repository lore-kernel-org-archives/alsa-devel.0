From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Move soc-core module init next to
 functon definition
Date: Wed, 13 Oct 2010 11:00:10 +0100
Message-ID: <1286964010.3282.33.camel@odin>
References: <1286963853-10116-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 48D4A244B9
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 12:00:13 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3677927wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 03:00:13 -0700 (PDT)
In-Reply-To: <1286963853-10116-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-13 at 10:57 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index f4286ab..4cbfe46 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3311,6 +3311,7 @@ static int __init snd_soc_init(void)
>  
>  	return platform_driver_register(&soc_driver);
>  }
> +module_init(snd_soc_init);
>  
>  static void __exit snd_soc_exit(void)
>  {
> @@ -3319,8 +3320,6 @@ static void __exit snd_soc_exit(void)
>  #endif
>  	platform_driver_unregister(&soc_driver);
>  }
> -
> -module_init(snd_soc_init);
>  module_exit(snd_soc_exit);
>  
>  /* Module information */

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
