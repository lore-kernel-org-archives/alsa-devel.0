From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: various (mostly trivial) small
	cleanups
Date: Mon, 14 Mar 2005 11:25:14 -0500
Message-ID: <1110817514.14562.0.camel@mindpipe>
References: <Pine.HPX.4.33n.0503140920520.15356-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0503140920520.15356-100000@studcom.urz.uni-halle.de>
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

On Mon, 2005-03-14 at 09:23 +0100, Clemens Ladisch wrote:
> Lee Revell wrote:
> > timer.c ... I just copied and pasted from the ymfpci driver &
> > changed the registers.
> 
> BTW: Does the Emu10k1 have some sample/tick counter that runs even if
> no PCMs are running?  If so, it would be possible to detect lost timer
> interrupts.
> 

Sure does, it has a wall clock timer.  I used it a lot for debugging
while developing the multichannel support.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
