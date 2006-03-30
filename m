From: list@phasorlab.de (Matthias =?utf-8?Q?K=C3=B6nig?=)
Subject: Ego Sys, Miditerminal 4140 Driver
Date: Thu, 30 Mar 2006 18:48:47 +0200
Message-ID: <87psk3ubdc.fsf@zebra.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello alsa-devel,

I own a Miditerminal 4140 by ESI, which is a 4 In 4 Out Midi interface
with SMPTE timecode generation for the parallel port. Since I want
this device to work under Linux, I've been working on a driver for
ALSA.
It seems that I have some success now. At least I can receive and
transmit Midi bytes on all 4 In/Out ports. Maybe someone with more
experience in driver development could take a look at the driver?
A preliminary version is available from 
www.phasorlab.de/alsa/mts64.tar.bz2
Any comments and critics would be highly appreciated.

There is still some work to do, the SMPTE timecode generation will
need some kind of control for start/stop of timecode generation and
setting the time (timecode generation is done by hardware). I'm not
yet sure how to do this; can this be done by ALSA control elements
or do I have to create a hwdep device, which would use ioctl?
Again, suggestions would be welcome.

Regards,
Matthias


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
