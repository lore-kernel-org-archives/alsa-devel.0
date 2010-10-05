From: Greg KH <greg@kroah.com>
Subject: Re: Staging: sst: add Intel SST audio driver
Date: Tue, 5 Oct 2010 08:48:56 -0700
Message-ID: <20101005154856.GA24478@kroah.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 92A0724525
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 18:10:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100930162123.21348.86482.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 05:21:32PM +0100, Alan Cox wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This is the Intel SST audio driver.
> 
> As compared to the previous versions it has all the printks and other stuff
> noted cleaned up and more hardware support. The Aava support is disabled in
> this patch (is_aava resolves to 0) because the Aava board detection logic
> is not yet upstream.
> 
> The driver itself is a combination of a traditional ALSA driver and a
> hardware assisted offload driver which can play audio while the processor
> is asleep but which can't do all the more interactive stuff.
> 
> In the general case most software would use the ALSA interface, but the
> other interface is needed for certain classes of use such as music playback
> on highly power consumption sensitive devices.
> 
> This is going to staging primarily because it depends upon the staging memrar
> driver.
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> [Merged together and tweaked for -next]
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> 
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -165,5 +165,7 @@ source "drivers/staging/bcm/Kconfig"
>  
>  source "drivers/staging/ft1000/Kconfig"
>  
> +source "drivers/staging/intel_sst/Kconfig"

You forgot to include the drivers/staging/intel_sst/Kconfig file in this
patch, so it breaks the build :(

Care to add it and resend the whole patch?

thanks,

greg k-h
