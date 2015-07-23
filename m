From: Anatol Pomazau <anatol@google.com>
Subject: Re: [PATCH] ASoC: ssm4567: Added ACPI entry for
	SSM4567 codec
Date: Thu, 23 Jul 2015 15:13:17 -0700
Message-ID: <CALj_zD4pvyHhho5c40dsktbOD_+D7+D1Nnk7Lyqe55ARbdw=OQ@mail.gmail.com>
References: <1437678714-5911-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f46.google.com (mail-vn0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 71EA126051F
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 00:13:18 +0200 (CEST)
Received: by vnav141 with SMTP id v141so2429996vna.0
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 15:13:17 -0700 (PDT)
In-Reply-To: <1437678714-5911-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Ben Zhang <benzh@chromium.org>, broonie@kernel.org, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, M Naveen <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Jul 23, 2015 at 12:11 PM, Harsha Priya <harshapriya.n@intel.com> wrote:
> Added INT343B ACPI ID for the SSM4567 codec
>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> Signed-off-by: M Naveen <naveen.m@intel.com>
> Signed-off-by: M R Sathya Prakash <sathya.prakash.m.r@intel.com>

Acked-by: Anatol Pomozov <anatol.pomozov@gmail.com>

> ---
>  sound/soc/codecs/ssm4567.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
> index 938d2cb..af536ae 100644
> --- a/sound/soc/codecs/ssm4567.c
> +++ b/sound/soc/codecs/ssm4567.c
> @@ -10,6 +10,7 @@
>   * Licensed under the GPL-2.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> @@ -450,10 +451,21 @@ static const struct i2c_device_id ssm4567_i2c_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ssm4567_i2c_ids);
>
> +#ifdef CONFIG_ACPI
> +
> +static const struct acpi_device_id ssm4567_acpi_match[] = {
> +       { "INT343B", 0 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(acpi, ssm4567_acpi_match);
> +
> +#endif
> +
>  static struct i2c_driver ssm4567_driver = {
>         .driver = {
>                 .name = "ssm4567",
>                 .owner = THIS_MODULE,
> +               .acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
>         },
>         .probe = ssm4567_i2c_probe,
>         .remove = ssm4567_i2c_remove,
> --
> 1.9.1
>
