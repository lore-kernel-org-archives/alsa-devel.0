From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Tue, 24 Nov 2015 14:15:00 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D998EDD@ORSMSX112.amr.corp.intel.com>
References: <cover.1448282995.git.lukas@wunner.de>
 <d66501819cfa8f3d3b07708d3f20e3e20d07e4f8.1448282995.git.lukas@wunner.de>
 <2726545.001oM5V9lv@vostro.rjw.lan>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D998D0C@ORSMSX112.amr.corp.intel.com>
 <20151123233234.GA26361@wunner.de> <5653EA53.8040909@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <5653EA53.8040909@huawei.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, David Box <david.e.box@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Hanjun Guo [mailto:guohanjun@huawei.com]
> Sent: Monday, November 23, 2015 8:41 PM
> To: Lukas Wunner; Moore, Robert
> Cc: Rafael J. Wysocki; linux-acpi@vger.kernel.org; devel@acpica.org;
> platform-driver-x86@vger.kernel.org; Darren Hart; Corentin Chary; Lee,
> Chun-Yi; alsa-devel@alsa-project.org; Takashi Iwai; Hui Wang; Mark Brown;
> Zheng, Lv; David Box
> Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
> 
> On 2015/11/24 7:32, Lukas Wunner wrote:
> > Hi Robert,
> >
> > On Mon, Nov 23, 2015 at 10:22:27PM +0000, Moore, Robert wrote:
> >>>> acpi_dev_present
> >> Do you really want to be walking the ACPICA namespace for every call?
> > That's what the drivers currently do. Typically this is called only
> > once on initialization by the driver's ->probe callback.
> >
> > What did you have in mind instead, cache the result? Or store the HIDs
> > in the namespace in a hash that can be queried faster?
> 
> Will those drivers be loaded before the acpi namespace is scanned? if not,
> I think those IDs already cached, in acpi_init_device_object(),


I was thinking about something like this. Traversing the namespace over and over is truly brute force.



> 
> INIT_LIST_HEAD(&device->pnp.ids);
> ...
> acpi_set_pnp_ids(handle, &device->pnp, type);
> 
> please see API acpi_device_hid(), so I think you can introduce a API with
> acpi_device and HID passed as arguments in scan.c
> 
> Thanks
> Hanjun
