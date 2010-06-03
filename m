From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] AsoC/s3c: patch for the unnecessary
 variable 'state' removal
Date: Thu, 03 Jun 2010 13:14:40 +0100
Message-ID: <1275567280.3593.81.camel@odin>
References: <4C068CE3.8060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 72058103A7E
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 14:14:43 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 26so14575wwf.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 05:14:43 -0700 (PDT)
In-Reply-To: <4C068CE3.8060107@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, jassi.brar@samsung.com, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-03 at 00:54 +0800, Wan ZongShun wrote:
> The variable 'state' of structure 's3c_ac97_info' seems no use here,
> so this patch is to remove the unnecessary variable.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> ---
>  sound/soc/s3c24xx/s3c-ac97.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
> index ecf4fd0..31f6d45 100644
> --- a/sound/soc/s3c24xx/s3c-ac97.c
> +++ b/sound/soc/s3c24xx/s3c-ac97.c
> @@ -31,7 +31,6 @@
>  #define AC_CMD_DATA(x) (x & 0xffff)
> 
>  struct s3c_ac97_info {
> -	unsigned           state;
>  	struct clk         *ac97_clk;
>  	void __iomem	   *regs;
>  	struct mutex       lock;


Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
