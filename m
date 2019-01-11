From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Fri, 11 Jan 2019 21:49:29 +0200
Message-ID: <20190111194929.GW9170@smile.fi.intel.com>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AA9E266914
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 20:49:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mark Brown <broonie@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 11, 2019 at 03:21:39PM +0100, Linus Walleij wrote:
> On Tue, Jan 8, 2019 at 7:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > New quirk enforces search for GPIO based on its type.
> > Note, supplied index in the mapping table must be 0.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (...)
> 
> >  sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------
> 
> Do we have an ACK from the maintainer of this file?
> It's Hans I think. Ideally also from Mark Brown.

I hope to get Hans' Tested-by on this.

-- 
With Best Regards,
Andy Shevchenko
