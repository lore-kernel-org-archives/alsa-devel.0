From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Volume per voices
Date: Mon, 25 Jul 2005 16:22:31 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507251620540.23061-100000@studcom.urz.uni-halle.de>
References: <1122296568.42e4e2f8904f8@mail.e4a.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9AC6413A
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 16:22:32 +0200 (MEST)
In-Reply-To: <1122296568.42e4e2f8904f8@mail.e4a.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dino <dino@e4a.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dino wrote:
>    i'm looking for setting a volume per voice(pcm stream) but it seems to be
> impossible. I've found only a plugin to do it in software but i'd like to do it
> in Hardware. Is it a feature not supported by alsa?

The Emu10k1 and VIA82xxx drivers have volume controls for each
hardware PCM stream.  Most other hardware cannot do this.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
