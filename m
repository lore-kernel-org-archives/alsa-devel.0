From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ad1888 as in ASUS P4R800-VM motherboards
Date: Mon, 16 Feb 2004 11:04:23 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402161100220.4733-100000@studcom.urz.uni-halle.de>
References: <002f01c3f317$58b65e90$6601a8c0@peterlaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <002f01c3f317$58b65e90$6601a8c0@peterlaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Antypas <peter@joyfaktory.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter Antypas wrote:
> I 've had no luck in using the cvs version with the ad1888 update.
> In fact, I can't even load snd-intel8x0. I thought the intel8x0
> module was supposed to work here?

An AC'97 system consists of two components: an AC'97 codec (in your
case, the AD1888), and an AC'97 controller (usually part of the
southbridge).  Your codec is supported, but your controller isn't.

> cat /proc/pci reveals a PCI id of 1002:4341 with I/O at 0xfbe00000
> to 0xfbe000ff. It reports the device is (ATI Technologies) (rev 0)
> grepping through the CVS source (checked out today) for "1002" or
> "4341" reveals nothing.
>
> I added the PCI ids to snd-intel8x0 and it fails to grab the
> specified I/O ports. What could be the problem here?

The problem is that ATI's AC'97 controller isn't compatible with
Intel's, so snd-intel8x0 doesn't work with it.  And it's completely
undocumented, so we cannot write a driver for it.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
