From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 05/14] SoundWire: Add SoundWire bus driver interfaces
Date: Mon, 14 Nov 2016 13:17:26 +0000
Message-ID: <20161114131726.qo5gqfqoey5usxiy@sirena.org.uk>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-6-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3withbypivnzpel3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-6-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--3withbypivnzpel3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2016 at 06:11:03PM +0530, Hardik Shah wrote:
> This patch adds the SoundWire bus driver interfaces for following.
>=20
> 1. APIs to register/unregister SoundWire Master device and driver.
> 2. APIs to register/unregister SoundWire Slave driver.
> 3. API to Read/Write Slave registers.
> 4. API for Master driver to update Slave status to bus driver.
> 5. APIs for Master driver to prepare and initiate clock stop.
> 6. APIs for SoundWire stream configuration.
> 7. APIs to prepare, enable, deprepare and disable SoundWire stream.

This is a very large patch (85K, 2000 lines) and the changelog is just a
long list of different things being added.  This suggests that you could
easily split the patch up along the lines you've given above which would
make it a lot more digestable, as it is it's really hard to review.  It
is also very hard to review because it's pure header, there's none of
the implementation in here, which makes it hard to see how things are
going to be used.

At a very high level this doesn't look or feel like normal Linux code,
there's some obvious coding style stuff, a bunch of things that look
like this was copied from legacy code and perhaps most worryingly all
the stuff about a "bus driver" which doesn't seem to fit with the normal
Linux models at all.

> +/**
> + * sdw_slave_addr: Structure representing the read-only unique device ID
> + *	and the SoundWire logical device number (assigned by bus driver).

With the name of this structure I was expecting it to represent an
address in the same way that an in_addr is an IP address but really it's
a bundle of several different addresses and runtime state associated
with them.  This is going to cause confusion I imagine, it seems better
to rename it or bundle it into the slave struct.

> +/**
> + * sdw_dpn_caps: Capabilities of the Data Port, other than Data Port 0 f=
or
> + *	SoundWire Master and Slave. This follows the definitions in the

Why not just _dp_caps?

> + * @max_bps: Maximum bits per sample supported by Port. This is same as =
word
> + *	length in SoundWire Spec.

Might be better to rename all these _bps variables to _wl or something -
bps looks like bits per second which is going to confuse people.

> +/**
> + * sdw_prepare_ch: Prepare/De-prepare the Data Port channel. This is sim=
ilar
> + *	to the prepare API of Alsa, where most of the hardware interfaces
> + *	are prepared for the playback/capture to start. All the parameters
> + *	are known to the hardware at this point for starting
> + *	playback/capture next.

This is information used for preparing or depreparing, the description
reads like this is a function.

> + * @num: Port number.
> + * @ch_mask: Channels to be prepared/deprepared specified by ch_mask.
> + * @prepare: Prepare/de-prepare channel, true (prepare) or false
> + *	(de-prepare).

Do actual implementations look like something other than an if
statement with two unrelated halves?

> + * @bank: Register bank, which bank Slave/Master driver should program f=
or
> + *	implementation defined registers. This is the inverted value of the
> + *	current bank.

If this is the inverted value of the current bank should we not just
look at the current bank?

> + * @r_w_flag: Read/Write operation. Read(0) or Write(1) based on above #=
def

Which above #define?  (please write out #define fully too).  I'm also
noticing lots of random capitalisation in the comments in this patch.

> +/**
> + * sdw_msg: Message to be sent on bus. This is similar to i2c_msg on I2C
> + *	bus. Message is sent from the bus driver to the Slave device. Slave
> + *	driver can also initiate transfer of the message to program
> + *	implementation defined registers. Message is formatted and
> + *	transmitted on to the bus by Master interface in hardware-specific
> + *	way. Bus driver initiates the Master interface callback to transmit
> + *	the message on bus.
> + *
> + * @addr: Address of the register to be read.

Only reads?

> + * @frame_rate: Audio frame rate of the stream (not the bus frame rate
> + *	defining command bandwidth).

In units of...?

> +/**
> + * snd_sdw_alloc_stream_tag: Allocates unique stream_tag. Stream tag is
> + *	a unique identifier for each SoundWire stream across all SoundWire
> + *	bus instances. Stream tag is a software concept defined by bus
> + *	driver for stream management and not by MIPI SoundWire Spec. Each
> + *	SoundWire Stream is individually configured and controlled using the
> + *	stream tag. Multiple Master(s) and Slave(s) associated with the
> + *	stream, uses stream tag as an identifier. All the operations on the
> + *	stream e.g. stream configuration, port configuration, prepare and
> + *	enable of the ports are done based on stream tag. This API shall be
> + *	called once per SoundWire stream either by the Master or Slave
> + *	associated with the stream.
> + *
> + * @stream_tag: Stream tag returned by bus driver.
> + */
> +int snd_sdw_alloc_stream_tag(unsigned int *stream_tag);

