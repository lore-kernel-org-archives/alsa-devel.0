From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 21:16:49 +0530
Message-ID: <20171020154649.GP30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <s5hzi8nvb55.wl-tiwai@suse.de>
 <20171020051101.GG30097@localhost>
 <s5hpo9iuwwx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hpo9iuwwx.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 08:59:42AM +0200, Takashi Iwai wrote:
> On Fri, 20 Oct 2017 07:11:01 +0200,
> Vinod Koul wrote:
> > 
> > On Thu, Oct 19, 2017 at 09:40:06AM +0200, Takashi Iwai wrote:
> > > On Thu, 19 Oct 2017 05:03:18 +0200,
> > > Vinod Koul wrote:
> > > > +
> > > > +config SOUNDWIRE_BUS
> > > > +	tristate
> > > > +	default SOUNDWIRE
> > > > +
> > > 
> > > Does it make sense to be tristate?
> > > Since CONFIG_SOUNDWIRE is a bool, the above would be also only either
> > > Y or N.  If it's Y and others select M, it'll be still Y.
> > 
> > hmmm good point. I think would make sense to make SOUNDWIRE as tristate too,
> > just like SOUND :)
> 
> It's one option.  Another would be to simply drop the "default" line.

Okay good suggestion

> > > > + * The match is done by comparing the mfg_id and part_id from the
> > > > + * struct sdw_device_id. class_id is unused, as it is a placeholder
> > > > + * in MIPI Spec.
> > > > + */
> > > > +static const struct sdw_device_id *
> > > > +sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> > > > +{
> > > > +	const struct sdw_device_id *id = drv->id_table;
> > > > +
> > > > +	while (id && id->mfg_id) {
> > > > +		if (slave->id.mfg_id == id->mfg_id &&
> > > > +				slave->id.part_id == id->part_id) {
> > > 
> > > Please indentation properly.
> > 
> > what do you advise?
> > 
> > 		if (slave->id.mfg_id == id->mfg_id &&
> > 			slave->id.part_id == id->part_id) {
> > 
> > would mean below one is at same indent. Some people use:
> > 
> > 		if (slave->id.mfg_id == id->mfg_id &&
> > 		   slave->id.part_id == id->part_id) {
> > 
> > Is it Documented anywhere...
> 
> This is a matter of taste.  The latter is the way Emacs or indent does
> as default.

okay as vi user I will try to do above :)

> 
> > > > --- a/include/linux/mod_devicetable.h
> > > > +++ b/include/linux/mod_devicetable.h
> > > > @@ -228,6 +228,13 @@ struct hda_device_id {
> > > >  	unsigned long driver_data;
> > > >  };
> > > >  
> > > > +struct sdw_device_id {
> > > > +	__u16 mfg_id;
> > > > +	__u16 part_id;
> > > > +	__u8 class_id;
> > > > +	kernel_ulong_t driver_data;
> > > 
> > > Better to think of alignment.
> > 
> > sorry not quite clear, do you mind elaborating which ones to align?
> 
> kernel_ulong_t may be aligned to 4 or 8 bytes, depending on
> architecture, so there can be a hole between class_id and driver_data.
> It's not an ABI, so we don't have to care too much, but it's still
> something exposed, hence better to be conscious about alignment.

ah :) is that why hda is unsigned long :) Btw doesnt that cause compat
issues, should we not do something like u64 here?

-- 
~Vinod
