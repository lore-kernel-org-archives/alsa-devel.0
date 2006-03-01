From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Wed, 01 Mar 2006 18:49:25 -0500
Message-ID: <1141256965.4378.145.camel@grayson>
References: <jehd7527wq.fsf@sykes.suse.de>
 <1139783738.5247.54.camel@localhost.localdomain>
 <20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
 <1141254596.3889.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from a34-mta02.direcway.com (a34-mta02.direcpc.com [66.82.4.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 280E31CB
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 00:50:28 +0100 (MET)
Received: from mail.phunnypharm.org ([72.169.114.90]) by a34-mta02.direcway.com
 (iPlanet Messaging Server 5.2 HotFix 1.25 (built Mar  3 2004))
 with ESMTP id <0IVH00KTM3JWPS@a34-mta02.direcway.com> for
 alsa-devel@alsa-project.org; Wed, 01 Mar 2006 18:50:27 -0500 (EST)
In-reply-to: <1141254596.3889.26.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-02 at 10:09 +1100, Benjamin Herrenschmidt wrote:
> > > This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> > > force it on up to now, but with this patch the internal speaker will not
> > > work with or without my patch to force it on.
> > 
> > But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
> > once to get the built-in speakers enabled.
> > Looks like 2.6.16 stuff, but its been broken for so long now...
> 
> What is the status of Ben's latest stuff ?

I'm rediffing now. However, I may not include my tumbler changes
immediately. For some reason, those are the ones causing problems. I
need to review the diff and see if I can find the problem (which I
cannot reproduce).

The toonie stuff is great. Been working really well for all the folks
I've heard from, and for me on my PowerBook5,9.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
