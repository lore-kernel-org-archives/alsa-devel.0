From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: bug tracking?
Date: Thu, 15 May 2003 19:12:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC3680A.60904@boosthardware.com>
References: <s5h3cjgfuwn.wl@alsa2.suse.de>	<Pine.LNX.4.44.0305151112200.9877-100000@pnote.perex-int.cz> <s5hznloeej6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA18893
	for <alsa-devel@alsa-project.org>; Thu, 15 May 2003 12:35:32 +0200
Received: from www2.webhosting.cx (www2.webhosting.cx [207.44.198.86])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA16682
	for <alsa-devel@alsa-project.org>; Thu, 15 May 2003 12:26:31 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>
>>The question is, if we have power to maintain such large bug reports.
>>From my experience, it works only few weeks until the system has many 
>>unresolved reports. Then the database gets filled and only some bugs are 
>>solved when our time permits. Also, when the database is large, it is
>>a bit problematic to mark solved reports (especially old ones).
> 

We also have the added difficulty of making sure each driver is 
adaquately covered by the system.

> - no template for necessary information
> 
>   e.g. alsa version, driver, chip/board name/model, output of lspci
>        output of proc files, etc.
> 

These could easily be found with a simple script or maybe there couold 
be an alsa.debug file in /proc/asound.

> 
> also, a moderator person would be helpful in addition to the automatic
> assignment according to the given driver/function.
> 

How about having a bugs mailing list and also the address of the driver 
writer. We could then post the report to the mailing list, the driver 
writer and also archive it on the alsa website.

I will start making a bugs page over the next few days which we can fine 
tune here. I'm not sure that bugzilla is appropriate for ALSA as we have 
so many different devices to look after however I will use it as a 
reference.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
