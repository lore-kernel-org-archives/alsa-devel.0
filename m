From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creative Audigy 2 NX Notebook PCMCIA
Date: Mon, 4 Jul 2005 09:34:41 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507040931450.6723-100000@studcom.urz.uni-halle.de>
References: <42C5AB17.8000003@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C5AB17.8000003@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Is there any /usr/share/alsa/cards/....   file for this USB device?

The card-specfifc files are selected using the driver name which is
"USB-Audio" for all USB devices.

> It seems that even "speaker-test -c2 -Dfront"  does not work with it.

USB devices usually don't need any special configuration for
front/surround output, so I guess we could add a generic USB conf file
that just redirect those virtual devices to the default one.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
