From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and
 front channels via fxbus 8,9
Date: Wed, 23 Feb 2005 10:00:49 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502230956490.1748@pnote.perex-int.cz>
References: <421A3A3A.6070009@glocalnet.net>  <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
 <1109109856.31071.44.camel@krustophenia.net> <Pine.LNX.4.58.0502230918440.1748@pnote.perex-int.cz>
 <421C4586.5090000@glocalnet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2DB691DB
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 10:08:47 +0100 (MET)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id F34A158E06
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 10:08:46 +0100 (MET)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id D86291102C
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 10:08:46 +0100 (CET)
In-Reply-To: <421C4586.5090000@glocalnet.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Feb 2005, Mikael Magnusson wrote:

> > Sorry, but I don't understand very well why we need to have "PCM mix" FX
> > buses. We can do this "down-mix" in the DSP code, but it's better to do it
> > in application. My original DSP code for emu10k1 have only front, rear,
> > center+lfe FX buses (6). I must miss something important here.
> > 
> 
> I don't understand what you mean with "PCM mix". Are you thinking of the 
> default output which are up-mixed to 5.1? The patch doesn't down-mix 5.1 
> to front or something like that. It adds two fx inputs that are routed 
> to front only and not up-mixed to 5.1. This is how the Audigy driver 
> works. It also can make the configuration file a little cleaner, since 
> it doesn't have to mute the up-mixed outputs.

I see now. My behaviour was to "duplicate" front to surround with "Wave 
Surround" controls and you propose to have FX buses which will route 
signal to both front & rear and separate FX buses to route signal to 
front only.

I don't see the real benefit. Both cases are correct and the alsa-lib
configuration won't be much different. Anyway, if you feel that it's
better, then go ahead...

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
