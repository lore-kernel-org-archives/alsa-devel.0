From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v4 0/2] ASoC: da7219: Convert driver to use
 generic FW functions
Date: Tue, 21 Jun 2016 22:54:39 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D4644644@SW-EX-MBX01.diasemi.com>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
 <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D878261561
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 00:54:44 +0200 (CEST)
In-Reply-To: <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com>
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
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Opensource [Adam
 Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, devicetree <devicetree@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 21 June 2016 23:30, Rafael J. Wysocki wrote:

> > This patch set converts the da7219 codec driver to use device/fwnode functions
> > to access properties, instead of the DT only of_* functions, allowing ACPI
> > to be used as well.
> >
> > The DT bindings for da7219 have a device node for the main codec properties,
> > and a named child node (da7219_aad), which contains all of the accessory
> > detection related properties for the device. ACPI also supports this kind of
> > FW hierarchy (data only sub-nodes), but some support in the kernel needs to be
> > added to take make use of this in driver code.
> >
> > The first patch adds functions to allow searching for a named child node of a
> > device, for both DT and ACPI, and the second patch updates the codec driver to
> > use the standard device/fwnode calls, including this new function.
> >
> > These changes are based on the v4.7-rc4 kernel.
> >
> > Changes in v4:
> >   - Rebase to v4.7-rc4
> >   - Use strcmp() in acpi_data_node_match() for matching ACPI data nodes.
> >
> > Changes in v3:
> >   - Use of_node_cmp() in device_get_named_child_node() to match DT node.
> >
> > Changes in v2:
> >   - Rebase to v4.7-rc1
> >   - Small updates to codec patch based on previous reviewer comments
> >
> > Adam Thomson (2):
> >    device property: Add function to search for named child of device
> >    ASoC: da7219: Convert driver to use generic device/fwnode functions
> >
> >   drivers/base/property.c       |  28 ++++++++++++
> >   include/acpi/acpi_bus.h       |   7 +++
> >   include/linux/acpi.h          |   6 +++
> >   include/linux/of.h            |  14 +++---
> >   include/linux/property.h      |   3 ++
> >   sound/soc/codecs/da7219-aad.c | 103 +++++++++++++++++++++--------------------
> -
> >   sound/soc/codecs/da7219.c     |  34 +++++++-------
> >   7 files changed, 119 insertions(+), 76 deletions(-)
> >
> > --
> > 1.9.3
> >
> I'm fine with the first patch and the second one carries a couple of
> ACKs already, so do you want me to apply them both?

Thanks Rafael. I think we still need Mark's Ack for the ASoC codec changes
though before we can proceed.
