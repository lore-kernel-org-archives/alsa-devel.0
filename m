From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Creative Audigy 4
Date: Sat, 04 Dec 2004 16:43:51 -0500
Message-ID: <1102196632.28776.43.camel@krustophenia.net>
References: <41B228F0.4080804@superbug.co.uk>
	 <1102195213.28776.34.camel@krustophenia.net>
	 <41B22DC8.2080704@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41B22DC8.2080704@superbug.co.uk>
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

On Sat, 2004-12-04 at 21:36 +0000, James Courtier-Dutton wrote:
> I found it.
> I quote:

Heh, I just posted the exact same info.

What do you think is the best long term solution?  We can't expect every
user to add that sequence to modules.conf.

This seems like something the driver should do.  After all, just because
you can set a register via /proc does not mean you should have to, if
it's something the driver should obviously do.  I think this qualifies,
since this is necessary to get the port to work at all.  Basic hardware
initialization should not be left to userspace.

Besides, the driver _knows_ whether the device is an Audigy 2 ZS,
whereas userspace would have to extract this from lspci or something.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
