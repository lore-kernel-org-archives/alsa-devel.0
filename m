From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SB Live 24 Ext (was: [ALSA - driver 0000955]: CN-126
 - USB 5.1 Audio adapter)
Date: Fri, 4 Mar 2005 09:31:30 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503040923110.8579-100000@studcom.urz.uni-halle.de>
References: <1109863466.13335.6.camel@ghanima>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1109863466.13335.6.camel@ghanima>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fruhwirth Clemens wrote:
> On Thu, 2005-03-03 at 12:35 +0100, Clemens Ladisch wrote:
> > Your device probably doesn't have such controls.  What is the output
> > of "lsusb -v" for it?
>
> lsusb fails :/
>
> Bus 003 Device 002: ID 041e:3040 Creative Technology, Ltd
> Device Descriptor:
> ...
>   bNumConfigurations      1
> cannot get config descriptor 0, Connection timed out (110)

The kernel managed to read the descriptors, otherwise snd-usb-audio
wouldn't have loaded.  You might try to install a newer version of
usbutils.

Well.  What is the output of "xxd -g1 /proc/bus/usb/003/002" (where
003 and 002 are the bus and device numbers)?


Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
