From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 10/15] soundwire: Add sysfs for
 SoundWire DisCo properties
Date: Wed, 13 Dec 2017 15:24:30 +0530
Message-ID: <20171213095430.GO18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-11-git-send-email-vinod.koul@intel.com>
 <20171213091537.GA6269@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DB2266AE4
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 10:50:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171213091537.GA6269@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 10:15:37AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 06, 2017 at 09:17:06PM +0530, Vinod Koul wrote:
> > It helps to read the properties for understanding and debugging
> > systems, so add sysfs files for SoundWire DisCo properties.
> > 
> > TODO: Add ABI files for sysfs
> 
> Is this TODO done?

Nope sorry not yet. But before this get merged will add

> > + * Base file is:
> > + *		properties
> > + *		|---- interface-revision
> > + *		|---- master-count
> > + *		|---- link-N
> > + *		      |---- clock-stop-modes
> > + *		      |---- max-clock-frequency
> > + *		      |---- clock-frequencies
> > + *		      |---- default-frame-rows
> > + *		      |---- default-frame-cols
> > + *		      |---- dynamic-frame-shape
> > + *		      |---- command-error-threshold
> > + */
> 
> Why nest them so deep?  Anyway, that's not really an issue I guess, it's
> your ABI, not mine :)

well it gives us a hierarchical view. We have N links...

> 
> > +
> > +struct sdw_master_sysfs {
> > +	struct kobject kobj;
> > +	struct sdw_bus *bus;
> 
> Huh?  Why do you need to use kobjects?
> 
> When you switch from using a 'struct device' and hang a kobject off of
> it, that's a huge signal that something is wrong here.  That kobject
> will now no longer be part of the device "chain" in the system, uevents
> will get odd, and other strange things can happen.
> 
> Why can't you just use "normal" attributes attached to the device?  You
> shouldn't need a kobject here.  What am I missing?

Okay my understanding might be incorrect then. So we can have N links in
the system and each link would have a kobject for "link-N". Not sure how
device attributes would do link-N/clock-stop-modes and so on, if they can
let me know how and I will surely change that.

> 
> > +/*
> > + * Slave sysfs
> > + */
> > +
> > +/*
> > + * The sysfs for Slave reflects the MIPI description as given
> > + * in the MIPI DisCo spec
> > + *
> > + * Base file is device
> > + *	|---- mipi_revision
> > + *	|---- wake_capable
> > + *	|---- test_mode_capable
> > + *	|---- simple_clk_stop_capable
> > + *	|---- clk_stop_timeout
> > + *	|---- ch_prep_timeout
> > + *	|---- reset_behave
> > + *	|---- high_PHY_capable
> > + *	|---- paging_support
> > + *	|---- bank_delay_support
> > + *	|---- p15_behave
> > + *	|---- master_count
> > + *	|---- source_ports
> > + *	|---- sink_ports
> > + *	|---- dp0
> > + *		|---- max_word
> > + *		|---- min_word
> > + *		|---- words
> > + *		|---- flow_controlled
> > + *		|---- simple_ch_prep_sm
> > + *		|---- device_interrupts
> > + *	|---- dpN
> > + *		|---- max_word
> > + *		|---- min_word
> > + *		|---- words
> > + *		|---- type
> > + *		|---- max_grouping
> > + *		|---- simple_ch_prep_sm
> > + *		|---- ch_prep_timeout
> > + *		|---- device_interrupts
> > + *		|---- max_ch
> > + *		|---- min_ch
> > + *		|---- ch
> > + *		|---- ch_combinations
> > + *		|---- modes
> > + *		|---- max_async_buffer
> > + *		|---- block_pack_mode
> > + *		|---- port_encoding
> > + *		|---- bus_min_freq
> > + *		|---- bus_max_freq
> > + *		|---- bus_freq
> > + *		|---- max_freq
> > + *		|---- min_freq
> > + *		|---- freq
> > + *		|---- prep_ch_behave
> > + *		|---- glitchless
> > + *
> > + */
> > +struct sdw_slave_sysfs {
> > +	struct sdw_slave *slave;
> > +};
> 
> Same here, why are you using kobjects for this "device"?  Shouldn't you
> use a real struct device for dpX?
> 
> > +
> > +#define SLAVE_ATTR(type)					\
> > +static ssize_t type##_show(struct device *dev,			\
> > +		struct device_attribute *attr, char *buf)	\
> > +{								\
> > +	struct sdw_slave *slave = dev_to_sdw_dev(dev);		\
> > +	return sprintf(buf, "0x%x\n", slave->prop.type);	\
> > +}								\
> > +static DEVICE_ATTR_RO(type)
> 
> Oh wait, you are?  I'm confused, is this a real device or not?

Yes it  real device :) We have attributes and a device can have N data ports
which have their own attributes, so added kobject for each dpN and
attributes for those. So it would appear as: dpN/max_word and so in sysfs

If there a better way to do this without kobject, please do let me know and I
will change that

