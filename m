From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Using hardware timers for the ALSA sequencer
Date: Tue, 15 Mar 2005 14:12:23 -0500
Message-ID: <1110913944.17931.8.camel@mindpipe>
References: <Pine.HPX.4.33n.0503150932200.186-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0503150932200.186-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-15 at 09:55 +0100, Clemens Ladisch wrote:
> Probably not very hard -- registering a hardware timer would change
> the default timer, or something like that.

I was thinking even simpler.  If a hardware timer is present when the
sequencer is initialized, use it.  Handling the registration of a
hardware timer once the sequencer is up seems harder.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
