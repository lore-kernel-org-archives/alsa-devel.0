From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/3] ACPI / utils: Introduce
 acpi_dev_get_first_match_name()
Date: Mon, 08 Jan 2018 15:09:20 +0200
Message-ID: <1515416960.7000.784.camel@linux.intel.com>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
         <20180105160935.48588-2-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0iH+2JHe8vCR9tQX62ULwx_eVd1QGPtinSLNDzWx1NmEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iH+2JHe8vCR9tQX62ULwx_eVd1QGPtinSLNDzWx1NmEg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2018-01-06 at 00:27 +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 5, 2018 at 5:09 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Sometimes the user wants to have device name of the match rather
> > than
> > just checking if device present or not. To make life easier for such
> > users introduce acpi_dev_get_first_match_name() helper based on code
> > for acpi_dev_present().
> > 
> > For example, GPIO driver for Intel Merrifield needs to know the
> > device
> > name of pin control to be able to apply GPIO mapping table to the
> > proper
> > device.
> > 
> > To be more consistent with the purpose rename
> > 
> >   struct acpi_dev_present_info  -> struct acpi_dev_match_info
> >   acpi_dev_present_cb()         -> acpi_dev_match_cb()
> > 
> > in the utils.c file.
> > 
> > Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.co
> > m>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> OK, so which way do you want this to go in?

If you have no objections, patch 1 may go straight forward to linux-pm
tree as far as you are okay with the contents.

I dunno, if Mika's ACK is enough to you to get the second one (patch 2)
together, otherwise Linus' ACK would be needed or leave it for next
cycle.

According to what Mark and Pierre told previously I guess we just
postpone patch 3 for next cycle.

> 
> > ---
> >  drivers/acpi/utils.c    | 41 ++++++++++++++++++++++++++++++++++--
> > -----
> >  include/acpi/acpi_bus.h |  3 +++
> >  include/linux/acpi.h    |  6 ++++++
> >  3 files changed, 43 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 9d49a1acebe3..78db97687f26 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -737,16 +737,17 @@ bool acpi_dev_found(const char *hid)
> >  }
> >  EXPORT_SYMBOL(acpi_dev_found);
> > 
> > -struct acpi_dev_present_info {
> > +struct acpi_dev_match_info {
> > +       const char *dev_name;
> >         struct acpi_device_id hid[2];
> >         const char *uid;
> >         s64 hrv;
> >  };
> > 
> > -static int acpi_dev_present_cb(struct device *dev, void *data)
> > +static int acpi_dev_match_cb(struct device *dev, void *data)
> >  {
> >         struct acpi_device *adev = to_acpi_device(dev);
> > -       struct acpi_dev_present_info *match = data;
> > +       struct acpi_dev_match_info *match = data;
> >         unsigned long long hrv;
> >         acpi_status status;
> > 
> > @@ -757,6 +758,8 @@ static int acpi_dev_present_cb(struct device
> > *dev, void *data)
> >             strcmp(adev->pnp.unique_id, match->uid)))
> >                 return 0;
> > 
> > +       match->dev_name = acpi_dev_name(adev);
> > +
> >         if (match->hrv == -1)
> >                 return 1;
> > 
> > @@ -789,20 +792,44 @@ static int acpi_dev_present_cb(struct device
> > *dev, void *data)
> >   */
> >  bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
> >  {
> > -       struct acpi_dev_present_info match = {};
> > +       struct acpi_dev_match_info match = {};
> >         struct device *dev;
> > 
> >         strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
> >         match.uid = uid;
> >         match.hrv = hrv;
> > 
> > -       dev = bus_find_device(&acpi_bus_type, NULL, &match,
> > -                             acpi_dev_present_cb);
> > -
> > +       dev = bus_find_device(&acpi_bus_type, NULL, &match,
> > acpi_dev_match_cb);
> >         return !!dev;
> >  }
> >  EXPORT_SYMBOL(acpi_dev_present);
> > 
> > +/**
> > + * acpi_dev_get_first_match_name - Return name of first match of
> > ACPI device
> > + * @hid: Hardware ID of the device.
> > + * @uid: Unique ID of the device, pass NULL to not check _UID
> > + * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> > + *
> > + * Return device name if a matching device was present
> > + * at the moment of invocation, or NULL otherwise.
> > + *
> > + * See additional information in acpi_dev_present() as well.
> > + */
> > +const char *
> > +acpi_dev_get_first_match_name(const char *hid, const char *uid, s64
> > hrv)
> > +{
> > +       struct acpi_dev_match_info match = {};
> > +       struct device *dev;
> > +
> > +       strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
> > +       match.uid = uid;
> > +       match.hrv = hrv;
> > +
> > +       dev = bus_find_device(&acpi_bus_type, NULL, &match,
> > acpi_dev_match_cb);
> > +       return dev ? match.dev_name : NULL;
> > +}
> > +EXPORT_SYMBOL(acpi_dev_get_first_match_name);
> > +
> >  /*
> >   * acpi_backlight= handling, this is done here rather then in
> > video_detect.c
> >   * because __setup cannot be used in modules.
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 79287629c888..c9608b0b80c6 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -91,6 +91,9 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const
> > guid_t *guid, u64 rev,
> >  bool acpi_dev_found(const char *hid);
> >  bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
> > 
> > +const char *
> > +acpi_dev_get_first_match_name(const char *hid, const char *uid, s64
> > hrv);
> > +
> >  #ifdef CONFIG_ACPI
> > 
> >  #include <linux/proc_fs.h>
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 60f0d3248125..493ac6451773 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -642,6 +642,12 @@ static inline bool acpi_dev_present(const char
> > *hid, const char *uid, s64 hrv)
> >         return false;
> >  }
> > 
> > +static inline const char *
> > +acpi_dev_get_first_match_name(const char *hid, const char *uid, s64
> > hrv)
> > +{
> > +       return NULL;
> > +}
> > +
> >  static inline bool is_acpi_node(struct fwnode_handle *fwnode)
> >  {
> >         return false;
> > --
> > 2.15.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
