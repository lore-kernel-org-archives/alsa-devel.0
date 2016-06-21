From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RESEND PATCH v3 1/2] device property: Add function to search
 for named child of device
Date: Tue, 21 Jun 2016 14:11:26 +0300
Message-ID: <20160621111126.GX1739@lahna.fi.intel.com>
References: <cover.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1466421714.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J.Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Sathyanarayana Nujella <sathyanarayana.nujella-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2016 at 12:38:58PM +0100, Adam Thomson wrote:
> For device nodes in both DT and ACPI, it possible to have named
> child nodes which contain properties (an existing example being
> gpio-leds). This adds a function to find a named child node for
> a device which can be used by drivers for property retrieval.
> 
> For DT data node name matching, of_node_cmp() and similar functions
> are made available outside of CONFIG_OF block so the new function
> can reference these for DT and non-DT builds.
> 
> For ACPI data node name matching, a helper function is also added
> which returns false if CONFIG_ACPI is not set, otherwise it
> performs a string comparison on the data node name. This avoids
> using the acpi_data_node struct for non CONFIG_ACPI builds,
> which would otherwise cause a build failure.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> 
> Changes in v3:
>  - Move of_*_cmp() functions in of.h outside of CONFIG_OF block so they are
>    available for non-DT builds
>  - In device_get_named_child_node(), use of_node_cmp() helper macro instead of
>    strcasecmp() (node names not alway case insensitive, depending on platform).
> 
> Changes in v2:
>  - Rebase to v4.7-rc1
> 
>  drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h  |  7 +++++++
>  include/linux/acpi.h     |  6 ++++++
>  include/linux/of.h       | 14 +++++++-------
>  include/linux/property.h |  3 +++
>  5 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f38c21d..43a36d6 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -888,6 +888,34 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);
> 
>  /**
> + * device_get_named_child_node - Return first matching named child node handle
> + * @dev: Device to find the named child node for.
> + * @childname: String to match child node name against.
> + */
> +struct fwnode_handle *device_get_named_child_node(struct device *dev,
> +						  const char *childname)
> +{
> +	struct fwnode_handle *child;
> +
> +	/*
> +	 * Find first matching named child node of this device.
> +	 * For ACPI this will be a data only sub-node.
> +	 */
> +	device_for_each_child_node(dev, child) {
> +		if (is_of_node(child)) {
> +			if (!of_node_cmp(to_of_node(child)->name, childname))
> +				return child;
> +		} else if (is_acpi_data_node(child)) {
> +			if (acpi_data_node_match(child, childname))
> +				return child;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(device_get_named_child_node);
> +
> +/**
>   * fwnode_handle_put - Drop reference to a device node
>   * @fwnode: Pointer to the device node to drop the reference to.
>   *
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 788c6c3..993bdd0 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -420,6 +420,13 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
>  		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
>  }
> 
> +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
> +					const char *name)
> +{
> +	return is_acpi_data_node(fwnode) ?
> +		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
> +}

Looks fine to me.

One question - is it expected that matching ACPI data nodes is always
case insensitive?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
