From: ian esten <deviant@custard.org>
Subject: Re: emagic mt4
Date: 20 Feb 2004 16:19:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077311953.30599.10.camel@ian-lnx.ycrdi.com>
References: <Pine.HPX.4.33n.0402201214340.13625-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402201214340.13625-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

thanks clemens. the mt4 now shows up in /proc/asound/cards.
unfortunately though it doesnt seem to be working. i sent it some midi
from seq24, and got no blinking lights on the front of the unit. do you
think it will be possible to get the mt4 working with alsa?
thanks very much,
ian

On Fri, 2004-02-20 at 06:36, Clemens Ladisch wrote:
> ian esten wrote:
> > On Thu, 2004-02-19 at 03:28, Clemens Ladisch wrote:
> > > Please post the output of "lsusb -v".
> >
> > Bus 001 Device 040: ID 086a:0003 Emagic Soft-und Hardware GmbH
> > .
> > .
> > .
> 
> These descriptors look very much like those of earlier Edirol devices.
> It may be possible that the MT4 is similar enough to speak the same
> protocol.
> 
> Please apply the patch below and recompile ALSA.  The device and its
> ports will show up in ALSA, but I'm not sure if sending/receiving MIDI
> data will work.
> 
> 
> HTH
> Clemens



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
