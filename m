From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.6: sound/isa/gus/gus_lfo.c is unused (fwd)
Date: Mon, 7 Mar 2005 13:15:59 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503071310140.1751__2886.37413546002$1110198383$gmane$org@pnote.perex-int.cz>
References: <20050306224159.GQ5070@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8E7391CD
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2005 13:27:07 +0100 (MET)
In-Reply-To: <20050306224159.GQ5070@stusta.de>
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

On Sun, 6 Mar 2005, Adrian Bunk wrote:

> Hi Jaroslav,
> 
> I didn't receive any answer regarding this question.
> 
> Any comments or shall I send a patch to remove this file?

Yes, the file is unused, but it's a library for wavetable stuff which has 
not been ported from my linux ultra sound project yet.

I removed this file in our CVS tree, so it will be removed also in ALSA BK 
tree in next merge.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
