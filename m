From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: byt-max98090: Add GPIO
 ACPI mapping table
Date: Sat, 10 Jun 2017 14:32:50 +0300
Message-ID: <1497094370.22624.92.camel@linux.intel.com>
References: <20170609183801.43892-1-andriy.shevchenko@linux.intel.com>
 <CAKdAkRTHy-raif2PU1VuXwGj7syzo=N-RzHenScYg+0FnS_u+Q@mail.gmail.com>
 <1497035948.22624.87.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C0E0266819
 for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2017 13:32:54 +0200 (CEST)
In-Reply-To: <1497035948.22624.87.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nicolas Porcel <nicolasporcel06@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-06-09 at 22:19 +0300, Andy Shevchenko wrote:
> On Fri, 2017-06-09 at 12:12 -0700, Dmitry Torokhov wrote:
> > On Fri, Jun 9, 2017 at 11:38 AM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > In order to make GPIO ACPI library stricter prepare users of
> > > gpiod_get_index() to correctly behave when there no mapping is
> > > provided by firmware.
> > > 
> > > Here we add explicit mapping between _CRS GpioIo() resources and
> > > their names used in the driver.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > This is a bit more verbose than simply using the same connection
> > name,
> > but I guess will provide better diagnostic to userspace as we will
> > have distinct GPIO names.
> > 
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks!
> 
> But please test it.


I have to check the device node I'm attaching the mapping table to.

On deeper glance it looks now wrong (attaching table to the card
platform device when it should be codec's one?). 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
