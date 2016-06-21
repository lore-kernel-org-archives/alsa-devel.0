From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH v3 1/2] device property: Add
 function to search for named child of device
Date: Tue, 21 Jun 2016 11:50:01 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D46442AB@SW-EX-MBX01.diasemi.com>
References: <cover.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <20160621111126.GX1739@lahna.fi.intel.com>
 <28758107.YROb1rVtm6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F0592608EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 13:50:03 +0200 (CEST)
In-Reply-To: <28758107.YROb1rVtm6@vostro.rjw.lan>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Takashi Iwai <tiwai@suse.com>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

21 June 2016 12:42, Rafael J. Wysocki wrote:

> > > +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
> > > +					const char *name)
> > > +{
> > > +	return is_acpi_data_node(fwnode) ?
> > > +		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
> > > +}
> >
> > Looks fine to me.
> >
> > One question - is it expected that matching ACPI data nodes is always
> > case insensitive?
> 
> That would not be a correct expectation in theory, although I don't think it
> really matters in practice.

>From my reading of the Hierarchical Data Extension and ACPI Spec, I thought
that was the case (section 19.3.1 ASL Names - ASL names are not case-sensitive
and will be converted to upper case). Am I misreading the documents/missing
something else?
