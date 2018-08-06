From: Vinod <vkoul@kernel.org>
Subject: Re: [bug report] soundwire: intel: Add Intel init
	module
Date: Mon, 6 Aug 2018 19:31:14 +0530
Message-ID: <20180806140114.GD2395@vkoul-mobl>
References: <20180806085512.tbhpwwh7sa6cf6yh@kili.mountain>
 <0c29a346-19c1-464f-eda5-f965dcdb598a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F3902677A2
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 16:01:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0c29a346-19c1-464f-eda5-f965dcdb598a@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On 06-08-18, 08:57, Pierre-Louis Bossart wrote:
> On 8/6/18 3:55 AM, Dan Carpenter wrote:
> > Hello Vinod Koul,
> > 
> > The patch d62a7d41f38e: "soundwire: intel: Add Intel init module"
> > from Dec 14, 2017, leads to the following static checker warning:
> > 
> > 	drivers/soundwire/intel_init.c:154 sdw_intel_acpi_cb()
> > 	error: uninitialized symbol 'adev'.
> > 
> > drivers/soundwire/intel_init.c
> >     147  static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
> >     148                                          void *cdata, void **return_value)
> >     149  {
> >     150          struct sdw_intel_res *res = cdata;
> >     151          struct acpi_device *adev;
> >     152
> >     153          if (acpi_bus_get_device(handle, &adev)) {
> >     154                  dev_err(&adev->dev, "Couldn't find ACPI handle\n");
> >     155                  return AE_NOT_FOUND;
> > 
> > We can't dereference "adev" if the acpi_bus_get_device() fails.
> 
> Might as well remove the error log, it's not very useful?

Or make it pr_err, will cook a patch ;-). I think for debug it is very
useful as one might have erroneously set the ACPI handle

-- 
~Vinod
