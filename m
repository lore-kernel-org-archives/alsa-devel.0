From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
 function
Date: Thu, 28 Mar 2019 23:40:19 +0200
Message-ID: <20190328214019.GP9224@smile.fi.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <0daff2ba-3322-be9c-9afb-0d74b9d0827e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D8D1F8071D
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 22:40:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0daff2ba-3322-be9c-9afb-0d74b9d0827e@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 28, 2019 at 02:31:28PM -0400, Pierre-Louis Bossart wrote:
> On 3/28/19 1:17 PM, Andy Shevchenko wrote:
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
> 
> Patches 4..9 for the Intel machine drivers:
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thank you!

> Is this going to be merged through the ACPI or ASoC tree? The changes will
> conflict with cleanups I started to use the 'modern' dailinks (codec_name ->
> codecs[0].name), so some level of coordination is needed.

I suppose via ACPI.

> 
> > 
> > Andy Shevchenko (10):
> >    ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper
> >    extcon: axp288: Convert to use acpi_dev_get_first_match_dev()
> >    gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()
> >    ASoC: Intel: bytcht_da7213: Convert to use
> >      acpi_dev_get_first_match_dev()
> >    ASoC: Intel: bytcht_es8316: Convert to use
> >      acpi_dev_get_first_match_dev()
> >    ASoC: Intel: bytcr_rt5640: Convert to use
> >      acpi_dev_get_first_match_dev()
> >    ASoC: Intel: bytcr_rt5651: Convert to use
> >      acpi_dev_get_first_match_dev()
> >    ASoC: Intel: cht_bsw_rt5645: Convert to use
> >      acpi_dev_get_first_match_dev()
> >    ASoC: Intel: cht_bsw_rt5672: Convert to use
> >      acpi_dev_get_first_match_dev()
> >    ACPI / utils: Remove deprecated function since no user left
> > 
> >   drivers/acpi/utils.c                    | 16 ++++++++++------
> >   drivers/extcon/extcon-axp288.c          |  9 +++++----
> >   drivers/gpio/gpio-merrifield.c          | 18 ++++++++++++++----
> >   include/acpi/acpi_bus.h                 |  4 ++--
> >   include/linux/acpi.h                    |  4 ++--
> >   sound/soc/intel/boards/bytcht_da7213.c  |  9 +++++----
> >   sound/soc/intel/boards/bytcht_es8316.c  |  9 +++++----
> >   sound/soc/intel/boards/bytcr_rt5640.c   | 10 +++++-----
> >   sound/soc/intel/boards/bytcr_rt5651.c   | 14 ++++++++------
> >   sound/soc/intel/boards/cht_bsw_rt5645.c |  9 +++++----
> >   sound/soc/intel/boards/cht_bsw_rt5672.c |  9 +++++----
> >   11 files changed, 66 insertions(+), 45 deletions(-)
> > 
> 

-- 
With Best Regards,
Andy Shevchenko
