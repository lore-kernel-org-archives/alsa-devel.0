From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: ALSA SoC status
Date: Thu, 16 Mar 2006 10:56:48 +0000
Message-ID: <1142506608.30276.29.camel@cearnarfon>
References: <20060316093811.GK21043@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orlando.wolfsonmicro.main (webmail.wolfsonmicro.com [212.20.225.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E453190
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 11:56:51 +0100 (MET)
In-Reply-To: <20060316093811.GK21043@trinity.fluff.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Dirk Opfer <Dirk@Opfer-Online.de>, Richard Purdie <rpurdie@rpsys.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Ben,

On Thu, 2006-03-16 at 09:38 +0000, Ben Dooks wrote:
> I would like to know how the ALSA SoC work is going on,
> as I am hoping to get the S3C2410/S3C244X better supported
> and was hoping that the ASoC work would make the job easier
> to do.

It's working well on some pxa2xx machines atm. There are people
currently working on support for omap and AT91RM9200. I have access to a
pb1500 and i.MX21 boards so I'll be able to add support for them in the
near future. 

> 
> Are there any plans to merge ASoC soon, otherwise, is there
> any advice for getting the S3C24XX and the boards produced
> with it on supported?
> 

The plan is to merge 0.10 into alsa-kernel. 0.10rc4 was released
recently (will be on http://www.rpsys.net/openzaurus/patches/alsa/ by
the weekend). The patch is large at about 450k (supports a lot of
codecs), so I'm happy to send it to anyone who requests.

ASoC 0.10 final is waiting on me completing some documentation: i.e. how
to write a platform driver, codec driver, how dynamic audio pm works,
etc. We also still have some machine specific bugs to fix on some
Zauruses and some testing before we can release final.

I'd be glad to help and advise with the S3C24XX support. I've sent the
current patch to you off list.

Liam




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
