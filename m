From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: The different STATES of ALSA
Date: Mon, 1 Aug 2005 10:09:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508011008130.8196@tm8103-a.perex-int.cz>
References: <20050731133552.GA13386@brailcom.cz> <42ECDD88.5010805@superbug.co.uk>
 <20050731151755.GB13386@brailcom.cz> <42ECEEC1.3010701@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A0C9190
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 10:09:34 +0200 (MEST)
In-Reply-To: <42ECEEC1.3010701@superbug.co.uk>
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
Cc: Hynek Hanke <hanke@brailcom.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 31 Jul 2005, James Courtier-Dutton wrote:

> Once the hw_params and sw_params have been set, you cannot change them. You
> have to close and then reopen the device.

It's not true. You must call snd_pcm_hw_free() before applying of new 
hardware parameters. Software parameters can be changed at any time.

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
