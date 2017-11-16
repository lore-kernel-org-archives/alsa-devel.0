From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 03/13] slimbus: Add SLIMbus bus type
Date: Thu, 16 Nov 2017 18:48:14 +0530
Message-ID: <20171116131814.GV3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A33266D7D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 14:15:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-4-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:33PM +0000, srinivas.kandagatla@linaro.org wrote:

> +menuconfig SLIMBUS
> +	tristate "Slimbus support"
> +	help
> +	  Slimbus is standard interface between System-on-Chip and audio codec,
> +	  and other peripheral components in typical embedded systems.
> +
> +	  If unsure, choose N.
> +
> +if SLIMBUS
> +
> +# SlIMbus controllers

Slimbus perhaps?

> +static int slim_device_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct slim_device *sbdev = to_slim_device(dev);
> +	struct slim_driver *sbdrv = to_slim_driver(drv);
> +
> +	return slim_match(sbdrv->id_table, sbdev) != NULL;

return !!slim_match() ?

> +static int slim_device_probe(struct device *dev)
> +{
> +	struct slim_device	*sbdev;
> +	struct slim_driver	*sbdrv;
> +	int ret = 0;
> +
> +	sbdev = to_slim_device(dev);
> +	sbdrv = to_slim_driver(dev->driver);
> +
> +	if (sbdrv->probe)
> +		ret = sbdrv->probe(sbdev);

shouldn't probe be mandatory :)

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 1c2e8d6b7274..7d6238863fc1 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -452,6 +452,19 @@ struct spi_device_id {
>  	kernel_ulong_t driver_data;	/* Data private to the driver */
>  };
>  
> +/* SLIMbus */
> +
> +#define SLIMBUS_NAME_SIZE	32
> +#define SLIMBUS_MODULE_PREFIX	"slim:"
> +
> +struct slim_device_id {
> +	__u16 manf_id, prod_code;
> +	__u8 dev_index, instance;
> +
> +	/* Data private to the driver */
> +	kernel_ulong_t driver_data;

As Takashi pointed out in SDW patches, this needs to be aligned.

> +};
> +

I was hoping to see changes to devicetable-offsets.c and file2alias.c as
well as that is required for module autoloading. I think that is required?

> +/**
> + * struct slim_device - Slim device handle.
> + * @dev: Driver model representation of the device.
> + * @name: Name of driver to use with this device.
> + * @e_addr: Enumeration address of this device.
> + * @driver: Device's driver. Pointer to access routines.
> + * @laddr: 1-byte Logical address of this device.
> + *
> + * This is the client/device handle returned when a slimbus
> + * device is registered with a controller.
> + * Pointer to this structure is used by client-driver as a handle.
> + */
> +struct slim_device {
> +	struct device		dev;
> +	struct slim_eaddr	e_addr;
> +	struct list_head node;

aligned with others please

> +/**
> + * struct slim_driver - Slimbus 'generic device' (slave) device driver
> + *				(similar to 'spi_device' on SPI)
> + * @probe: Binds this driver to a slimbus device.
> + * @remove: Unbinds this driver from the slimbus device.
> + * @shutdown: Standard shutdown callback used during powerdown/halt.
> + * @device_status: This callback is called when
> + *	-The device reports present and gets a laddr assigned
> + *	-The device reports absent, or the bus goes down.

space after - pls

-- 
~Vinod
