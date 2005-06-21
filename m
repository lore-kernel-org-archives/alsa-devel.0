From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA: Is CONFIG_SND_DEBUG_MEMORY really required?
Date: Tue, 21 Jun 2005 16:49:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0506211643080.18102__12915.1200446815$1119373738$gmane$org@pnote.perex-int.cz>
References: <20050621144041.GP3666@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B358A1B8
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 16:49:44 +0200 (MEST)
In-Reply-To: <20050621144041.GP3666@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Jun 2005, Adrian Bunk wrote:

> Hi,
> 
> I was a bit surprised to discover that ALSA has it's own memory 
> debugging infrastructure.
> 
> Is there a reason why CONFIG_DEBUG_SLAB isn't good enough for ALSA?

We're ready to move to something other, but standard allocation 
routines should be extended to handle "allocation pools".

We're able to detect quickly memory leaks in our code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
