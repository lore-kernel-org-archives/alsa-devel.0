From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: The different STATES of ALSA
Date: Sun, 31 Jul 2005 16:51:00 +0100
Message-ID: <42ECF364.2010200@superbug.co.uk>
References: <20050731133552.GA13386@brailcom.cz> <42ECDD88.5010805@superbug.co.uk> <20050731151755.GB13386@brailcom.cz> <42ECEEC1.3010701@superbug.co.uk> <20050731153812.GC13386@brailcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 936A11B0
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 17:51:05 +0200 (MEST)
In-Reply-To: <20050731153812.GC13386@brailcom.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hynek Hanke <hanke@brailcom.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hynek Hanke wrote:
>>>>>	d) snd_pcm_drop and _drain
>>>
>>>Calling the function in every other state is considered an error?
>>
>>I don't know. But in any other state, it won't actually do anything.
> 
> 
> Can someone please clarify this?
> 
> With Regards,
> Hynek
> 
> 
You can read the documentation regarding this.
e.g. The doxygen documentation should help.
Alternatively, read the comments at the top of alsa-lib/src/pcm/pcm.c



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
