From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
	function
Date: Thu, 28 Mar 2019 23:29:15 +0100
Message-ID: <7f7c7add-fd91-81f2-da86-8e976839095f@redhat.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD546F8071D
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 23:29:18 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id s16so406605edr.3
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 15:29:18 -0700 (PDT)
In-Reply-To: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 28-03-19 18:17, Andy Shevchenko wrote:
> The acpi_dev_get_first_match_name() is missing put_device() call
> and thus keeping reference counting unbalanced.
> 
> In order to fix the issue introduce a new helper to convert existing users
> one-by-one to a better API.
> 
> Since v3:
> - convert all existing users and drop old API (Mika)
> - add Hans' tag
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> Andy Shevchenko (10):
>    ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper
>    extcon: axp288: Convert to use acpi_dev_get_first_match_dev()
>    gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()
>    ASoC: Intel: bytcht_da7213: Convert to use
>      acpi_dev_get_first_match_dev()
>    ASoC: Intel: bytcht_es8316: Convert to use
>      acpi_dev_get_first_match_dev()
>    ASoC: Intel: bytcr_rt5640: Convert to use
>      acpi_dev_get_first_match_dev()
>    ASoC: Intel: bytcr_rt5651: Convert to use
>      acpi_dev_get_first_match_dev()
>    ASoC: Intel: cht_bsw_rt5645: Convert to use
>      acpi_dev_get_first_match_dev()
>    ASoC: Intel: cht_bsw_rt5672: Convert to use
>      acpi_dev_get_first_match_dev()
>    ACPI / utils: Remove deprecated function since no user left

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the entire series.

Regards,

Hans



> 
>   drivers/acpi/utils.c                    | 16 ++++++++++------
>   drivers/extcon/extcon-axp288.c          |  9 +++++----
>   drivers/gpio/gpio-merrifield.c          | 18 ++++++++++++++----
>   include/acpi/acpi_bus.h                 |  4 ++--
>   include/linux/acpi.h                    |  4 ++--
>   sound/soc/intel/boards/bytcht_da7213.c  |  9 +++++----
>   sound/soc/intel/boards/bytcht_es8316.c  |  9 +++++----
>   sound/soc/intel/boards/bytcr_rt5640.c   | 10 +++++-----
>   sound/soc/intel/boards/bytcr_rt5651.c   | 14 ++++++++------
>   sound/soc/intel/boards/cht_bsw_rt5645.c |  9 +++++----
>   sound/soc/intel/boards/cht_bsw_rt5672.c |  9 +++++----
>   11 files changed, 66 insertions(+), 45 deletions(-)
> 
