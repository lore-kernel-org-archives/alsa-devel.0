From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Remove unused step size from debugfs
	CODEC write function
Date: Thu, 8 Sep 2011 22:19:18 +0100
Message-ID: <CABS+qY3he3Fqjakx=b8czXvsQozCG3h1ScRLfoNedZg9zYEZkA@mail.gmail.com>
References: <1315352411-7108-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AD17103A7D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 23:19:20 +0200 (CEST)
Received: by mail-qy0-f174.google.com with SMTP id 7so781339qyk.12
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 14:19:19 -0700 (PDT)
In-Reply-To: <1315352411-7108-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 7 September 2011 00:40, Mark Brown
<broonie@opensource.wolfsonmicro.com>wrote:

> We don't use the step size so there's no need to work it out.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 187ddfd..0f41cd9 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -244,7 +244,6 @@ static ssize_t codec_reg_write_file(struct file *file,
>        size_t buf_size;
>        char *start = buf;
>        unsigned long reg, value;
> -       int step = 1;
>        struct snd_soc_codec *codec = file->private_data;
>
>        buf_size = min(count, (sizeof(buf)-1));
> @@ -252,9 +251,6 @@ static ssize_t codec_reg_write_file(struct file *file,
>                return -EFAULT;
>        buf[buf_size] = 0;
>
> -       if (codec->driver->reg_cache_step)
> -               step = codec->driver->reg_cache_step;
> -
>        while (*start == ' ')
>                start++;
>        reg = simple_strtoul(start, &start, 16);
> --
> 1.7.5.4
>
>
Btw, we should probably remove this from the struct codec_driver if there
are no other users.

Acked-by Liam Girdwood <lrg@ti.com>
