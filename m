From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Adds 24bit, 96khz support for multichannel
 playback on the Audigy 2 sound cards.
Date: Sun, 13 Mar 2005 13:05:33 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503131304410.1755@pnote.perex-int.cz>
References: <423349A5.8020001@superbug.co.uk> <Pine.LNX.4.58.0503130906540.1755@pnote.perex-int.cz>
 <42341B5F.20504@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D78B81E0
	for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2005 13:18:35 +0100 (MET)
In-Reply-To: <42341B5F.20504@superbug.co.uk>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 13 Mar 2005, James Courtier-Dutton wrote:

> Jaroslav Kysela wrote:
> > 
> > 
> > Could you cleanup a bit your code before merging? It seems that there is 
> > alot of #if 0 .. #endif parts....
> > 
> 
> The code inside the #if 0 .. #endif implements features that I have not 
> yet finished merging. E.g. 24bit capture.
> As I fix each section, the #if 0 etc. will be removed.
> Would you prefer that I just remove all the current sections under #if 0 
> and then add them back in as I get them working?

Okay, applied the stripped version and new code slipped into 1.0.9rc1 
(will be available in next minutes)...

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
