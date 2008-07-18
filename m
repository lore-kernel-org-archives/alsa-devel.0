From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: Allow codecs to override register
	display
Date: Fri, 18 Jul 2008 11:23:09 -0400
Message-ID: <9e4733910807180823o1ec3e735y55b4d847467770b7@mail.gmail.com>
References: <1216378642-14987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E07224378
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 17:23:10 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so139890qwf.56
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 08:23:10 -0700 (PDT)
In-Reply-To: <1216378642-14987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
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

On 7/18/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> Some codecs have unusual features in their register maps such as very
>  large registers representing arrays of coefficients. Support these
>  codecs in the register cache sysfs file by allowing them to provide a
>  function register_display() overriding the default output for register
>  contents.

My address space is sparse like Grant's. How about display_register()
returning -1 to skip the register address. The part printing the
address would need to be suppressed too.
count += sprintf(buf + count, "%2x: ", i);

Alternatively you could just make the entire codec_reg_show() overridable.

Might want to add another parameter for cached/uncached. Then we could
make a debug option to add the non-cached display.

This loop needs to be protected to not write over the sysfs limit of
PAGE_SIZE in the result. I think you will corrupt memory if PAGE_SIZE
is exceeded.

>  Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>  ---
>   include/sound/soc.h  |    1 +
>   sound/soc/soc-core.c |   14 ++++++++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)
>
>  diff --git a/include/sound/soc.h b/include/sound/soc.h
>  index 1890d87..8b1a3e7 100644
>  --- a/include/sound/soc.h
>  +++ b/include/sound/soc.h
>  @@ -410,6 +410,7 @@ struct snd_soc_codec {
>         void *control_data; /* codec control (i2c/3wire) data */
>         unsigned int (*read)(struct snd_soc_codec *, unsigned int);
>         int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
>  +       int (*display_register)(struct snd_soc_codec *, char *, unsigned int);
>         hw_write_t hw_write;
>         hw_read_t hw_read;
>         void *reg_cache;
>  diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>  index 83f1190..49532d9 100644
>  --- a/sound/soc/soc-core.c
>  +++ b/sound/soc/soc-core.c
>  @@ -970,10 +970,16 @@ static ssize_t codec_reg_show(struct device *dev,
>                 step = codec->reg_cache_step;
>
>         count += sprintf(buf, "%s registers\n", codec->name);
>  -       for (i = 0; i < codec->reg_cache_size; i += step)
>  -               count += sprintf(buf + count, "%2x: %4x\n", i,
>  -                       codec->read(codec, i));
>  -
>  +       for (i = 0; i < codec->reg_cache_size; i += step) {
>  +               count += sprintf(buf + count, "%2x: ", i);
>  +               if (codec->display_register)
>  +                       count += codec->display_register(codec,
>  +                                                        buf + count, i);
>  +               else
>  +                       count += sprintf(buf + count, "%4x",
>  +                                        codec->read(codec, i));
>  +               count += sprintf(buf + count, "\n");
>  +       }
>         return count;
>   }
>   static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
>
> --
>  1.5.6.3
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
