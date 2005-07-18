From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: GPL or LGPL
Date: Mon, 18 Jul 2005 18:05:53 -0500
Message-ID: <20050718230553.GD15158@dbz.icequake.net>
References: <42D8EADE.4080205@gmx.de> <20050718134254.12319.qmail@web30707.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050718134254.12319.qmail@web30707.mail.mud.yahoo.com>
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


On Mon, Jul 18, 2005 at 06:42:54AM -0700, SUJA JAMES wrote:
> Hi All,
> I have one questain on ALSA license.
> Whether it comes under GPL or LGPL. All the ALSA
> module has MODULE_LICENSE("GPL") property.
> 
> I plan to write an ALSA driver and I need to keep my
> hardware (DSP)communication/details as properitry.For
> that I am making the DSP part a libarary and publish
> that LIB in GPL.

This doesn't make any sense.  How would you both keep your DSP details
proprietary *and* put them in a GPL library?  The result would be
undistributable.  No code that does not satisfy the requirements of the
GPL can be included in the ALSA driver that runs on the host PC, and
that would include any code for which the source is not available.

The best thing to do, if for some reason you can't put the DSP code in a
ROM on the card, and you can't release the DSP source, is to publish a
binary image of the DSP program and use the kernel firmware loader
(request_firmware() and friends) to load it at runtime.  There are
several ALSA drivers which already do this (and their firmwares are
included in the alsa-firmware package).  Note that this is still useless
if you do not include a license with your binary firmware image granting
full redistribution rights, so please do that.

-- 
Ryan Underwood, <nemesis@icequake.net>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
