From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: emagic mt4
Date: Mon, 23 Feb 2004 18:47:01 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231842580.18260-100000@studcom.urz.uni-halle.de>
References: <1077311953.30599.10.camel@ian-lnx.ycrdi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077311953.30599.10.camel@ian-lnx.ycrdi.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ian esten <deviant@custard.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ian esten wrote:
> thanks clemens. the mt4 now shows up in /proc/asound/cards.
> unfortunately though it doesnt seem to be working. i sent it some midi
> from seq24, and got no blinking lights on the front of the unit. do you
> think it will be possible to get the mt4 working with alsa?

It's possible, but not easy.  We have to find out what protocol the
device uses.  You could install something like usbsnoop on a Windows
computer and send/receive a few MIDI bytes, then send me the log file,
then I could try to find out what the stuff means.  If you do this,
please send no more than a few MIDI commands, and don't connect any
other USB devices, because the log file can become very big.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
