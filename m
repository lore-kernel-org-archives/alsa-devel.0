From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
	function
Date: Tue, 2 Apr 2019 11:17:06 +0200
Message-ID: <CAJZ5v0gppf2xdQCz29gFkoP+9XGQ9XnPqB94MdOJhCNL9Ez2rQ@mail.gmail.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <4456530.mAAcKWZnvW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94440F80715
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 11:17:19 +0200 (CEST)
Received: by mail-ot1-f66.google.com with SMTP id 103so11311697otd.9
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2019 02:17:19 -0700 (PDT)
In-Reply-To: <4456530.mAAcKWZnvW@aspire.rjw.lan>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 2, 2019 at 10:59 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, March 28, 2019 6:17:19 PM CEST Andy Shevchenko wrote:
> > The acpi_dev_get_first_match_name() is missing put_device() call
> > and thus keeping reference counting unbalanced.
> >
> > In order to fix the issue introduce a new helper to convert existing users
> > one-by-one to a better API.
> >
> > Since v3:
> > - convert all existing users and drop old API (Mika)
> > - add Hans' tag
> >
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Andy Shevchenko (10):
> >   ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper
> >   extcon: axp288: Convert to use acpi_dev_get_first_match_dev()
> >   gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()
> >   ASoC: Intel: bytcht_da7213: Convert to use
> >     acpi_dev_get_first_match_dev()
> >   ASoC: Intel: bytcht_es8316: Convert to use
> >     acpi_dev_get_first_match_dev()
> >   ASoC: Intel: bytcr_rt5640: Convert to use
> >     acpi_dev_get_first_match_dev()
> >   ASoC: Intel: bytcr_rt5651: Convert to use
> >     acpi_dev_get_first_match_dev()
> >   ASoC: Intel: cht_bsw_rt5645: Convert to use
> >     acpi_dev_get_first_match_dev()
> >   ASoC: Intel: cht_bsw_rt5672: Convert to use
> >     acpi_dev_get_first_match_dev()
> >   ACPI / utils: Remove deprecated function since no user left
> >
> >  drivers/acpi/utils.c                    | 16 ++++++++++------
> >  drivers/extcon/extcon-axp288.c          |  9 +++++----
> >  drivers/gpio/gpio-merrifield.c          | 18 ++++++++++++++----
> >  include/acpi/acpi_bus.h                 |  4 ++--
> >  include/linux/acpi.h                    |  4 ++--
> >  sound/soc/intel/boards/bytcht_da7213.c  |  9 +++++----
> >  sound/soc/intel/boards/bytcht_es8316.c  |  9 +++++----
> >  sound/soc/intel/boards/bytcr_rt5640.c   | 10 +++++-----
> >  sound/soc/intel/boards/bytcr_rt5651.c   | 14 ++++++++------
> >  sound/soc/intel/boards/cht_bsw_rt5645.c |  9 +++++----
> >  sound/soc/intel/boards/cht_bsw_rt5672.c |  9 +++++----
> >  11 files changed, 66 insertions(+), 45 deletions(-)
> >
> >
>
> All applied (with the tags selected so far), thanks!

s/selected/collected/

Strange ...
