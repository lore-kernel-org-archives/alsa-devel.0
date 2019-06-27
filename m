From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] device property: Add new array helper
Date: Thu, 27 Jun 2019 13:02:32 +0200
Message-ID: <CAJZ5v0hmMW-3UvvJch+NuYgQ+0iGP-LMrxP8p9wkmaGm1zAQoQ@mail.gmail.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <CAJZ5v0hvN=8YmF+v6wKx9mQ=DRosAtK7QU=EWYf5PXEDsn4FEQ@mail.gmail.com>
 <20190627102345.GG54126@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B00CF80C0B
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 13:02:45 +0200 (CEST)
Received: by mail-ot1-f65.google.com with SMTP id z23so1784493ote.13
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 04:02:45 -0700 (PDT)
In-Reply-To: <20190627102345.GG54126@ediswmail.ad.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 27, 2019 at 12:23 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Jun 27, 2019 at 11:39:10AM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 26, 2019 at 5:36 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > +       n = device_property_read_u32_array(dev, propname, NULL, 0);
> > > +       if (n == -EINVAL) {
> > > +               return 0;       /* missing, ignore */
> >
> > Why can't the caller use the (scheduled for merging in the 5.3 cycle)
> > new device_property_count_u32() to get the size of the array?
> >
>
> I wasn't aware of it, am now.
>
> > > +       } else if (n < 0) {
> > > +               dev_warn(dev, "%s malformed (%d)\n", propname, n);
> >
> > Why dev_warn()?  Is there any reason real for anything higher-level
> > that dev_dbg() here?
> >
>
> Nice to know that your DT wasn't valid, but could be left to the
> caller I guess.

Right.  And only print the message when the caller really is going to fail.

> > > +               return n;
> > > +       } else if ((n % multiple) != 0) {
> >
> > I guess the reason why this matters is that the caller expects a
> > certain number of full "rows" and n values are read.  Why not to
> > discard the extra values instead of returning an error here?
> >
>
> No reason really why it couldn't. Although my expectation would
> generally be this helper is for reading a variable number of
> fixed size groups. As in each group represents a "whole" item but
> you don't know how many of those you have.

That really depends on how the property is defined and which is what
the caller knows.

> > > +               dev_warn(dev, "%s not a multiple of %d entries\n",
> > > +                        propname, multiple);
> > > +               return -EOVERFLOW;
> >
> > Why this error code?
> >
>
> As that is the error code all the device_property functions
> return when the size is not as expected.

To be precise, when there is a mismatch between the storage space
supplied by the caller and the property size.  That does not seem to
be the case here.  It is rather about the property format being not as
expected and that would be -EPROTO.

> > > +       if (n > nval)
> > > +               n = nval;
> > > +
> > > +       ret = device_property_read_u32_array(dev, propname, val, n);
> >
> > So this reads "copy at most nval values from the array property".
> >
> > If that's really what you need, it can be done in two lines of code in
> > prospective callers of this wrapper.
> >
>
> Indeed the helper here is basically exactly what would be done in
> the caller if no helper existed.
>
> > > +int device_property_read_u32_2darray(struct device *dev, const char *propname,
> > > +                                    u32 *val, size_t nval, int multiple);
> > >  int device_property_read_u64_array(struct device *dev, const char *propname,
> > >                                    u64 *val, size_t nval);
> > >  int device_property_read_string_array(struct device *dev, const char *propname,
> > > --
> >
> > I don't see much value in this change, sorry.
>
> That is fine, I don't have any problem with the helper living
> within our driver instead. Basically the issue from my side is I
> need to read 6 different device tree properties all of which
> require this behaviour, ie. read a variable number of fixed
> groups and check I have whole groups. Open coding this for each
> call is indeed only going to be 5-10 lines of code

Exactly two:

n = device_property_count_u32(dev, name);
ret = device_property_read_u32_array(dev, propname, val, n > nval ? nval : n);

And I would be fine with adding wrappers like this (and for the other
data types too for that matter).

It would take more lines if you wanted to complain about the format,
but as pointed out above, that would need to be done in the caller
anyway.

> for each one  but since there are 6 of them it makes sense to put those 5-10
> lines into a helper and have 5-10 lines not 30-60 lines. Seemed
> the helper might be generally more useful, but if it is not then
> it can go back into the driver.
