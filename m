From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Tue, 06 Apr 2004 10:51:04 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404061037500.17488-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0404052356490.20587@pub2.ifh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0404052356490.20587@pub2.ifh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Boettcher wrote:
> On Mon, 5 Apr 2004, Clemens Ladisch wrote:
> > What sample rate/format uses 304000 bytes per second?
>
> I don't understand the question completely, what do you mean?

The descriptors say that the device can transfer up to 304000 bytes
per second in each direction.  What sample rate and formats does it
support?  (stereo 24 bits at 48 kHz would be 288000 bytes/s)

> > > 2. Can I use somehow the i2c/cs8427.c?
> > Probably not.  The CS8427 will be connected (via I2C) to some USB
> > interface/controller chip.  Can you determine which one?
>
> TAS1020A, Texas Instrument USB Streaming Controller. I thought I have to
> talk to the sound chip directly and that the the usb chip is only
> for bus control?!

The USB chip manages communication on the bus, and contains an
embedded 8051(?)-compatible CPU which must be programmed to implement
the actual behaviour of the device (in this case, writing/reading
samples over the I2C bus).

> Beside of the a/d and d/a converter, there is only one bigger chip on the
> device board. It is an EEPROM, I suppose to take the firmware, the owner
> of the device told me, that sometimes he has to make a firmware update.
>
> What exactly does the firmware?

It's the code running on the TAS1020A's CPU.

> > Sending/receiving sample data should work, but I guess this device
> > needs vendor-specific commands to configure it.  These are control
> > transfers, not isochronous; please look in the log file for them.
>
> There are only isochronous transfers (of course, there are only
> isoc-endpoints?) visible.

Each interface has an implicit control endpoint.

There are some control transfers in the UsbSnoop log, but those look
very much like standard USB Audio request.  It seems the device only
pretends to be vendor-specific.

I think I'll write a quirk for this ...


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
