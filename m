From: Tim Goetze <tim@quitte.de>
Subject: Re: Re: Ready Developer
Date: Fri, 13 Sep 2002 18:00:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209131750540.639-100000@summer.quitte>
References: <s5hhegtucf5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA23070
	for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2002 18:02:02 +0200
In-Reply-To: <s5hhegtucf5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Fri, 13 Sep 2002 17:23:14 +0200 (CEST),
>Tim Goetze wrote:
>> 
>> Takashi Iwai wrote:
>> 
>> >At Fri, 13 Sep 2002 13:37:05 +0200 (CEST),
>> >Tim Goetze wrote:
>> >> 
>> >> - get rid of nasty clicks on open/start/stop/close of pcms.
>> >
>> >which driver?  ice1712?
>> 
>> yes, m-man audiophile. the clicks are perceptible even if all
>> volumes are set to 0.
>
>i hoped that it be intel8x0 (it was fixed recently :)
>
>well, could you check whether this happen on plug layer or even on hw?

using hw. from what jaroslav says, it seems the DA converter on the
audiophile is to blame. the AD stream looks ok, it's all zeroes right
from the start.

the click actually happens when preparing the device, starting is ok.

tim




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
