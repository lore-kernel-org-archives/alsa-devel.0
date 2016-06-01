From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 0/2] ASoC: da7219: Convert driver to use
	generic FW functions
Date: Wed, 1 Jun 2016 19:06:24 +0100
Message-ID: <cover.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 044332652AC
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 20:06:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: alsa-devel@alsa-project.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devel@acpica.org
List-Id: alsa-devel@alsa-project.org

This patch set converts the da7219 codec driver to use device/fwnode functions
to access properties, instead of the DT only of_* functions, allowing ACPI
to be used as well.

The DT bindings for da7219 have a device node for the main codec properties,
and a named child node (da7219_aad), which contains all of the accessory
detection related properties for the device. ACPI also supports this kind of
FW hierarchy (data only sub-nodes), but some support in the kernel needs to be
added to take make use of this in driver code.

The first patch adds functions to allow searching for a named child node of a
device, for both DT and ACPI, and the second patch updates the codec driver to
use the standard device/fwnode calls, including this new function.

These changes are based on the v4.7-rc1 kernel.

Changes in v2:
 - Rebase to v4.7-rc1
 - Small updates to codec patch based on previous reviewer comments

Adam Thomson (2):
  device property: Add function to search for named child of device
  ASoC: da7219: Convert driver to use generic device/fwnode functions

 drivers/base/property.c       |  28 ++++++++++++
 include/acpi/acpi_bus.h       |   7 +++
 include/linux/acpi.h          |   6 +++
 include/linux/property.h      |   3 ++
 sound/soc/codecs/da7219-aad.c | 103 +++++++++++++++++++++---------------------
 sound/soc/codecs/da7219.c     |  34 +++++++-------
 6 files changed, 112 insertions(+), 69 deletions(-)

--
1.9.3
