From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] ACPI / device_sysfs: change _ADR representation to 64 bits
Date: Mon, 6 May 2019 10:36:22 +0200
Message-ID: <CAJZ5v0i+M8y3ddr+Z5o5af8OatMXq3xqCF5CUg5PjnANrTOSHw@mail.gmail.com>
References: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com> <20190502045817.GZ3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502045817.GZ3845@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, jank@cadence.com, Joe Perches <joe@perches.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 2, 2019 at 6:58 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 01-05-19, 07:53, Pierre-Louis Bossart wrote:
> > Standards such as the MIPI DisCo for SoundWire 1.0 specification
> > assume the _ADR field is 64 bits.
> >
> > _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> > released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> > struct acpi_device_info.
> >
> > This patch bumps the representation used for sysfs to 64 bits. To
> > avoid any compatibility/ABI issues, the printf format is only extended
> > to 16 characters when the actual _ADR value exceeds the 32 bit
> > maximum.
> >
> > Example with a SoundWire device, the results show the complete
> > vendorID and linkID which were omitted before:
> >
> > Before:
> > $ more /sys/bus/acpi/devices/device\:38/adr
> > 0x5d070000
> > After:
> > $ more /sys/bus/acpi/devices/device\:38/adr
> > 0x000010025d070000
> >
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> > v2: only use 64 bits when required to avoid compatibility issues
> > (feedback from Vinod and Rafael)
> >
> >  drivers/acpi/device_sysfs.c | 6 ++++--
> >  include/acpi/acpi_bus.h     | 2 +-
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 8940054d6250..7dda0ee05cd1 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
> >  {
> >       struct acpi_device *acpi_dev = to_acpi_device(dev);
> >
> > -     return sprintf(buf, "0x%08x\n",
> > -                    (unsigned int)(acpi_dev->pnp.bus_address));
> > +     if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)
>
> Would prefer to use U32_MAX instead of 0xFFFFFFFF

I would.
