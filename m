From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: maximum voices/channels
Date: Mon, 25 Jul 2005 15:07:49 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507251454480.23061-100000@studcom.urz.uni-halle.de>
References: <1122043610.5724.6.camel@tordera.genos.intranet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ACDBD18D
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 15:07:50 +0200 (MEST)
In-Reply-To: <1122043610.5724.6.camel@tordera.genos.intranet>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Cesar Hernandez <chernandez@genos.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cesar Hernandez wrote:
> I want to know what is the maximum number of notes or sampled
> voices (mapped to a note) that I can play at the same time...

This depends on the synthesizer.  If you're using an external device,
there is almost no possibility to know how many voices it has.  Most
internal wavetable synthesizers share their voices with the PCM output
streams, and you cannot know how many voices a note uses without
looking into the soundfont.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
