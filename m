From: Mark Canter <marcus@vfxcomputing.com>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Thu, 3 Mar 2005 15:33:03 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>  <29495f1d05030309455a990c5b@mail.gmail.com>
  <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
 <1109875926.2908.26.camel@mindpipe>  <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
 <1109876978.2908.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <1109876978.2908.31.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


To close this issue out of the LKML and alsa-devel, a bug report has been 
written.

It appears to be an issue with the 'headphone jack sense' (as kde labels 
it).  The issue is in the way the 8x0 addresses the docking station/port 
replicator's audio output jack.  The mentioned quick fix does not work for 
using the ds/pr audio output, but does resolve it for a user that is only 
using headphones/internal speakers.

mark


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
