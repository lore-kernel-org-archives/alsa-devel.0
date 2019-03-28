From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 00/10] ACPI / utils: Replace leaky function
Date: Thu, 28 Mar 2019 19:17:19 +0200
Message-ID: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0A0CF89673
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 18:17:36 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The acpi_dev_get_first_match_name() is missing put_device() call
and thus keeping reference counting unbalanced.

In order to fix the issue introduce a new helper to convert existing users
one-by-one to a better API.

Since v3:
- convert all existing users and drop old API (Mika)
- add Hans' tag

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Andy Shevchenko (10):
  ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper
  extcon: axp288: Convert to use acpi_dev_get_first_match_dev()
  gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()
  ASoC: Intel: bytcht_da7213: Convert to use
    acpi_dev_get_first_match_dev()
  ASoC: Intel: bytcht_es8316: Convert to use
    acpi_dev_get_first_match_dev()
  ASoC: Intel: bytcr_rt5640: Convert to use
    acpi_dev_get_first_match_dev()
  ASoC: Intel: bytcr_rt5651: Convert to use
    acpi_dev_get_first_match_dev()
  ASoC: Intel: cht_bsw_rt5645: Convert to use
    acpi_dev_get_first_match_dev()
  ASoC: Intel: cht_bsw_rt5672: Convert to use
    acpi_dev_get_first_match_dev()
  ACPI / utils: Remove deprecated function since no user left

 drivers/acpi/utils.c                    | 16 ++++++++++------
 drivers/extcon/extcon-axp288.c          |  9 +++++----
 drivers/gpio/gpio-merrifield.c          | 18 ++++++++++++++----
 include/acpi/acpi_bus.h                 |  4 ++--
 include/linux/acpi.h                    |  4 ++--
 sound/soc/intel/boards/bytcht_da7213.c  |  9 +++++----
 sound/soc/intel/boards/bytcht_es8316.c  |  9 +++++----
 sound/soc/intel/boards/bytcr_rt5640.c   | 10 +++++-----
 sound/soc/intel/boards/bytcr_rt5651.c   | 14 ++++++++------
 sound/soc/intel/boards/cht_bsw_rt5645.c |  9 +++++----
 sound/soc/intel/boards/cht_bsw_rt5672.c |  9 +++++----
 11 files changed, 66 insertions(+), 45 deletions(-)

-- 
2.20.1
