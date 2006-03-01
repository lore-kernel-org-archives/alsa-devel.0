From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Thu, 02 Mar 2006 10:09:55 +1100
Message-ID: <1141254596.3889.26.camel@localhost.localdomain>
References: <jehd7527wq.fsf@sykes.suse.de>
	 <1139783738.5247.54.camel@localhost.localdomain>
	 <20060226173908.GA4871@suse.de>  <20060301223034.GA5965@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BFC9616F
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 00:10:01 +0100 (MET)
In-Reply-To: <20060301223034.GA5965@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olaf Hering <olh@suse.de>
Cc: alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org


> > This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> > force it on up to now, but with this patch the internal speaker will not
> > work with or without my patch to force it on.
> 
> But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
> once to get the built-in speakers enabled.
> Looks like 2.6.16 stuff, but its been broken for so long now...

What is the status of Ben's latest stuff ?

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
