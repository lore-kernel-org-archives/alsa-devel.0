From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] device property: Add function to search for named
 child of device
Date: Tue, 14 Jun 2016 10:49:59 -0500
Message-ID: <CAL_JsqJ9g7sMALzZs3y2eONf0j=ZrrGvC23Sd7OO+ujcax=5BQ@mail.gmail.com>
References: <cover.1465908072.git.Adam.Thomson.Opensource@diasemi.com> <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1465908072.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1465908072.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J.Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Sathyanarayana Nujella <sathyanarayana.nujella-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2016 at 8:56 AM, Adam Thomson
<Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org> wrote:
> For device nodes in both DT and ACPI, it possible to have named
> child nodes which contain properties (an existing example being
> gpio-leds). This adds a function to find a named child node for
> a device which can be used by drivers for property retrieval.
>
> For DT data node name matching, of_node_cmp() and similar functions are made
> available outside of CONFIG_OF block so the new function can reference these
> for DT and non-DT builds.
>
> For ACPI data node name matching, a helper function is also added
> which returns false if CONFIG_ACPI is not set, otherwise it
> performs a string comparison on the data node name. This avoids
> using the acpi_data_node struct for non CONFIG_ACPI builds,
> which would otherwise cause a build failure.
>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
