From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 driver broken in CVS
Date: Wed, 16 Mar 2005 00:09:05 -0500
Message-ID: <1110949745.19984.2.camel@mindpipe>
References: <1110947679.19739.3.camel@mindpipe>
	 <4237BAA8.3020405@machinehasnoagenda.com>
	 <1110948410.19837.0.camel@mindpipe>  <1110949192.19837.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110949192.19837.3.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Shayne O'Connor <forums@machinehasnoagenda.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-15 at 23:59 -0500, Lee Revell wrote:
> It's not this one.  The problem must be the P16V patch.  But that should
> have no effect on emu10k1...

OK, found the bug.  The interrupt handler checks the IPR2 register even
on non-Audigy2 cards resulting in an infinite loop.

Patch forthcoming.  We really need an -rc2 ASAP, this is a nasty bug.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