In Linux we put documentation for functions next to their
implementation not their prototype.  This also doesn't look like good
kerneldoc - normally we'd have a separate paragraph for the summary.

This sort of stylistic stuff is important not just for itself but also
because it's a warning sign that the code hasn't been written by someone
who's really familiar with how things are expected to look and work in
terms of the kernel internal abstractions.

> + * @slv_list: List of SoundWire Slaves registered to the bus.

The driver model already maintains a list of devices on a bus, why are
we maintaining a separate one?

> + * @sdw_addr: Array containing Slave SoundWire bus Slave address
> + *	information. Its a part of Slave list as well, but for easier access
> + *	its part of array to find the Slave reference by directly indexing
> + *	the Slave number into the array.

This seems like a worrying idea...  I'd be entirely unsurprised if this
cache went wrong, are we sure we need the optimisation?

> + * @num_slv: Number of SoundWire Slaves assigned DeviceNumber after
> + *	enumeration. The SoundWire specification does not place a
> + *	restriction on how many Slaves are physically connected, as long as
> + *	only 11 are active concurrently. This bus driver adds a pragmatic
> + *	restriction to 11 Slaves, the current implementation assigns a
> + *	DeviceNumber once and will never use the same DeviceNumber for
> + *	different devices.

This is not a driver, it is a bus.  Please do not refer to it as a
driver, that's at best confusing and at worst worrying.  It's also
unclear why we're maintaining this count separately to the driver model.

> +	char name[SOUNDWIRE_NAME_SIZE];
> +	struct sdw_slave_addr sdw_addr[SDW_MAX_DEVICES];

Best to use SDW_ consistently.

> +/**
> + * sdw_master_driver: Manage SoundWire Master device driver.
> + *
> + * @driver_type: To distinguish between Master and Slave driver. This sh=
ould
> + *	be set by driver based on its handling Slave or Master SoundWire
> + *	interface.
> + *
> + * @probe: Binds this driver to a SoundWire Master.
> + * @remove: Unbinds this driver from the SoundWire Master.
> + * @shutdown: Standard shutdown callback used during power down/halt.
> + * @suspend: Standard suspend callback used during system suspend
> + * @resume: Standard resume callback used during system resume

Modern buses have moved to using dev_pm_ops which enables them to use a
lot of generic code for power management implementation.

> + * @driver: SoundWire device drivers should initialize name and owner fi=
eld
> + *	of this structure.

Initializing .owner shouldn't be required with kernels from the past few
years.

> +/**
> + * snd_sdw_master_get: Return the Master handle from Master number.
> + *	Increments the reference count of the module. Similar to
> + *	i2c_get_adapter.
> + *
> + * @nr: Master number.
> + *
> + * Returns Master handle on success, else NULL
> + */
> +struct sdw_master *snd_sdw_master_get(int nr);

This is a legacy interface for I2C, why are we adding it for a new bus?

> + * @portn_mask: Implementation defined mask for Slave Ports other than p=
ort0.
> + *	Mask bits are exactly same as defined in MIPI Spec 1.1. Array size
> + *	shall be same as number of Ports in Slave. For bidirectional ports,
> + *	masks can be different for Source and Sink ports.

Is this implementation defined or spec defined?  It's really non-obvious
what these implementation defined things actually mean or do.

> +struct sdw_slave {
> +	struct device dev;
> +	struct sdw_master *mstr;

Why do we have a direct reference to the master here?  Shouldn't this
just be the parent of the device?

--3withbypivnzpel3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYKblmAAoJECTWi3JdVIfQEBQH+wddusN8xkVSH19rNe08hf2J
zJXouCkTyTWr3swIcBHBcXzPqKHLACIY7meYWCdz7jiZFImxlXbMxQDd40WY2hYU
Xy7Vz9Y6V9T8kDBnZfIugyLemuLFZe9F2l1FuiWm/JbOJZaGmv06GcJn/c/iJXSH
pPmwY3zznZmIT8YX4RSXgy9QUc/hvHO3Ft2TQCUo8rYTeezv9Qmb0W+eT18uRP4T
h0ISreglClTm7Sb0/G4mmg7ZnVLHIANG93XwT+HNZlvnWsM+Iq7xKg4tng54bjHi
YwnFe0z/vq2V2cSw0Zcuxwn0a4rFjAoedFXi2mUpr48BwW7ByO6WuvxJe3Izyl4=
=/UW2
-----END PGP SIGNATURE-----

--3withbypivnzpel3--
