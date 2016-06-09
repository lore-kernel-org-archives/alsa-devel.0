From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RESEND PATCH v2 1/2] device property: Add function to search for
 named child of device
Date: Fri, 10 Jun 2016 01:11:06 +0200
Message-ID: <97f80018-7cc4-0a50-498d-89d27dfa2fd1@intel.com>
References: <cover.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <7105258db927c65dfa41a8abeef4b9735871d023.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <7105258db927c65dfa41a8abeef4b9735871d023.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Hanjun Guo <hanjun.guo@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On 6/9/2016 5:13 PM, Adam Thomson wrote:
> For device nodes in both DT and ACPI, it possible to have named
> child nodes which contain properties (an existing example being
> gpio-leds). This adds a function to find a named child node for
> a device which can be used by drivers for property retrieval.
>
> For ACPI data node name matching, a helper function is also added
> which returns false if CONFIG_ACPI is not set, otherwise it
> performs a string comparison on the data node name. This avoids
> using the acpi_data_node struct for non CONFIG_ACPI builds,
> which would otherwise cause a build failure.
>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

For some reason that didn't make it into the linux-acpi list, or at 
least I can't see it there.

> ---
>
> Changes in v2:
>   - Rebase to v4.7-rc1
>
>   drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
>   include/acpi/acpi_bus.h  |  7 +++++++
>   include/linux/acpi.h     |  6 ++++++
>   include/linux/property.h |  3 +++
>   4 files changed, 44 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f38c21d..573b361 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -888,6 +888,34 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>   EXPORT_SYMBOL_GPL(device_get_next_child_node);
>
>   /**
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
> +			if (!strcasecmp(to_of_node(child)->name, childname))

Why do you use strcasecmp() here?

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
>    * fwnode_handle_put - Drop reference to a device node
>    * @fwnode: Pointer to the device node to drop the reference to.
>    *
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 788c6c3..993bdd0 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -420,6 +420,13 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
>   		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
>   }
>
> +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
> +					const char *name)
> +{
> +	return is_acpi_data_node(fwnode) ?
> +		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
> +}

Is there any particular reason to introduce this function instead of 
doing the test in device_get_named_child_node() directly?

> +
>   static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
>   {
>   	return &adev->fwnode;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 288fac5..03039c4 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -568,6 +568,12 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
>   	return NULL;
>   }
>
> +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
> +					const char *name)
> +{
> +	return false;
> +}
> +
>   static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
>   {
>   	return NULL;
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ecab11e..3a2f9ae 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -77,6 +77,9 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>   	for (child = device_get_next_child_node(dev, NULL); child;	\
>   	     child = device_get_next_child_node(dev, child))
>
> +struct fwnode_handle *device_get_named_child_node(struct device *dev,
> +						  const char *childname);
> +
>   void fwnode_handle_put(struct fwnode_handle *fwnode);
>
>   unsigned int device_get_child_node_count(struct device *dev);
> --

Mika, Heikki, Andy, any feedback on this one?

