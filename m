From: Chip Salzenberg <chip@pobox.com>
Subject: Re: intel8x0: Prospects for working suspend?
Date: Mon, 23 Feb 2004 17:40:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040223224005.GF2555@perlsupport.com>
References: <20040219222241.GB2390@perlsupport.com> <s5hd68auiko.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.topaz.cx (mail@topaz.cx [66.220.6.227])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA14328
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2004 23:43:35 +0100
Content-Disposition: inline
In-Reply-To: <s5hd68auiko.wl@alsa2.suse.de>
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

According to Takashi Iwai:
> At Thu, 19 Feb 2004 17:22:41 -0500, Chip Salzenberg wrote:
> > However, last I tried to suspend the intel8x0 driver, it didn't work
> 
> please enter to bugtracking system with the enough information

Done, bug #81.  FWIW, suspending when idle results only in muteness
curable through mixer manipulation, but suspending when active results
in a process hang curable only with kill.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
