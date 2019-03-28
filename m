From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 01/10] ACPI / utils: Introduce
 acpi_dev_get_first_match_dev() helper
Date: Thu, 28 Mar 2019 23:38:54 +0200
Message-ID: <20190328213854.GO9224@smile.fi.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <20190328171729.44002-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iXU755aL9kbLzKMZoaGVQn_3AohkVfQvwLv=sACHutPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49B76F80769
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 22:39:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iXU755aL9kbLzKMZoaGVQn_3AohkVfQvwLv=sACHutPw@mail.gmail.com>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 28, 2019 at 09:12:49PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 28, 2019 at 6:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The acpi_dev_get_first_match_name() is missing put_device() call
> > and thus keeping reference counting unbalanced.
> >
> > In order to fix the issue introduce a new helper to convert existing users
> > one-by-one to a better API. And then remove the old one.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Any differences between this and the previous one?  I've queued up
> that one already.

Not a single bit. Just Hans' tag is added.

> 
> > ---
> >  drivers/acpi/utils.c    | 24 ++++++++++++++++++++++--
> >  include/acpi/acpi_bus.h |  3 +++
> >  include/linux/acpi.h    |  6 ++++++
> >  3 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index c4b06cc075f9..5a2bae2b6c3a 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -739,6 +739,7 @@ EXPORT_SYMBOL(acpi_dev_found);
> >
> >  struct acpi_dev_match_info {
> >         const char *dev_name;
> > +       struct acpi_device *adev;
> >         struct acpi_device_id hid[2];
> >         const char *uid;
> >         s64 hrv;
> > @@ -759,6 +760,7 @@ static int acpi_dev_match_cb(struct device *dev, void *data)
> >                 return 0;
> >
> >         match->dev_name = acpi_dev_name(adev);
> > +       match->adev = adev;
> >
> >         if (match->hrv == -1)
> >                 return 1;
> > @@ -806,16 +808,34 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
> >  EXPORT_SYMBOL(acpi_dev_present);
> >
> >  /**
> > - * acpi_dev_get_first_match_name - Return name of first match of ACPI device
> > + * acpi_dev_get_first_match_dev - Return the first match of ACPI device
> >   * @hid: Hardware ID of the device.
> >   * @uid: Unique ID of the device, pass NULL to not check _UID
> >   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> >   *
> > - * Return device name if a matching device was present
> > + * Return the first match of ACPI device if a matching device was present
> >   * at the moment of invocation, or NULL otherwise.
> >   *
> > + * The caller is responsible to call put_device() on the returned device.
> > + *
> >   * See additional information in acpi_dev_present() as well.
> >   */
> > +struct acpi_device *
> > +acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> > +{
> > +       struct acpi_dev_match_info match = {};
> > +       struct device *dev;
> > +
> > +       strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
> > +       match.uid = uid;
> > +       match.hrv = hrv;
> > +
> > +       dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
> > +       return dev ? match.adev : NULL;
> > +}
> > +EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
> > +
> > +/* DEPRECATED, use acpi_dev_get_first_match_dev() instead */
> >  const char *
> >  acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv)
> >  {
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 0300374101cd..2063e9e2f384 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -91,6 +91,9 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
> >  bool acpi_dev_found(const char *hid);
> >  bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
> >
> > +struct acpi_device *
> > +acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
> > +
> >  const char *
> >  acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv);
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index d5dcebd7aad3..3e1d16b00513 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -669,6 +669,12 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
> >         return false;
> >  }
> >
> > +static inline struct acpi_device *
> > +acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> > +{
> > +       return NULL;
> > +}
> > +
> >  static inline const char *
> >  acpi_dev_get_first_match_name(const char *hid, const char *uid, s64 hrv)
> >  {
> > --
> > 2.20.1
> >

-- 
With Best Regards,
Andy Shevchenko
