From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Thu, 02 Mar 2006 11:04:04 +1100
Message-ID: <1141257844.3889.32.camel@localhost.localdomain>
References: <jehd7527wq.fsf@sykes.suse.de>
	 <1139783738.5247.54.camel@localhost.localdomain>
	 <20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
	 <1141254596.3889.26.camel@localhost.localdomain>
	 <1141256965.4378.145.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 45B441D0
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 01:04:21 +0100 (MET)
In-Reply-To: <1141256965.4378.145.camel@grayson>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Olaf Hering <olh@suse.de>, alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-01 at 18:49 -0500, Ben Collins wrote:
> On Thu, 2006-03-02 at 10:09 +1100, Benjamin Herrenschmidt wrote:
> > > > This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> > > > force it on up to now, but with this patch the internal speaker will not
> > > > work with or without my patch to force it on.
> > > 
> > > But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
> > > once to get the built-in speakers enabled.
> > > Looks like 2.6.16 stuff, but its been broken for so long now...
> > 
> > What is the status of Ben's latest stuff ?
> 
> I'm rediffing now. However, I may not include my tumbler changes
> immediately. For some reason, those are the ones causing problems. I
> need to review the diff and see if I can find the problem (which I
> cannot reproduce).
> 
> The toonie stuff is great. Been working really well for all the folks
> I've heard from, and for me on my PowerBook5,9.

There is an issue with some models where asserting both mutes will reset
the codec, so you have to be careful with that. Then, there is the
old-style GPIOs where you can read the polarity from the device-tree and
the new style ones...

I _think_ apple uses the GPIO platform functions only on machines that
have "include-k2-support" property in macio too, so maybe you are trying
to use them on earlier machines and they are bogus...

Send me the complete patch and I'll see if I spot something. Olaf, can
you give me quick summary of the machines that have problems with  Ben's
code ?

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
