From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: ALC658 rev 0 - a problem with Rear Right
Date: Mon, 7 Mar 2005 14:10:14 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503071406300.27740-100000@studcom.urz.uni-halle.de>
References: <20050307122800.GA27123@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050307122800.GA27123@localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dan Aloni <da-x@colinux.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dan Aloni wrote:
> The problem was introduced in the following changeset, which
> was supposed to cleanup things but accidently broke something.
>
> "[ALSA] Clean up and fix stereo mutes" :

Most AC'97 codecs have one mute bit for both channels, but some can
have one for each channel (that's called "stereo mute").

It seems the new driver enables the stereo mute bits, but then forgets
to unmute the second channel.

Does anything happen if you toggle both mute bits in alsamixer?


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
