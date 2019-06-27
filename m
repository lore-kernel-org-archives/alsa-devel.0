From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] device property: Add new array helper
Date: Thu, 27 Jun 2019 13:33:43 +0100
Message-ID: <20190627123343.GH54126@ediswmail.ad.cirrus.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <CAJZ5v0hvN=8YmF+v6wKx9mQ=DRosAtK7QU=EWYf5PXEDsn4FEQ@mail.gmail.com>
 <20190627102345.GG54126@ediswmail.ad.cirrus.com>
 <CAJZ5v0hmMW-3UvvJch+NuYgQ+0iGP-LMrxP8p9wkmaGm1zAQoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D75EEF806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 14:33:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hmMW-3UvvJch+NuYgQ+0iGP-LMrxP8p9wkmaGm1zAQoQ@mail.gmail.com>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 27, 2019 at 01:02:32PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 27, 2019 at 12:23 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Jun 27, 2019 at 11:39:10AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 26, 2019 at 5:36 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > That is fine, I don't have any problem with the helper living
> > within our driver instead. Basically the issue from my side is I
> > need to read 6 different device tree properties all of which
> > require this behaviour, ie. read a variable number of fixed
> > groups and check I have whole groups. Open coding this for each
> > call is indeed only going to be 5-10 lines of code
> 
> Exactly two:
> 
> n = device_property_count_u32(dev, name);
> ret = device_property_read_u32_array(dev, propname, val, n > nval ? nval : n);
> 
> And I would be fine with adding wrappers like this (and for the other
> data types too for that matter).
> 
> It would take more lines if you wanted to complain about the format,
> but as pointed out above, that would need to be done in the caller
> anyway.
> 

Ok I think that helps me to follow the situation. If
device_property_count cuts down the code required and leaves the
majority of the code as printing the messages which then wants to
live in the end driver anyways it probably isn't worth adding a
core helper for this.

Thank you for the review and the explanation. I will update the
driver patches to use the new function and resend those.

Thanks,
Charles

> > for each one  but since there are 6 of them it makes sense to put those 5-10
> > lines into a helper and have 5-10 lines not 30-60 lines. Seemed
> > the helper might be generally more useful, but if it is not then
> > it can go back into the driver.
