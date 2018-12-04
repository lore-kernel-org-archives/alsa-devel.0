From: ayman.bagabas@gmail.com
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
Date: Tue, 04 Dec 2018 10:29:47 -0500
Message-ID: <5d47df50508c040a029bee55161571522b69f307.camel@gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
         <20181203185344.3521-3-ayman.bagabas@gmail.com>
         <9d6d8211-6fdf-bfe4-82b5-272d67fbae23@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9d6d8211-6fdf-bfe4-82b5-272d67fbae23@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-12-03 at 11:41 -0800, Randy Dunlap wrote:
> On 12/3/18 10:53 AM, Ayman Bagabas wrote:
> > This driver adds support for missing hotkeys on some Huawei
> > laptops.
> > Laptops such as the Matebook X have non functioning hotkeys.
> > Whereas
> > newer laptops such as the Matebook X Pro come with working hotkeys
> > out
> > of the box.
> > 
> > Old laptops, such as the Matebook X, report hotkey events through
> > ACPI
> > device "\WMI0". However, new laptops, such as the Matebook X Pro,
> > does not have this WMI device.
> > 
> > All the hotkeys on the Matebook X Pro work fine
> > without this patch except (micmute, wlan, and huawei key). These
> > keys
> > and the brightness keys report events to "\AMW0" ACPI device. One
> > problem is that brightness keys on the Matebook X Pro work without
> > this
> > patch. This results in reporting two brightness key press
> > events one is captured by ACPI and another by this driver.
> > 
> > A solution would be to check if such event came from the "\AMW0"
> > WMI driver
> > then skip reporting event. Another solution would be to leave this
> > to
> > user-space to handle. Which can be achieved by using "hwdb" tables
> > and
> > remap those keys to "unknown". This solution seems more natural to
> > me
> > because it leaves the decision to user-space.
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> > ---
> >  drivers/platform/x86/Kconfig      |  16 +++
> >  drivers/platform/x86/Makefile     |   1 +
> >  drivers/platform/x86/huawei-wmi.c | 226
> > ++++++++++++++++++++++++++++++
> >  3 files changed, 243 insertions(+)
> >  create mode 100644 drivers/platform/x86/huawei-wmi.c
> > 
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index 87f70e8f4dd0..27db3ce7a1e1 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1292,6 +1292,22 @@ config INTEL_ATOMISP2_PM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called intel_atomisp2_pm.
> >  
> > +config HUAWEI_WMI
> > +	tristate "Huawei WMI hotkeys driver"
> > +	depends on ACPI_WMI
> > +	depends on INPUT
> > +	select INPUT_SPARSEKMAP
> > +	select LEDS_CLASS
> 
> but LEDS_CLASS is only available if NEW_LEDS is set/enabled, so it
> either
> depends on LEDS_CLASS... or it needs to select NEW_LEDS, which is
> what other
> drivers in this Kconfig file do, even though our b.d. has said a few
> times
> that any one driver should not "select" => enable an entire
> subsystem,
> so they all should be "depends on NEW_LEDS" IMHO.

Noted, I'll select NEW_LEDS just like other drivers in Kconfig.

> 
> > +	select LEDS_TRIGGERS
> > +	select LEDS_TRIGGER_AUDIO
> > +	help
> > +	  This driver provides support for Huawei WMI hotkeys.
> > +	  It enables the missing keys and adds support to the micmute
> > +	  LED found on some of these laptops.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called huawei-wmi.
> > +
> >  endif # X86_PLATFORM_DEVICES
> >  
> >  config PMC_ATOM
> 
> 
