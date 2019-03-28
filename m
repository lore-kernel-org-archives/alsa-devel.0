From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
 function
Date: Thu, 28 Mar 2019 14:31:28 -0400
Message-ID: <0daff2ba-3322-be9c-9afb-0d74b9d0827e@linux.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42F2EF80769
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 19:31:35 +0100 (CET)
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 3/28/19 1:17 PM, Andy Shevchenko wrote:
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

Patches 4..9 for the Intel machine drivers:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Is this going to be merged through the ACPI or ASoC tree? The changes 
will conflict with cleanups I started to use the 'modern' dailinks 
(codec_name -> codecs[0].name), so some level of coordination is needed.

> 
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
