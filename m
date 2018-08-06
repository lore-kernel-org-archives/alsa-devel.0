From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] soundwire: intel: Add Intel init module
Date: Mon, 6 Aug 2018 11:55:12 +0300
Message-ID: <20180806085512.tbhpwwh7sa6cf6yh@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B4CD267692
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 10:55:22 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vkoul@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Vinod Koul,

The patch d62a7d41f38e: "soundwire: intel: Add Intel init module"
from Dec 14, 2017, leads to the following static checker warning:

	drivers/soundwire/intel_init.c:154 sdw_intel_acpi_cb()
	error: uninitialized symbol 'adev'.

drivers/soundwire/intel_init.c
   147  static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
   148                                          void *cdata, void **return_value)
   149  {
   150          struct sdw_intel_res *res = cdata;
   151          struct acpi_device *adev;
   152  
   153          if (acpi_bus_get_device(handle, &adev)) {
   154                  dev_err(&adev->dev, "Couldn't find ACPI handle\n");
   155                  return AE_NOT_FOUND;

We can't dereference "adev" if the acpi_bus_get_device() fails.

   156          }
   157  
   158          res->handle = handle;
   159          return AE_OK;
   160  }

Related:
drivers/acpi/scan.c:2008 acpi_walk_dep_device_list() error: uninitialized symbol 'adev'.
drivers/usb/core/usb-acpi.c:204 usb_acpi_find_companion() error: uninitialized symbol 'adev'.

regards,
dan carpenter
