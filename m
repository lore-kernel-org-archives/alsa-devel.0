From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Fwd: Audigy2 NX (USB 2.0) on ALSA 1.0.2]
Date: Thu, 12 Feb 2004 12:49:18 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402121235200.14784-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: "John W. Cocula" <john@cocula.com>
List-Id: alsa-devel@alsa-project.org

John W. Cocula wrote:
> I have an Audigy2 NX working under ALSA 1.0.2 (the latest 1.0.2 :)
> ...
> 2. I downloaded the latest firmware under Windows that supposedly
> permits USB 2.0 operation, but lsusb -v stills shows it as a 1.1
> device.
>
> Bus 002 Device 004: ID 041e:3020 Creative Technology, Ltd
> ...
>   bcdUSB               1.10

Yes, this is USB 1.1, the device says so itself.

> Am I right in assuming that this has absolutely nothing to do with
> ALSA?

Yes.

> Does anyone have any pointers on making this a true USB 2.0
> connection?

Probably the device is now compatible with USB 2.0, i.e., the firmware
update prevents the device from blowing up when connected to a
2.0-capable computer, or something like that.

Or the device is 1.1 by default and switches to 2.0 only when the
driver sends it some special command.  (The Extigy needs a similar
hack to enable some advanced features.)

Could you check if the Windows device manager shows it connected to
the 2.0 controller (EHCI) or a 1.x controller (UHCI or OHCI)?


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
