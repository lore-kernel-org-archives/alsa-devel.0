From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Thu, 02 Mar 2006 11:04:32 +1100
Message-ID: <1141257873.3889.34.camel@localhost.localdomain>
References: <jehd7527wq.fsf@sykes.suse.de>
	 <1139783738.5247.54.camel@localhost.localdomain>
	 <20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
	 <1141254596.3889.26.camel@localhost.localdomain>
	 <1141256965.4378.145.camel@grayson>  <20060302000019.GB6792@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E9A341D0
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 01:04:40 +0100 (MET)
In-Reply-To: <20060302000019.GB6792@suse.de>
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
Cc: Ben Collins <bcollins@ubuntu.com>, alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-02 at 01:00 +0100, Olaf Hering wrote:
>  On Wed, Mar 01, Ben Collins wrote:
> 
> > I'm rediffing now. However, I may not include my tumbler changes
> > immediately. For some reason, those are the ones causing problems. I
> > need to review the diff and see if I can find the problem (which I
> > cannot reproduce).
> 
> Can you make individual patches, each one fixing one thing, going from A
> to B.  You know that hch song...

In that case, it's difficult as it's more like a rewrite of the GPIO
handling from scratch (well... almost)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
