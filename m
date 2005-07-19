From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: need help getting echo indigo io to work
Date: Tue, 19 Jul 2005 12:41:24 -0400
Message-ID: <1121791284.5235.31.camel@mindpipe>
References: <20050719145849.GA29758@unununium.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050719145849.GA29758@unununium.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Phil Frost <indigo@bitglue.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-07-19 at 10:58 -0400, Phil Frost wrote:
> It looks like no one can help on the user list, so I'm reposting this
> here. In addition to the information I have below, I've traced the
> problem a bit more.

Sounds like a driver bug to me.  A bunch of driver model stuff changed
recently in the kernel, I suspect the echo driver was developed against
a newer version.

I suspect it would work with 2.6.12.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
