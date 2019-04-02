From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
	function
Date: Tue, 02 Apr 2019 10:57:18 +0200
Message-ID: <4456530.mAAcKWZnvW@aspire.rjw.lan>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CB93F80715
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 10:59:24 +0200 (CEST)
In-Reply-To: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thursday, March 28, 2019 6:17:19 PM CEST Andy Shevchenko wrote:
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
> 
> Andy Shevchenko (10):
>   ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper
>   extcon: axp288: Convert to use acpi_dev_get_first_match_dev()
>   gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()
>   ASoC: Intel: bytcht_da7213: Convert to use
>     acpi_dev_get_first_match_dev()
>   ASoC: Intel: bytcht_es8316: Convert to use
>     acpi_dev_get_first_match_dev()
>   ASoC: Intel: bytcr_rt5640: Convert to use
>     acpi_dev_get_first_match_dev()
>   ASoC: Intel: bytcr_rt5651: Convert to use
>     acpi_dev_get_first_match_dev()
>   ASoC: Intel: cht_bsw_rt5645: Convert to use
>     acpi_dev_get_first_match_dev()
>   ASoC: Intel: cht_bsw_rt5672: Convert to use
>     acpi_dev_get_first_match_dev()
>   ACPI / utils: Remove deprecated function since no user left
> 
>  drivers/acpi/utils.c                    | 16 ++++++++++------
>  drivers/extcon/extcon-axp288.c          |  9 +++++----
>  drivers/gpio/gpio-merrifield.c          | 18 ++++++++++++++----
>  include/acpi/acpi_bus.h                 |  4 ++--
>  include/linux/acpi.h                    |  4 ++--
>  sound/soc/intel/boards/bytcht_da7213.c  |  9 +++++----
>  sound/soc/intel/boards/bytcht_es8316.c  |  9 +++++----
>  sound/soc/intel/boards/bytcr_rt5640.c   | 10 +++++-----
>  sound/soc/intel/boards/bytcr_rt5651.c   | 14 ++++++++------
>  sound/soc/intel/boards/cht_bsw_rt5645.c |  9 +++++----
>  sound/soc/intel/boards/cht_bsw_rt5672.c |  9 +++++----
>  11 files changed, 66 insertions(+), 45 deletions(-)
> 
> 

All applied (with the tags selected so far), thanks!
