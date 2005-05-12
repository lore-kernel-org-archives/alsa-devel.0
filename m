From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: High Speed USB Support?
Date: Thu, 12 May 2005 15:39:18 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505121513330.16290-100000@studcom.urz.uni-halle.de>
References: <33383.192.168.0.245.1115899224.squirrel@teg-electronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <33383.192.168.0.245.1115899224.squirrel@teg-electronics.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mailinglist@teg-electronics.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

mailinglist@teg-electronics.com wrote:
> Is the High Speed USB support in the alsa USB audio driver tested?

Yes, with two devices.

The Edirol UA-1000 doesn't really work.  I don't know why because I
don't have access to one anymore.

With the Audigy 2 NX, I get popping noises.

> My main problem at the moment is popping noises, it seems as some data
> is getting lost but I can't see that my buffers get either full or
> empty, so i wonder if this could be caused by the driver.

The driver uses mostly the same code, as the USB core is supposed to
provide the same interface for full speed and high speed devices.

At the moment I'm assuming that there is either a bug in the EHCI
driver, or that the EHCI driver has some requirement that the other
host controller drivers have not.

I'm still debugging, but I'd guess the problem is not with your
device.

BTW: what synchronization type does your device use?


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
