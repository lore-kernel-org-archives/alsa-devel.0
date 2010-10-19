From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix I2C component device id number
 creation
Date: Tue, 19 Oct 2010 11:02:08 +0100
Message-ID: <1287482528.3272.56.camel@odin>
References: <1287475845-16230-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2804510387D
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 12:02:12 +0200 (CEST)
Received: by wwb34 with SMTP id 34so1349226wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 03:02:11 -0700 (PDT)
In-Reply-To: <1287475845-16230-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-19 at 11:10 +0300, Jarkko Nikula wrote:
> Use bitwise AND instead of logical AND when masking.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Random note, not known to cause any problems at the moment as id field of
> codec seems to be unused.
> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 8751efd..fe9f20b 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2892,7 +2892,7 @@ static inline char *fmt_single_name(struct device *dev, int *id)
>  			char tmp[NAME_SIZE];
>  
>  			/* create unique ID number from I2C addr and bus */
> -			*id = ((id1 && 0xffff) << 16) + id2;
> +			*id = ((id1 & 0xffff) << 16) + id2;
>  
>  			/* sanitize component name for DAI link creation */
>  			snprintf(tmp, NAME_SIZE, "%s.%s", dev->driver->name, name);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
