From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 10:26:52 +0300
Message-ID: <523955BC.2050506@linux.intel.com>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F433260844
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 09:26:55 +0200 (CEST)
In-Reply-To: <1379484624-11029-1-git-send-email-olof@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On 09/18/2013 09:10 AM, Olof Johansson wrote:
> Commit 02b80773de37 (ASoC: rt5640: Add ACPI probing support.) causes
> a warning due to unreferenced variable on non-ACPI configs such as
> tegra_defconfig on ARM:
>
>    sound/soc/codecs/rt5640.c:2085:30: warning: 'rt5640_acpi_match' defined but not used [-Wunused-variable]
>
> Signed-off-by: Olof Johansson<olof@lixom.net>
> ---
>   sound/soc/codecs/rt5640.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index 0bfb960..a856706 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -2082,11 +2082,13 @@ static const struct i2c_device_id rt5640_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
>
> +#if CONFIG_ACPI
>   static struct acpi_device_id rt5640_acpi_match[] = {
>   	{ "INT33CA", 0 },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
> +#endif
My 1c, maybe #ifdef?

-- 
Jarkko
