From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Re: 2.6.12-rc1-mm3, sound card lost id
Date: Tue, 29 Mar 2005 19:57:21 +0200
Message-ID: <20050329195721.385717aa.khali@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<20050326111945.5eb58343.khali@linux-fr.org>
	<s5hr7hyiqra.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 79B4C229
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 19:57:18 +0200 (MEST)
In-Reply-To: <s5hr7hyiqra.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> > This one made /proc/asound/card0/id change from "Live" to "Unknown"
> > on one of my systems, preventing alsatcl from properly restoring my
> > mixer settings.
> 
> Hmm, perhaps it's a side effect of chip detection patch by James.
> But "Unknown" is bad, of course.
> 
> How does /proc/asound/cards look?

0 [Unknown        ]: EMU10K1 - SB Live [Unknown]
                     SB Live [Unknown] (rev.6, serial:0x80271102) at 0x8800, irq 5

With the bk-alsa patch reverted, it looks like:

0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.6, serial:0x80271102) at 0x8800, irq 5

Hope that helps. If you need any additional information, just ask.

Thanks,
-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
