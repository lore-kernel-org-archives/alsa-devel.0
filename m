From: William <walsac3@liam2.demon.co.uk>
Subject: Re: OSS vs ALSA war :-)
Date: Tue, 10 Aug 2004 18:16:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408101716.SAA04883@liam2.demon.co.uk>
References: <1092155904.861.3.camel@mindpipe>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from liam2.demon.co.uk (liam2.demon.co.uk [158.152.170.203])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B41B2110
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2004 19:15:07 +0200 (MEST)
In-Reply-To: <1092155904.861.3.camel@mindpipe>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, geeceezee@free.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> GCZ wrote:
>> Should I refrain from playing UT2004 just because Nvidia's drivers,
>> which work beautifully, are closed-source? Should I refrain from
>> playing Quake 3 because ALSA doesn't work with it?
> 
> No, this is why ALSA provides OSS emulation, so every legacy app doesn't
> have to be recoded.

One big problem is that some parts of ALSA's OSS emulation have been buggy
for a long time, especially its /dev/sequencer emulation:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=28
[First reported August 2002, present since before Alsa 0.9.0]

William


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
