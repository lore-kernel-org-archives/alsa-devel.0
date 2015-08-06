From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/12] drm/amdgpu: add amd_gnb_bus support
Date: Thu, 06 Aug 2015 21:36:02 +0200
Message-ID: <55C3B722.1010507@metafoo.de>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-018.synserver.de
 [212.40.185.18])
 by alsa0.perex.cz (Postfix) with ESMTP id ACA77260560
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 21:36:04 +0200 (CEST)
In-Reply-To: <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>, broonie@kernel.org, airlied@gmail.com, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Chunming Zhou <david1.zhou@amd.com>, Alex Deucher <alexander.deucher@amd.com>, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

> @@ -134,6 +136,7 @@ config DRM_AMDGPU
>  	select HWMON
>  	select BACKLIGHT_CLASS_DEVICE
>  	select INTERVAL_TREE
> +	select DRM_AMD_GNB_BUS

Here you select the symbol.

[...]

> +config DRM_AMD_GNB_BUS
> +	tristate "AMD GNB bus - used for GNB IPs such as ACP and ISP"

Here you make it user selectable. Use either or having both doesn't work too
well.

> +
> +endmenu
> diff --git a/drivers/gpu/drm/amd/bus/Makefile b/drivers/gpu/drm/amd/bus/Makefile
> new file mode 100644
> index 0000000..c41ffc9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/bus/Makefile
> @@ -0,0 +1,4 @@
> +#
> +ccflags-y := -Iinclude/drm -Idrivers/gpu/drm/amd/include/bus/
> +
> +obj-$(CONFIG_DRM_AMD_GNB_BUS) := amd_gnb_bus.o
> diff --git a/drivers/gpu/drm/amd/bus/amd_gnb_bus.c b/drivers/gpu/drm/amd/bus/amd_gnb_bus.c
> new file mode 100644
> index 0000000..071b16c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/bus/amd_gnb_bus.c
> @@ -0,0 +1,266 @@
[..]
> +#ifdef CONFIG_PM_SLEEP
> +static int amd_gnb_bus_legacy_suspend(struct device *dev, pm_message_t mesg)
> +{
> +	struct amd_gnb_bus_dev *amd_gnb_bus_dev = to_amd_gnb_bus_device(dev);
> +	struct amd_gnb_bus_driver *driver;
> +
> +	if (!amd_gnb_bus_dev || !dev->driver)
> +		return 0;
> +	driver = to_amd_gnb_bus_driver(dev->driver);
> +	if (!driver->suspend)
> +		return 0;
> +	return driver->suspend(amd_gnb_bus_dev, mesg);
> +}
> +
> +static int amd_gnb_bus_legacy_resume(struct device *dev)
> +{
> +	struct amd_gnb_bus_dev *amd_gnb_bus_dev = to_amd_gnb_bus_device(dev);
> +	struct amd_gnb_bus_driver *driver;
> +
> +	if (!amd_gnb_bus_dev || !dev->driver)
> +		return 0;
> +	driver = to_amd_gnb_bus_driver(dev->driver);
> +	if (!driver->resume)
> +		return 0;
> +	return driver->resume(amd_gnb_bus_dev);
> +}
[...]


Preferably don't add support for legacy suspend/resume to new subsystems.
Support for this is supposed to be removed from the kernel. Just use
dev_pm_ops and then you can drop all of the above since the PM core does the
right thing on its own for dev_pm_ops. No need to have support at the bus
level if there is nothing special to do at the bus level.

[...]
