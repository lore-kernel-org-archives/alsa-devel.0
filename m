From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Using hardware timers for the ALSA sequencer
Date: Wed, 16 Mar 2005 23:31:09 -0500
Message-ID: <1111033869.22344.2.camel@mindpipe>
References: <1110845236.15588.23.camel@mindpipe>
	 <1111018873.3239.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111018873.3239.1.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-03-16 at 20:21 -0400, Manuel Jander wrote:
> Hi,
> 
> At least the aureal vortex has a high resolution hardware timer too. So
> if this leads to some code to support hardware timers, i would suggest
> something useable for other hardware too.
> 

With Clemens' code for the ymfpci timer and the OSS emu10k1 driver I was
able to implement the ALSA timer support for emu10k1 in about 20
minutes.  If you know how to enable and disable timer interrupts and set
the timer rate (and have the hardware of course) you should try to
implement the support for the vortex.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
