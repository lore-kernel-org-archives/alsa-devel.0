From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Re: 2.6.12-rc1-mm3, sound card lost id
Date: Tue, 29 Mar 2005 23:13:45 +0200
Message-ID: <20050329231345.281e7323.khali@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<20050326111945.5eb58343.khali@linux-fr.org>
	<s5hr7hyiqra.wl@alsa2.suse.de>
	<20050329195721.385717aa.khali@linux-fr.org>
	<1112127424.5141.7.camel@mindpipe>
	<20050329224630.069cda56.khali@linux-fr.org>
	<1112129571.5141.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B198B251
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 23:13:42 +0200 (MEST)
In-Reply-To: <1112129571.5141.18.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

> Here is the patch (against ALSA CVS) in its preferred format.  You
> will probably have to apply it by hand.  If the mixer settings can't
> be restored you'll have to do it manually or edit asound.state by
> hand.
> 
> Lee
> 
> Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
> retrieving revision 1.49
> diff -u -r1.49 emu10k1_main.c
> --- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	27 Mar 2005 14:00:54 -0000	1.49
> +++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	29 Mar 2005 20:51:44 -0000
> @@ -693,6 +693,10 @@
>  	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
>  	 .emu10k1_chip = 1,
>  	 .ac97_chip = 1} ,
> +	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
> +	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
> +	 .emu10k1_chip = 1,
> +	 .ac97_chip = 1} ,
>  	{.vendor = 0x1102, .device = 0x0002,
>  	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
>  	 .emu10k1_chip = 1,

Unsurprisingly, my card is now named CT4832. I had to edit
/etc/asound.state manually to get my mixer settings back (with some
warnings, but I get some sound).

Not sure I quite see the idea of renaming from "Live", which the user
will understand, to (I suppose) the exact chip name on the card, while
the user has certainly no idea what it is. But heh I'm not an ALSA
developer, there must be a good reason.

Thanks,
-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
