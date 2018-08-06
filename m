From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [bug report] soundwire: intel: Add Intel init
	module
Date: Mon, 6 Aug 2018 08:57:54 -0500
Message-ID: <0c29a346-19c1-464f-eda5-f965dcdb598a@linux.intel.com>
References: <20180806085512.tbhpwwh7sa6cf6yh@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EED42677A2
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 15:57:58 +0200 (CEST)
In-Reply-To: <20180806085512.tbhpwwh7sa6cf6yh@kili.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, vkoul@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/6/18 3:55 AM, Dan Carpenter wrote:
> Hello Vinod Koul,
> 
> The patch d62a7d41f38e: "soundwire: intel: Add Intel init module"
> from Dec 14, 2017, leads to the following static checker warning:
> 
> 	drivers/soundwire/intel_init.c:154 sdw_intel_acpi_cb()
> 	error: uninitialized symbol 'adev'.
> 
> drivers/soundwire/intel_init.c
>     147  static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>     148                                          void *cdata, void **return_value)
>     149  {
>     150          struct sdw_intel_res *res = cdata;
>     151          struct acpi_device *adev;
>     152
>     153          if (acpi_bus_get_device(handle, &adev)) {
>     154                  dev_err(&adev->dev, "Couldn't find ACPI handle\n");
>     155                  return AE_NOT_FOUND;
> 
> We can't dereference "adev" if the acpi_bus_get_device() fails.

Might as well remove the error log, it's not very useful?

> 
>     156          }
>     157
>     158          res->handle = handle;
>     159          return AE_OK;
>     160  }
> 
> Related:
> drivers/acpi/scan.c:2008 acpi_walk_dep_device_list() error: uninitialized symbol 'adev'.
> drivers/usb/core/usb-acpi.c:204 usb_acpi_find_companion() error: uninitialized symbol 'adev'.
> 
> regards,
> dan carpenter
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
