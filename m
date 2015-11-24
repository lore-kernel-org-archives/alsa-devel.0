From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Tue, 24 Nov 2015 15:22:18 +0100
Message-ID: <2460979.tXaWt9xg5Q@vostro.rjw.lan>
References: <cover.1448282995.git.lukas@wunner.de> <20151123233234.GA26361@wunner.de> <5653EA53.8040909@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5653EA53.8040909@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, David Box <david.e.box@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday, November 24, 2015 12:40:51 PM Hanjun Guo wrote:
> On 2015/11/24 7:32, Lukas Wunner wrote:
> > Hi Robert,
> >
> > On Mon, Nov 23, 2015 at 10:22:27PM +0000, Moore, Robert wrote:
> >>>> acpi_dev_present
> >> Do you really want to be walking the ACPICA namespace for every call?
> > That's what the drivers currently do. Typically this is called only once
> > on initialization by the driver's ->probe callback.
> >
> > What did you have in mind instead, cache the result? Or store the HIDs
> > in the namespace in a hash that can be queried faster?
> 
> Will those drivers be loaded before the acpi namespace is scanned? if not, I think
> those IDs already cached, in acpi_init_device_object(),
> 
> INIT_LIST_HEAD(&device->pnp.ids);
> ...
> acpi_set_pnp_ids(handle, &device->pnp, type);
> 
> please see API acpi_device_hid(), so I think you can introduce a API with
> acpi_device and HID passed as arguments in scan.c

I'd prefer that to go to utils.c to be honest, even if the namespace needs to
be walked.

Thanks,
Rafael

