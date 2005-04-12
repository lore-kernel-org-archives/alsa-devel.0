From: Andrew Morton <akpm@osdl.org>
Subject: Re: OSS emulation, CS46xx, 2.6.12-rc2
Date: Tue, 12 Apr 2005 04:18:07 -0700
Message-ID: <20050412041807.4c37acd0.akpm@osdl.org>
References: <20050411012145.29c390a3.akpm@osdl.org>
	<s5hbr8lpimi.wl@alsa2.suse.de>
	<20050411175957.53e023f6.akpm@osdl.org>
	<s5hvf6smhqx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68E4229B
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 13:18:23 +0200 (MEST)
In-Reply-To: <s5hvf6smhqx.wl@alsa2.suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> > > It seems that the recent change of the "reversed EAPD" hack sets this
>  > > control off as default unexpectedly.
>  > > 
>  > > Anyway, /etc/asound.state (if you have) and
>  > 
>  > Attached
> 
>  The problem is that "DAC Volume" is set to 0 by any reason.
>  I don't know how this happend.  The driver default is 100%.
> 
>  To fix this, again, start alsamixer, choose 'DAC', and raise with the
>  up/down key.
> 

well I went into alsamixer and increased everything to max and now sounds
are coming out.  I wonder what happened to my defaults?  It's running FC3.

gmplayer is getting segv on startup now, and I didn't change anything :(

>  > > /proc/asound/card0/codec97#0/* files would be helpful for debugging.
>  > 
>  > I don't seem to have such a thing.  I tarred up /proc/asound.  Also attached.
> 
>  Hmm, it's ridiculous.  You don't have /proc/asound/card0 directory?

Nope.  Where did it go?

>  (It should have nothing to do with the "silent" problem, though.)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
