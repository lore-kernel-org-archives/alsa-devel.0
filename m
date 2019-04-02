From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
	function
Date: Tue, 2 Apr 2019 13:37:40 +0300
Message-ID: <20190402103740.GI9224@smile.fi.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <4456530.mAAcKWZnvW@aspire.rjw.lan>
 <CAJZ5v0gppf2xdQCz29gFkoP+9XGQ9XnPqB94MdOJhCNL9Ez2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94CD1F80715
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 12:37:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gppf2xdQCz29gFkoP+9XGQ9XnPqB94MdOJhCNL9Ez2rQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 02, 2019 at 11:17:06AM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 2, 2019 at 10:59 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, March 28, 2019 6:17:19 PM CEST Andy Shevchenko wrote:
> > > The acpi_dev_get_first_match_name() is missing put_device() call
> > > and thus keeping reference counting unbalanced.
> > >
> > > In order to fix the issue introduce a new helper to convert existing users
> > > one-by-one to a better API.
> > >
> > > Since v3:
> > > - convert all existing users and drop old API (Mika)
> > > - add Hans' tag

> > All applied (with the tags selected so far), thanks!
> 
> s/selected/collected/
> 
> Strange ...

Thank you, Rafael!


-- 
With Best Regards,
Andy Shevchenko
