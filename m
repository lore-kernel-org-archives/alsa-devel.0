From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RESEND PATCH v3 1/2] device property: Add
 function to search for named child of device
Date: Tue, 21 Jun 2016 14:54:25 +0300
Message-ID: <20160621115425.GY1739@lahna.fi.intel.com>
References: <cover.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <20160621111126.GX1739@lahna.fi.intel.com>
 <28758107.YROb1rVtm6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 61EFA2614D6
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 13:54:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <28758107.YROb1rVtm6@vostro.rjw.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Takashi Iwai <tiwai@suse.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 21, 2016 at 01:42:16PM +0200, Rafael J. Wysocki wrote:
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

OK.

Maybe it is good idea to document that in acpi_data_node_match(). A
comment explaining why we use strcasecmp() for now.
