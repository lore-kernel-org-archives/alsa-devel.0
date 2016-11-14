From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC 05/14] SoundWire: Add SoundWire bus driver
 interfaces
Date: Mon, 14 Nov 2016 11:28:05 -0600
Message-ID: <f4df1745-3036-cea9-6579-0b74b200b384@linux.intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-6-git-send-email-hardik.t.shah@intel.com>
 <20161114131726.qo5gqfqoey5usxiy@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114131726.qo5gqfqoey5usxiy@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the reviews Mark, comment below:

On 11/14/16 7:17 AM, Mark Brown wrote:
> On Fri, Oct 21, 2016 at 06:11:03PM +0530, Hardik Shah wrote:
>> This patch adds the SoundWire bus driver interfaces for following.
>>
>> 1. APIs to register/unregister SoundWire Master device and driver.
>> 2. APIs to register/unregister SoundWire Slave driver.
>> 3. API to Read/Write Slave registers.
>> 4. API for Master driver to update Slave status to bus driver.
>> 5. APIs for Master driver to prepare and initiate clock stop.
>> 6. APIs for SoundWire stream configuration.
>> 7. APIs to prepare, enable, deprepare and disable SoundWire stream.
>
> This is a very large patch (85K, 2000 lines) and the changelog is just a
> long list of different things being added.  This suggests that you could
> easily split the patch up along the lines you've given above which would
> make it a lot more digestable, as it is it's really hard to review.  It
> is also very hard to review because it's pure header, there's none of
> the implementation in here, which makes it hard to see how things are
> going to be used.

I am probably to blame for this since I wanted to a have all prototypes 
in a single file to make my review easier and check that the exposed 
functionality matches the spec requirements. If the spec is implemented 
in various increments it makes it more difficult to check for 
consistency, but you are correct that for someone looking at code for 
the first time without prior experience with SoundWire it may be too 
complicated.

>
> At a very high level this doesn't look or feel like normal Linux code,
> there's some obvious coding style stuff, a bunch of things that look
> like this was copied from legacy code and perhaps most worryingly all
> the stuff about a "bus driver" which doesn't seem to fit with the normal
> Linux models at all.

Yes agree. The patches were released ahead of the Audio Miniconference 
and there are known issues with the coding style that will be fixed. And 
the 'bus driver' part will be fixed as well, i don't view it as a 
fundamental design issue but more awkward wording.

>
>> +/**
>> + * sdw_slave_addr: Structure representing the read-only unique device ID
>> + *	and the SoundWire logical device number (assigned by bus driver).
>
> With the name of this structure I was expecting it to represent an
> address in the same way that an in_addr is an IP address but really it's
> a bundle of several different addresses and runtime state associated
> with them.  This is going to cause confusion I imagine, it seems better
> to rename it or bundle it into the slave struct.

It really is the mapping between the read-only information exposed by 
the Slave and the logical address configured by the bus. Maybe we can 
rename it but that mapping is required.

>
>> +/**
>> + * sdw_dpn_caps: Capabilities of the Data Port, other than Data Port 0 for
>> + *	SoundWire Master and Slave. This follows the definitions in the
>
> Why not just _dp_caps?

SoundWire makes a distinction between Port0 and PortN (1..15). the 
former is to reclaim parts of the audio transport bandwidth for fast 
control/configurations, the latter are for true audio transports. there 
are different configurations/capabilities for DP0 and DPN.

>
>> + * @max_bps: Maximum bits per sample supported by Port. This is same as word
>> + *	length in SoundWire Spec.
>
> Might be better to rename all these _bps variables to _wl or something -
> bps looks like bits per second which is going to confuse people.

That's what we used in the SoundWire DisCo document (in press). Word 
Length is equally confusing for folks who believe a word is 16 bits.

>
>> +/**
>> + * sdw_prepare_ch: Prepare/De-prepare the Data Port channel. This is similar
>> + *	to the prepare API of Alsa, where most of the hardware interfaces
>> + *	are prepared for the playback/capture to start. All the parameters
>> + *	are known to the hardware at this point for starting
>> + *	playback/capture next.
>
> This is information used for preparing or depreparing, the description
> reads like this is a function.

Yes, will be fixed.

>
>> + * @num: Port number.
>> + * @ch_mask: Channels to be prepared/deprepared specified by ch_mask.
>> + * @prepare: Prepare/de-prepare channel, true (prepare) or false
>> + *	(de-prepare).
>
> Do actual implementations look like something other than an if
> statement with two unrelated halves?

There is a prepare register field which is either set or cleared. there 
aren't two parts in the function. We should clarify this.

>
>> + * @bank: Register bank, which bank Slave/Master driver should program for
>> + *	implementation defined registers. This is the inverted value of the
>> + *	current bank.
>
> If this is the inverted value of the current bank should we not just
> look at the current bank?

We should update the wording, the intent is that you program the new 
setup in the alternate bank then switch banks.

>
>> + * @r_w_flag: Read/Write operation. Read(0) or Write(1) based on above #def
>
> Which above #define?  (please write out #define fully too).  I'm also
> noticing lots of random capitalisation in the comments in this patch.

Most of the capitalisation isn't random but follows the SoundWire spec 
definitions. I think this was mentioned upfront in the header, if this 
was missed then we need to clarify.

>
>> +/**
>> + * sdw_msg: Message to be sent on bus. This is similar to i2c_msg on I2C
>> + *	bus. Message is sent from the bus driver to the Slave device. Slave
>> + *	driver can also initiate transfer of the message to program
>> + *	implementation defined registers. Message is formatted and
>> + *	transmitted on to the bus by Master interface in hardware-specific
>> + *	way. Bus driver initiates the Master interface callback to transmit
>> + *	the message on bus.
>> + *
>> + * @addr: Address of the register to be read.
>
> Only reads?

no, this should be accessed for read or write.

>
>> + * @frame_rate: Audio frame rate of the stream (not the bus frame rate
>> + *	defining command bandwidth).
>
> In units of...?

Hz. will be corrected.

>
>> +/**
>> + * snd_sdw_alloc_stream_tag: Allocates unique stream_tag. Stream tag is
>> + *	a unique identifier for each SoundWire stream across all SoundWire
>> + *	bus instances. Stream tag is a software concept defined by bus
>> + *	driver for stream management and not by MIPI SoundWire Spec. Each
>> + *	SoundWire Stream is individually configured and controlled using the
>> + *	stream tag. Multiple Master(s) and Slave(s) associated with the
>> + *	stream, uses stream tag as an identifier. All the operations on the
>> + *	stream e.g. stream configuration, port configuration, prepare and
>> + *	enable of the ports are done based on stream tag. This API shall be
>> + *	called once per SoundWire stream either by the Master or Slave
>> + *	associated with the stream.
>> + *
>> + * @stream_tag: Stream tag returned by bus driver.
>> + */
>> +int snd_sdw_alloc_stream_tag(unsigned int *stream_tag);
>
> In Linux we put documentation for functions next to their
> implementation not their prototype.  This also doesn't look like good
> kerneldoc - normally we'd have a separate paragraph for the summary.
>
> This sort of stylistic stuff is important not just for itself but also
> because it's a warning sign that the code hasn't been written by someone
> who's really familiar with how things are expected to look and work in
> terms of the kernel internal abstractions.