> 
> > +
> > +SLAVE_ATTR(mipi_revision);
> > +SLAVE_ATTR(wake_capable);
> > +SLAVE_ATTR(test_mode_capable);
> > +SLAVE_ATTR(clk_stop_mode1);
> > +SLAVE_ATTR(simple_clk_stop_capable);
> > +SLAVE_ATTR(clk_stop_timeout);
> > +SLAVE_ATTR(ch_prep_timeout);
> > +SLAVE_ATTR(reset_behave);
> > +SLAVE_ATTR(high_PHY_capable);
> > +SLAVE_ATTR(paging_support);
> > +SLAVE_ATTR(bank_delay_support);
> > +SLAVE_ATTR(p15_behave);
> > +SLAVE_ATTR(master_count);
> > +SLAVE_ATTR(source_ports);
> > +
> > +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> > +			     char *buf)
> > +{
> > +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> > +
> > +	return sdw_slave_modalias(slave, buf, 256);
> > +}
> > +static DEVICE_ATTR_RO(modalias);
> > +
> > +static struct attribute *slave_dev_attrs[] = {
> > +	&dev_attr_mipi_revision.attr,
> > +	&dev_attr_wake_capable.attr,
> > +	&dev_attr_test_mode_capable.attr,
> > +	&dev_attr_clk_stop_mode1.attr,
> > +	&dev_attr_simple_clk_stop_capable.attr,
> > +	&dev_attr_clk_stop_timeout.attr,
> > +	&dev_attr_ch_prep_timeout.attr,
> > +	&dev_attr_reset_behave.attr,
> > +	&dev_attr_high_PHY_capable.attr,
> > +	&dev_attr_paging_support.attr,
> > +	&dev_attr_bank_delay_support.attr,
> > +	&dev_attr_p15_behave.attr,
> > +	&dev_attr_master_count.attr,
> > +	&dev_attr_source_ports.attr,
> > +	&dev_attr_modalias.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group sdw_slave_dev_attr_group = {
> > +	.attrs	= slave_dev_attrs,
> > +};
> > +
> > +const struct attribute_group *sdw_slave_dev_attr_groups[] = {
> > +	&sdw_slave_dev_attr_group,
> > +	NULL
> > +};
> > diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> > index e752db72a045..fce502d08fef 100644
> > --- a/include/linux/soundwire/sdw.h
> > +++ b/include/linux/soundwire/sdw.h
> > @@ -308,6 +308,15 @@ int sdw_master_read_prop(struct sdw_bus *bus);
> >  int sdw_slave_read_prop(struct sdw_slave *slave);
> >  
> >  /*
> > + * SDW sysfs APIs
> > + */
> > +struct sdw_slave_sysfs;
> > +struct sdw_master_sysfs;
> > +
> > +int sdw_sysfs_bus_init(struct sdw_bus *bus);
> 
> How are you handling the sysfs files showing up "after" the device is
> registered and userspace not seeing them?  Have you tried using libudev
> to get the attributes?  Does this all work properly?  I think with the
> use of a kobject that breaks, and that's not good.

Ah i am missing an uevent here, will add. I will check the libudev too.

> > +void sdw_sysfs_bus_exit(struct sdw_bus *bus);
> > +
> > +/*
> >   * SDW Slave Structures and APIs
> >   */
> >  
> > @@ -363,6 +372,7 @@ struct sdw_slave_ops {
> >   * @bus: Bus handle
> >   * @ops: Slave callback ops
> >   * @prop: Slave properties
> > + * @sysfs: Sysfs interface
> >   * @node: node for bus list
> >   * @port_ready: Port ready completion flag for each Slave port
> >   * @dev_num: Device Number assigned by Bus
> > @@ -374,6 +384,7 @@ struct sdw_slave {
> >  	struct sdw_bus *bus;
> >  	const struct sdw_slave_ops *ops;
> >  	struct sdw_slave_prop prop;
> > +	struct sdw_slave_sysfs *sysfs;
> 
> So a differently reference counted device is hanging off of this?
> That's the big objection to using a kobject here and should have been a
> clue that this isn't ok.

sdw_slave embeds the struct device and sysfs is for this device, shouldn't
that be okay?

> 
> >  	struct list_head node;
> >  	struct completion *port_ready;
> >  	u16 dev_num;
> > @@ -453,6 +464,7 @@ struct sdw_master_ops {
> >   * @msg_lock: message lock
> >   * @ops: Master callback ops
> >   * @prop: Master properties
> > + * @sysfs: Bus sysfs
> >   * @defer_msg: Defer message
> >   * @clk_stop_timeout: Clock stop timeout computed
> >   */
> > @@ -465,6 +477,7 @@ struct sdw_bus {
> >  	struct mutex msg_lock;
> >  	const struct sdw_master_ops *ops;
> >  	struct sdw_master_prop prop;
> > +	struct sdw_master_sysfs *sysfs;
> 
> Same here.

sdw_bus represent master device and is registered by the driver. is there a
better way to handle this.

-- 
~Vinod
