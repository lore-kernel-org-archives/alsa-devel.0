From: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Date: Tue, 23 Aug 2016 09:34:10 +0100
Message-ID: <CALeDE9MWKGUS-+HRPoDs0a5zPaqi4v9bUZ+pxP6eUyt7RvVQ_w@mail.gmail.com>
References: <20160822121242.18827-1-pbrobinson@gmail.com>
 <2008659.grltYsYuN0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id DA6E7266C1F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 10:34:11 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i5so17020913wmg.2
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 01:34:11 -0700 (PDT)
In-Reply-To: <2008659.grltYsYuN0@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, wens@csie.org, broonie@kernel.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2016 at 3:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, August 22, 2016 1:12:42 PM CEST Peter Robinson wrote:
>> Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
>> these if the appropriate SoC they're embedded in isn't enabled.
>>
>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>> ---
>>  sound/soc/sunxi/Kconfig | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
>> index 2a954bd..a2b62dc5 100644
>> --- a/sound/soc/sunxi/Kconfig
>> +++ b/sound/soc/sunxi/Kconfig
>> @@ -2,6 +2,7 @@ menu "Allwinner SoC Audio support"
>>
>>  config SND_SUN4I_CODEC
>>         tristate "Allwinner A10 Codec Support"
>> +       depends on ARCH_SUNXI || COMPILE_TEST
>>         select SND_SOC_GENERIC_DMAENGINE_PCM
>>         select REGMAP_MMIO
>>
>
> Makes sense, though I think it's nicer to add the dependency to the entire
> menu, so we hide that as well, and don't have to add the line to future
> entries:

Makes sense, will do a v2 shortly.

P

> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 2a954bd01fd8..dd2368297fd3 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -1,4 +1,5 @@
>  menu "Allwinner SoC Audio support"
> +       depends on ARCH_SUNXI || COMPILE_TEST
>
>  config SND_SUN4I_CODEC
>         tristate "Allwinner A10 Codec Support"
>
> Either way
> Acked-by: Arnd Bergmann <arnd@arndb.de>
