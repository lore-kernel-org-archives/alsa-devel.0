From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Date: Wed, 15 Apr 2009 15:06:32 +0200
Message-ID: <20090415150632.0b2fe6bb@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
	<1239746399.4205.21.camel@johannes.local>
	<20090415141530.0d5e47fc@hyperion.delvare>
	<1239799934.9071.4.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <1239799934.9071.4.camel@johannes.local>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin@ozlabs.org, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Apr 2009 14:52:14 +0200, Johannes Berg wrote:
> > OK, I understand better what is going on now. I do not understand the
> > crash at the end though, but I suspect it isn't a bug in my code but
> > simply a faulty error path which had never been taken before.
> 
> That would be weird -- the error path _has_ to be taken always in onyx.
> Unless you're talking about something in the i2c core or whatever?

Yes, i2c core or even driver core. I'll see if I can reproduce it.

> > (...)
> > Well, there is a dirty workaround, which I will apply for now, but...
> > ideally the layout factory should be revisited so that the codec check
> > happens earlier. Is this something you could help with?
> 
> That's not really possible unless the factory post-processes the entire
> device-tree -- very ugly.

What I had in mind was not so complex. Simply, we could move the
i2c_new_device() calls into layout_found_codec(). That way we can
decide to instantiate the I2C device if and only if check_codec() is
successful. This is more efficient that creating the device, letting
the driver attach to it, with probing eventually failing, and then
removing the device if it wasn't the right one.

That is, the i2c client would be a mere helper on top of struct
aoa_codec, rather than the other way around.

There may be preliminary work needed, for example switching powermac to
numbered I2C buses.

> > That's something which isn't too clear to me: is there a physical
> > device at 2-0046 and 3-0046? The onyx codec is accepted for the latter,
> > however it seems that the test of a device presence at 2-0046 succeeds
> > as well...
> 
> It's the _same_ physical device.

Wow. One I2C device which can be reached through 2 different I2C buses?
First time I hear about something like this. Very odd. I can't see the
point of doing this.

-- 
Jean Delvare
