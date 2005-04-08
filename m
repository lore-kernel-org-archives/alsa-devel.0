From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Master Volume Level Bug for Sound Blaster Live
Date: Fri, 08 Apr 2005 19:25:33 -0400
Message-ID: <1113002734.5024.10.camel@mindpipe>
References: <1113002442.18923.9.camel@CPE0080c6f83cd7-CM012059935602>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1113002442.18923.9.camel@CPE0080c6f83cd7-CM012059935602>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jmsaunders@rogers.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-04-08 at 19:20 -0400, Jordan Saunders wrote:
> There's a bug in the master volume control in alsamixer or possibly with
> ALSA itself. When you change the master volume level through alsamixer,
> only the front channels are affected. I'm not exactly sure of the inner-
> workings of ALSA, but would be willing to learn a bit about it to fix
> this bug. Would it be possible to write a patch for this problem, or
> allow me to write one and have it accepted into the CVS?

This issue is very well known.  See the list archives.

Summary: There's a patch available that fixes it, but the patch was
considered overly complex (it added too many mixer controls) so it
wasn't accepted into CVS.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
