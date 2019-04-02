From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
	function
Date: Tue, 02 Apr 2019 11:02:19 +0200
Message-ID: <1646161.dLH9L5GH3j@aspire.rjw.lan>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jP8bXiQzFLSFPZ7xcHfxtMv93C-ybaZjqkuj+vjLH_5g@mail.gmail.com>
 <20190401072435.GE2059@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61E7DF80715
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 11:04:25 +0200 (CEST)
In-Reply-To: <20190401072435.GE2059@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Chanwoo Choi <cw00.choi@samsung.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Monday, April 1, 2019 9:24:35 AM CEST Mark Brown wrote:
> 
> --cYtjc4pxslFTELvY
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Fri, Mar 29, 2019 at 12:33:33AM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 28, 2019 at 10:40 PM Andy Shevchenko
> 
> > > > Is this going to be merged through the ACPI or ASoC tree? The changes will
> > > > conflict with cleanups I started to use the 'modern' dailinks (codec_name ->
> > > > codecs[0].name), so some level of coordination is needed.
> 
> > > I suppose via ACPI.
> 
> > I can expose a non-volatile branch with this material, would that work?
> 
> That would be very helpful, please - there's a lot of work going on with
> the ASoC Intel drivers in order to add SoF support so there's likely to
> be some kind of overlaps.

The series is available for pulling in the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-utils

on top of 5.1-rc3 with top-most commit 257f9053c0204ea47491aa236004fd1226f75fa8

 ACPI / utils: Remove deprecated function since no user left

Thanks!
