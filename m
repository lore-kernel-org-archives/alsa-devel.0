From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
Date: Tue, 24 Nov 2015 00:32:34 +0100
Message-ID: <20151123233234.GA26361@wunner.de>
References: <cover.1448282995.git.lukas@wunner.de>
 <d66501819cfa8f3d3b07708d3f20e3e20d07e4f8.1448282995.git.lukas@wunner.de>
 <2726545.001oM5V9lv@vostro.rjw.lan>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D998D0C@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D998D0C@ORSMSX112.amr.corp.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, David Box <david.e.box@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Robert,

On Mon, Nov 23, 2015 at 10:22:27PM +0000, Moore, Robert wrote:
> >>acpi_dev_present
> 
> Do you really want to be walking the ACPICA namespace for every call?

That's what the drivers currently do. Typically this is called only once
on initialization by the driver's ->probe callback.

What did you have in mind instead, cache the result? Or store the HIDs
in the namespace in a hash that can be queried faster?

Sorry for not cc'ing you right away, if you want to take a look at the
patches for the drivers they're browsable on GitHub or in the acpica.org
mailing list archive:
https://github.com/l1k/linux/commits/acpi_dev_present
https://lists.acpica.org/pipermail/devel/2015-November/000851.html

Patches [0/5] and [1/5] are not visible in the mailing list archive:
They landed in the moderation queue because they had too many recipients.
I guess if I had cc'ed you all, none of the patches would have come
through.

Thanks,

Lukas

> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Monday, November 23, 2015 2:35 PM
> > To: Lukas Wunner
> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org; platform-driver-
> > x86@vger.kernel.org; Darren Hart; Corentin Chary; Lee, Chun-Yi; alsa-
> > devel@alsa-project.org; Takashi Iwai; Hui Wang; Mark Brown; Zheng, Lv;
> > Moore, Robert; David Box
> > Subject: Re: [PATCH 1/5] ACPICA: Add acpi_dev_present
> > 
> > On Monday, November 23, 2015 03:34:55 PM Lukas Wunner wrote:
> > > There are 7 drivers which call acpi_get_devices to check for the
> > > presence of a particular ACPI HID, each defining its own copy of a
> > > mostly identical callback.
> > >
> > > Add acpi_dev_present, the ACPI equivalent to pci_dev_present, allowing
> > > us to deduplicate all that boilerplate in the drivers.
> > >
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > 
> > We have a general rule for ACPICA patches that they go in through upstream
> > ACPICA.
> > 
> > So if you really want this changes in ACPICA, this is the way to handle
> > it.
> > 
> > Now, of course, for that to happen, you should have CCed the ACPICA
> > maintainers too (now done).
> > 
> > Thanks,
> > Rafael
> > 
> > 
> > > ---
> > >  drivers/acpi/acpica/nsxfeval.c | 46
> > ++++++++++++++++++++++++++++++++++++++++++
> > >  include/acpi/acpixf.h          |  7 +++++++
> > >  2 files changed, 53 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpica/nsxfeval.c
> > > b/drivers/acpi/acpica/nsxfeval.c index 6ee1e52..19293fa 100644
> > > --- a/drivers/acpi/acpica/nsxfeval.c
> > > +++ b/drivers/acpi/acpica/nsxfeval.c
> > > @@ -828,6 +828,52 @@ ACPI_EXPORT_SYMBOL(acpi_get_devices)
> > >
> > >
> > /*************************************************************************
> > ******
> > >   *
> > > + * FUNCTION:    acpi_ns_dev_present_callback
> > > + *
> > > + * PARAMETERS:  Callback from acpi_get_devices
> > > + *
> > > + * RETURN:      Status
> > > + *
> > > + * DESCRIPTION: Minimal callback to be passed to acpi_get_devices which
> > > + *              performs no further filtering and terminates the search
> > > + *              immediately.
> > > + *
> > > +
> > > +*********************************************************************
> > > +*********/ static acpi_status
> > > +acpi_ns_dev_present_callback(acpi_handle handle, u32 level,
> > > +						void *context, void **retval)
> > > +{
> > > +	*(bool *)context = true;
> > > +	return AE_CTRL_TERMINATE;
> > > +}
> > > +
> > > +/********************************************************************
> > > +***********
> > > + *
> > > + * FUNCTION:    acpi_dev_present
> > > + *
> > > + * PARAMETERS:  HID                 - HID to search for.
> > > + *
> > > + * RETURNS      True if a matching object of type Device was found.
> > > + *
> > > + * DESCRIPTION: Performs a walk of the namespace tree. When a matching
> > object
> > > + *              of type Device is found, the search is terminated
> > immediately.
> > > + *
> > > +
> > > +*********************************************************************
> > > +*********/
> > > +
> > > +bool
> > > +acpi_dev_present(const char *HID)
> > > +{
> > > +	acpi_status status;
> > > +	bool found = false;
> > > +
> > > +	status = acpi_get_devices(HID, acpi_ns_dev_present_callback, &found,
> > > +				  NULL);
> > > +	return ACPI_SUCCESS(status) && found; }
> > > +
> > > +ACPI_EXPORT_SYMBOL(acpi_dev_present)
> > > +
> > > +/********************************************************************
> > > +***********
> > > + *
> > >   * FUNCTION:    acpi_attach_data
> > >   *
> > >   * PARAMETERS:  obj_handle          - Namespace node
> > > diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
> > > 3aaaa86..f299347 100644
> > > --- a/include/acpi/acpixf.h
> > > +++ b/include/acpi/acpixf.h
> > > @@ -115,6 +115,11 @@
> > >  	prototype;
> > >  #endif
> > >
> > > +#ifndef ACPI_EXTERNAL_RETURN_BOOL
> > > +#define ACPI_EXTERNAL_RETURN_BOOL(prototype) \
> > > +	prototype;
> > > +#endif
> > > +
> > >
> > /*************************************************************************
> > ****
> > >   *
> > >   * Public globals and runtime configuration options @@ -483,6 +488,8
> > > @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> > >  					      acpi_walk_callback user_function,
> > >  					      void *context,
> > >  					      void **return_value))
> > > +ACPI_EXTERNAL_RETURN_BOOL(bool
> > > +			     acpi_dev_present(const char *HID))
> > >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> > >  			     acpi_get_name(acpi_handle object, u32 name_type,
> > >  					   struct acpi_buffer *ret_path_ptr))
> > >
> 
