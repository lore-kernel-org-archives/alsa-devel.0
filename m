From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: max98926: Constify max98926_reg and
	max98926_regmap
Date: Sat, 20 Feb 2016 01:36:40 -0800
Message-ID: <CABCoZhAHPpUfDPa9t=hzYpzjO9NjCiyxRiscBzVDvOU+EUw1UA@mail.gmail.com>
References: <1455937018.19371.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com
 [209.85.213.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 483DE2614C2
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 10:36:42 +0100 (CET)
Received: by mail-vk0-f54.google.com with SMTP id e6so94419799vkh.2
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 01:36:42 -0800 (PST)
In-Reply-To: <1455937018.19371.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Acked-by: anish kumar<yesanishhere@gmail.com>

On Fri, Feb 19, 2016 at 6:56 PM, Axel Lin <axel.lin@ingics.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/max98926.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
> index 5245e10..8d14ada 100644
> --- a/sound/soc/codecs/max98926.c
> +++ b/sound/soc/codecs/max98926.c
> @@ -40,7 +40,7 @@ static const char *const max98926_hpf_cutoff_txt[] = {
>         "200Hz", "400Hz", "800Hz",
>  };
>
> -static struct reg_default max98926_reg[] = {
> +static const struct reg_default max98926_reg[] = {
>         { 0x0B, 0x00 }, /* IRQ Enable0 */
>         { 0x0C, 0x00 }, /* IRQ Enable1 */
>         { 0x0D, 0x00 }, /* IRQ Enable2 */
> @@ -506,7 +506,7 @@ static struct snd_soc_codec_driver soc_codec_dev_max98926 = {
>         .num_dapm_widgets = ARRAY_SIZE(max98926_dapm_widgets),
>  };
>
> -static struct regmap_config max98926_regmap = {
> +static const struct regmap_config max98926_regmap = {
>         .reg_bits       = 8,
>         .val_bits       = 8,
>         .max_register   = MAX98926_VERSION,
> --
> 2.1.4
>
>
>