yes Vinod made that comment as well but I asked that the patches be 
shared without additional delays. This will be fixed.

>
>> + * @slv_list: List of SoundWire Slaves registered to the bus.
>
> The driver model already maintains a list of devices on a bus, why are
> we maintaining a separate one?
>
>> + * @sdw_addr: Array containing Slave SoundWire bus Slave address
>> + *	information. Its a part of Slave list as well, but for easier access
>> + *	its part of array to find the Slave reference by directly indexing
>> + *	the Slave number into the array.
>
> This seems like a worrying idea...  I'd be entirely unsurprised if this
> cache went wrong, are we sure we need the optimisation?

There will be additional changes to simplify the master/slave 
definitions. It's not clear to me if all these optimizations are needed 
either, if they create confusion or concern then we should really fix this.

>
>> + * @num_slv: Number of SoundWire Slaves assigned DeviceNumber after
>> + *	enumeration. The SoundWire specification does not place a
>> + *	restriction on how many Slaves are physically connected, as long as
>> + *	only 11 are active concurrently. This bus driver adds a pragmatic
>> + *	restriction to 11 Slaves, the current implementation assigns a
>> + *	DeviceNumber once and will never use the same DeviceNumber for
>> + *	different devices.
>
> This is not a driver, it is a bus.  Please do not refer to it as a
> driver, that's at best confusing and at worst worrying.  It's also
> unclear why we're maintaining this count separately to the driver model.

Point taken.

>
>> +	char name[SOUNDWIRE_NAME_SIZE];
>> +	struct sdw_slave_addr sdw_addr[SDW_MAX_DEVICES];
>
> Best to use SDW_ consistently.

Yes.

>
>> +/**
>> + * sdw_master_driver: Manage SoundWire Master device driver.
>> + *
>> + * @driver_type: To distinguish between Master and Slave driver. This should
>> + *	be set by driver based on its handling Slave or Master SoundWire
>> + *	interface.
>> + *
>> + * @probe: Binds this driver to a SoundWire Master.
>> + * @remove: Unbinds this driver from the SoundWire Master.
>> + * @shutdown: Standard shutdown callback used during power down/halt.
>> + * @suspend: Standard suspend callback used during system suspend
>> + * @resume: Standard resume callback used during system resume
>
> Modern buses have moved to using dev_pm_ops which enables them to use a
> lot of generic code for power management implementation.

Point taken.

>
>> + * @driver: SoundWire device drivers should initialize name and owner field
>> + *	of this structure.
>
> Initializing .owner shouldn't be required with kernels from the past few
> years.

yes the comment is bad and 0-day flags this.

>
>> +/**
>> + * snd_sdw_master_get: Return the Master handle from Master number.
>> + *	Increments the reference count of the module. Similar to
>> + *	i2c_get_adapter.
>> + *
>> + * @nr: Master number.
>> + *
>> + * Returns Master handle on success, else NULL
>> + */
>> +struct sdw_master *snd_sdw_master_get(int nr);
>
> This is a legacy interface for I2C, why are we adding it for a new bus?

Good point, this was missed.

>
>> + * @portn_mask: Implementation defined mask for Slave Ports other than port0.
>> + *	Mask bits are exactly same as defined in MIPI Spec 1.1. Array size
>> + *	shall be same as number of Ports in Slave. For bidirectional ports,
>> + *	masks can be different for Source and Sink ports.
>
> Is this implementation defined or spec defined?  It's really non-obvious
> what these implementation defined things actually mean or do.

Yes the wording was bad, it's not implementation defined. It's a 
standard feature but implementations can select a single-direction port 
or dual-direction port (one direction at a time). In the latter case the 
direction is set prior to enabling transport. This functionality was 
added to help designers save gates.

>
>> +struct sdw_slave {
>> +	struct device dev;
>> +	struct sdw_master *mstr;
>
> Why do we have a direct reference to the master here?  Shouldn't this
> just be the parent of the device?

yes this will be simplified/corrected.
