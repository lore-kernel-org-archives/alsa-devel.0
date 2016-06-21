From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/2] ASoC: da7219: Convert driver to use generic FW
 functions
Date: Wed, 22 Jun 2016 00:30:06 +0200
Message-ID: <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1466523027.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Sathyanarayana Nujella <sathyanarayana.nujella-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 6/21/2016 7:50 PM, Adam Thomson wrote:
> This patch set converts the da7219 codec driver to use device/fwnode functions
> to access properties, instead of the DT only of_* functions, allowing ACPI
> to be used as well.
>
> The DT bindings for da7219 have a device node for the main codec properties,
> and a named child node (da7219_aad), which contains all of the accessory
> detection related properties for the device. ACPI also supports this kind of
> FW hierarchy (data only sub-nodes), but some support in the kernel needs to be
> added to take make use of this in driver code.
>
> The first patch adds functions to allow searching for a named child node of a
> device, for both DT and ACPI, and the second patch updates the codec driver to
> use the standard device/fwnode calls, including this new function.
>
> These changes are based on the v4.7-rc4 kernel.
>
> Changes in v4:
>   - Rebase to v4.7-rc4
>   - Use strcmp() in acpi_data_node_match() for matching ACPI data nodes.
>
> Changes in v3:
>   - Use of_node_cmp() in device_get_named_child_node() to match DT node.
>
> Changes in v2:
>   - Rebase to v4.7-rc1
>   - Small updates to codec patch based on previous reviewer comments
>
> Adam Thomson (2):
>    device property: Add function to search for named child of device
>    ASoC: da7219: Convert driver to use generic device/fwnode functions
>
>   drivers/base/property.c       |  28 ++++++++++++
>   include/acpi/acpi_bus.h       |   7 +++
>   include/linux/acpi.h          |   6 +++
>   include/linux/of.h            |  14 +++---
>   include/linux/property.h      |   3 ++
>   sound/soc/codecs/da7219-aad.c | 103 +++++++++++++++++++++---------------------
>   sound/soc/codecs/da7219.c     |  34 +++++++-------
>   7 files changed, 119 insertions(+), 76 deletions(-)
>
> --
> 1.9.3
>
I'm fine with the first patch and the second one carries a couple of 
ACKs already, so do you want me to apply them both?


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
