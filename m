From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 23 Aug 2004 13:36:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4129D6A2.7020801@pg.gda.pl>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de> <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de> <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz> <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz> <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 380122D7
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 13:36:03 +0200 (MEST)
Received: from [153.19.40.232] (atlka@merlin.oi.pg.gda.pl [153.19.40.232])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i7NBa1Xf007394
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 13:36:01 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
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

> On Thu, 19 Aug 2004, Takashi Iwai wrote:
>>Can "network sound device" work with the mmap, too?
> I think yes, it can, but the real output will be more delayd. So, it won't 
> be much useable for the strict real-time applications.
But old quake and new quake3 and some OSS apps use mmap mode for better 
timing and accurate mixing so will it be usable if done that way?

As talking about network transparency it is a good idea but what about 
more system independent solution - look at MASS for example
(link from www.x.org).
I personally think that local sound should be done as effective as it 
can be so doing it through network layer is not a nice idea - maybe IPC
and non swappable shared memory should be used to transfer data
between kernel and user space to used ALSA mix/asym advantages.

I have a modified aoss lib which plays quake1 - quake3 and other apps
simulataniously but this is not a perfect solution. Sometimes sound is 
distorted and some apps are not working (these using SDL and poll method
- some time issues probably). This method not supports multichannel
sources (4, 5.1, 7.1) so OSS compatibility is not full.
I need volume regulation per source too which is missing.
OSS emulation in kernel is not fully compatible with OSS too so some 
native OSS apps will not work.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
