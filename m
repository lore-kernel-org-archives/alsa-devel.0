From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: [PATCH] ASoC: Remove in-code changelogs
Date: Mon, 19 May 2008 11:26:17 +0100
Message-ID: <20080519102617.GJ22585@trinity.fluff.org>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.145.97.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 36CD9245E8
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 12:26:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 19, 2008 at 11:20:38AM +0100, Mark Brown wrote:
> The overwhelming majority just say "initial version" anyway.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  sound/soc/codecs/ac97.c             |    3 ---
>  sound/soc/codecs/wm9712.c           |    3 ---
>  sound/soc/codecs/wm9713.c           |    3 ---
>  sound/soc/pxa/corgi.c               |    4 ----
>  sound/soc/pxa/pxa2xx-i2s.c          |    3 ---
>  sound/soc/pxa/spitz.c               |    3 ---
>  sound/soc/pxa/tosa.c                |    3 ---
>  sound/soc/s3c24xx/neo1973_wm8753.c  |    4 ----
>  sound/soc/s3c24xx/s3c2443-ac97.c    |    3 ---
>  sound/soc/s3c24xx/s3c24xx-i2s.c     |    5 -----
>  sound/soc/s3c24xx/s3c24xx-pcm.c     |    4 ----
>  sound/soc/s3c24xx/smdk2443_wm9710.c |    3 ---
>  sound/soc/soc-core.c                |    4 ----
>  sound/soc/soc-dapm.c                |    5 -----
>  14 files changed, 0 insertions(+), 50 deletions(-)
> 
> diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
> index 2a1ffe3..7bf2081 100644
> --- a/sound/soc/codecs/ac97.c
> +++ b/sound/soc/codecs/ac97.c
> @@ -10,9 +10,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    17th Oct 2005   Initial version.
> - *
>   * Generic AC97 support.
>   */
>  
> diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
> index aabfa0d..5ca0eb1 100644
> --- a/sound/soc/codecs/wm9712.c
> +++ b/sound/soc/codecs/wm9712.c
> @@ -9,9 +9,6 @@
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
> - *
> - *  Revision history
> - *    4th Feb 2006   Initial version.
>   */
>  
>  #include <linux/init.h>
> diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
> index 1d292e7..86c1445 100644
> --- a/sound/soc/codecs/wm9713.c
> +++ b/sound/soc/codecs/wm9713.c
> @@ -10,9 +10,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    4th Feb 2006   Initial version.
> - *
>   *  Features:-
>   *
>   *   o Support for AC97 Codec, Voice DAC and Aux DAC
> diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
> index 852f16d..edeea63 100644
> --- a/sound/soc/pxa/corgi.c
> +++ b/sound/soc/pxa/corgi.c
> @@ -11,10 +11,6 @@
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
> - *
> - *  Revision history
> - *    30th Nov 2005   Initial version.
> - *
>   */
>  
>  #include <linux/module.h>
> diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
> index 4250710..35090c2 100644
> --- a/sound/soc/pxa/pxa2xx-i2s.c
> +++ b/sound/soc/pxa/pxa2xx-i2s.c
> @@ -9,9 +9,6 @@
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
> - *
> - *  Revision history
> - *    12th Aug 2005   Initial version.
>   */
>  
>  #include <linux/init.h>
> diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
> index 73a6df8..092b5c7 100644
> --- a/sound/soc/pxa/spitz.c
> +++ b/sound/soc/pxa/spitz.c
> @@ -12,9 +12,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    30th Nov 2005   Initial version.
> - *
>   */
>  
>  #include <linux/module.h>
> diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
> index fda2aa0..465ff0f 100644
> --- a/sound/soc/pxa/tosa.c
> +++ b/sound/soc/pxa/tosa.c
> @@ -12,9 +12,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    30th Nov 2005   Initial version.
> - *
>   * GPIO's
>   *  1 - Jack Insertion
>   *  5 - Hookswitch (headset answer/hang up switch)
> diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
> index 79c5027..c1a0161 100644
> --- a/sound/soc/s3c24xx/neo1973_wm8753.c
> +++ b/sound/soc/s3c24xx/neo1973_wm8753.c
> @@ -10,10 +10,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    20th Jan 2007   Initial version.
> - *    05th Feb 2007   Rename all to Neo1973
> - *
>   */
>  
>  #include <linux/module.h>
> diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
> index e81d9a6..0eed140 100644
> --- a/sound/soc/s3c24xx/s3c2443-ac97.c
> +++ b/sound/soc/s3c24xx/s3c2443-ac97.c
> @@ -10,9 +10,6 @@
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
>   *  published by the Free Software Foundation.
> - *
> - *  Revision history
> - *	21st Mar 2007   Initial Version
>   */
>  
>  #include <linux/init.h>
> diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
> index 1ed6afd..ddf8724 100644
> --- a/sound/soc/s3c24xx/s3c24xx-i2s.c
> +++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
> @@ -12,11 +12,6 @@
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
> - *
> - *
> - *  Revision history
> - *    11th Dec 2006   Merged with Simtec driver
> - *    10th Nov 2006   Initial version.
>   */
>  
>  #include <linux/init.h>
> diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
> index 7806ae6..ef59974 100644
> --- a/sound/soc/s3c24xx/s3c24xx-pcm.c
> +++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
> @@ -12,10 +12,6 @@
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
> - *
> - *  Revision history
> - *    11th Dec 2006   Merged with Simtec driver
> - *    10th Nov 2006   Initial version.
>   */
>  
>  #include <linux/module.h>
> diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
> index b4a5630..8515d6f 100644
> --- a/sound/soc/s3c24xx/smdk2443_wm9710.c
> +++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
> @@ -10,9 +10,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    8th Mar 2007   Initial version.
> - *
>   */
>  
>  #include <linux/module.h>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index e148db9..0318d8a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -14,10 +14,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    12th Aug 2005   Initial version.
> - *    25th Oct 2005   Working Codec, Interface and Platform registration.
> - *
>   *  TODO:
>   *   o Add hw rules to enforce rates, etc.
>   *   o More testing with other codecs/machines.
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 1ef6d94..8a3192b 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -10,11 +10,6 @@
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
>   *  option) any later version.
>   *
> - *  Revision history
> - *    12th Aug 2005   Initial version.
> - *    25th Oct 2005   Implemented path power domain.
> - *    18th Dec 2005   Implemented machine and stream level power domain.
> - *
>   *  Features:
>   *    o Changes power status of internal codec blocks depending on the
>   *      dynamic configuration of codec internal audio paths and active
> -- 
> 1.5.5.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
