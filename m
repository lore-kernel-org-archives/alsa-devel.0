From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bt87x new card
Date: Tue, 8 Mar 2005 12:02:11 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503081158280.835-100000@studcom.urz.uni-halle.de>
References: <4229AD7E.1050704@ugr.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <4229AD7E.1050704@ugr.es>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ruben Garcia <ruben@ugr.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ruben Garcia wrote:
> I have a Leadtek Winfast 2000 / XP
> The bt87x driver does not detect it; when probing all cards, it told me
> to post this information:
>
> - -card id 0x107d:0x6606

Thanks.

> When recording, I get no sound from the TV and radio; I have yet to try
> the line in in the card; I'll post when I find the correct digital_rate

That is, so far you didn't get _any_ sound?

A wrong digital_rate would just result in a recording labeled with the
wrong frequency, it would not result in no sound (and it only affects
recording from the digital PCM device).  It's quite possible that the
digital input of your card isn't connected.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
