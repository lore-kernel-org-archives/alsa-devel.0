From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 10:41:01 +0530
Message-ID: <20171020051101.GG30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <s5hzi8nvb55.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 97654266A51
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 07:06:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzi8nvb55.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 09:40:06AM +0200, Takashi Iwai wrote:
> On Thu, 19 Oct 2017 05:03:18 +0200,
> Vinod Koul wrote:
> > +
> > +config SOUNDWIRE_BUS
> > +	tristate
> > +	default SOUNDWIRE
> > +
> 
> Does it make sense to be tristate?
> Since CONFIG_SOUNDWIRE is a bool, the above would be also only either
> Y or N.  If it's Y and others select M, it'll be still Y.

hmmm good point. I think would make sense to make SOUNDWIRE as tristate too,
just like SOUND :)

> > + * sdw_get_device_id: find the matching SoundWire device id
> > + *
> > + * @slave: SoundWire Slave device
> > + * @drv: SoundWire Slave Driver
> 
> Inconsistent upper/lower letters in these two lines.

thanks for spotting, will fix

> > + * The match is done by comparing the mfg_id and part_id from the
> > + * struct sdw_device_id. class_id is unused, as it is a placeholder
> > + * in MIPI Spec.
> > + */
> > +static const struct sdw_device_id *
> > +sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> > +{
> > +	const struct sdw_device_id *id = drv->id_table;
> > +
> > +	while (id && id->mfg_id) {
> > +		if (slave->id.mfg_id == id->mfg_id &&
> > +				slave->id.part_id == id->part_id) {
> 
> Please indentation properly.

what do you advise?

		if (slave->id.mfg_id == id->mfg_id &&
			slave->id.part_id == id->part_id) {

would mean below one is at same indent. Some people use:

		if (slave->id.mfg_id == id->mfg_id &&
		   slave->id.part_id == id->part_id) {

Is it Documented anywhere...


> 
> > +			return id;
> > +		}
> 
> Superfluous braces for a single-line.

That bit was intentional. Yes it is not required but given that if condition
was falling to two lines, I wanted to help readability by adding these. I can
remove them..

> 
> > +		id++;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
> > +{
> > +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> > +	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
> > +
> > +	return !!sdw_get_device_id(slave, drv);
> > +}
> > +
> > +int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size)
> 
> I'd put const to slave argument, as it won't be modified.

right...

> 
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -228,6 +228,13 @@ struct hda_device_id {
> >  	unsigned long driver_data;
> >  };
> >  
> > +struct sdw_device_id {
> > +	__u16 mfg_id;
> > +	__u16 part_id;
> > +	__u8 class_id;
> > +	kernel_ulong_t driver_data;
> 
> Better to think of alignment.

sorry not quite clear, do you mind elaborating which ones to align?

> 
> 
> > --- /dev/null
> > +++ b/include/linux/soundwire/sdw.h
> ....
> > +/**
> > + * struct sdw_bus: SoundWire bus
> > + *
> > + * @dev: Master linux device
> > + * @link_id: Link id number, can be 0 to N, unique for each Master
> > + * @slaves: list of Slaves on this bus
> > + * @assigned: logical addresses assigned, Index 0 (broadcast) would be unused
> > + * @bus_lock: bus lock
> > + */
> > +struct sdw_bus {
> > +	struct device *dev;
> > +	unsigned int link_id;
> > +	struct list_head slaves;
> > +	bool assigned[SDW_MAX_DEVICES + 1];
> 
> Why not a bitmap?

That a very good suggestion, it will help in other things too :)

-- 
~Vinod
