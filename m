From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH v3 1/2] device property: Add
	function to search for named child of device
Date: Tue, 21 Jun 2016 13:42:16 +0200
Message-ID: <28758107.YROb1rVtm6@vostro.rjw.lan>
References: <cover.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <20160621111126.GX1739@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134]) by alsa0.perex.cz (Postfix) with SMTP id B72712608EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 13:37:58 +0200 (CEST)
In-Reply-To: <20160621111126.GX1739@lahna.fi.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Takashi Iwai <tiwai@suse.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday, June 21, 2016 02:11:26 PM Mika Westerberg wrote:
> On Mon, Jun 20, 2016 at 12:38:58PM +0100, Adam Thomson wrote:
> > For device nodes in both DT and ACPI, it possible to have named
> > child nodes which contain properties (an existing example being
> > gpio-leds). This adds a function to find a named child node for
> > a device which can be used by drivers for property retrieval.
> > 
> > For DT data node name matching, of_node_cmp() and similar functions
> > are made available outside of CONFIG_OF block so the new function
> > can reference these for DT and non-DT builds.
> > 
> > For ACPI data node name matching, a helper function is also added
> > which returns false if CONFIG_ACPI is not set, otherwise it
> > performs a string comparison on the data node name. This avoids
> > using the acpi_data_node struct for non CONFIG_ACPI builds,
> > which would otherwise cause a build failure.
> > 
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > 
> > Changes in v3:
> >  - Move of_*_cmp() functions in of.h outside of CONFIG_OF block so they are
> >    available for non-DT builds
> >  - In device_get_named_child_node(), use of_node_cmp() helper macro instead of
> >    strcasecmp() (node names not alway case insensitive, depending on platform).
> > 
> > Changes in v2:
> >  - Rebase to v4.7-rc1
> > 
> >  drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
> >  include/acpi/acpi_bus.h  |  7 +++++++
> >  include/linux/acpi.h     |  6 ++++++
> >  include/linux/of.h       | 14 +++++++-------
> >  include/linux/property.h |  3 +++
> >  5 files changed, 51 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index f38c21d..43a36d6 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -888,6 +888,34 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
> >  EXPORT_SYMBOL_GPL(device_get_next_child_node);
> > 
> >  /**
> > + * device_get_named_child_node - Return first matching named child node handle
> > + * @dev: Device to find the named child node for.
> > + * @childname: String to match child node name against.
> > + */
> > +struct fwnode_handle *device_get_named_child_node(struct device *dev,
> > +						  const char *childname)
> > +{
> > +	struct fwnode_handle *child;
> > +
> > +	/*
> > +	 * Find first matching named child node of this device.
> > +	 * For ACPI this will be a data only sub-node.
> > +	 */
> > +	device_for_each_child_node(dev, child) {
> > +		if (is_of_node(child)) {
> > +			if (!of_node_cmp(to_of_node(child)->name, childname))
> > +				return child;
> > +		} else if (is_acpi_data_node(child)) {
> > +			if (acpi_data_node_match(child, childname))
> > +				return child;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(device_get_named_child_node);
> > +
> > +/**
> >   * fwnode_handle_put - Drop reference to a device node
> >   * @fwnode: Pointer to the device node to drop the reference to.
> >   *
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 788c6c3..993bdd0 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -420,6 +420,13 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
> >  		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
> >  }
> > 
> > +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
> > +					const char *name)
> > +{
> > +	return is_acpi_data_node(fwnode) ?
> > +		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
> > +}
> 
> Looks fine to me.
> 
> One question - is it expected that matching ACPI data nodes is always
> case insensitive?

That would not be a correct expectation in theory, although I don't think it
really matters in practice.

Thanks,
Rafael
