From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: change _ADR representation to 64 bits
Date: Tue, 16 Apr 2019 10:09:57 +0200
Message-ID: <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
References: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com> <20190416032923.GQ28103@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416032923.GQ28103@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, jank@cadence.com, Joe Perches <joe@perches.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 16, 2019 at 5:29 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
> > Standards such as the MIPI DisCo for SoundWire 1.0 specification
> > assume the _ADR field is 64 bits.
> >
> > _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> > released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> > struct acpi_device_info.
> >
> > This patch bumps the representation used for sysfs to 64 bits.
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
>
> This looks fine but the sysfs file is an ABI. Not sure if we can modify
> the value returned this way.. Though it should not cause userspace
> reading 32bits to break...

Well, IIRC using "08" instead of "016" in the format field would
preserve the existing behavior for 32-bit values, wouldn't it?
