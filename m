From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Thu, 19 Aug 2004 12:28:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
 <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de>
 <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
 <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
 <s5h8ycbv4s9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BA34420D
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2004 12:35:31 +0200 (MEST)
In-Reply-To: <s5h8ycbv4s9.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Shaya Potter <spotter@cs.columbia.edu>, Clemens Ladisch <clemens@ladisch.de>, Mauro Romano Trajber <trajber@terra.com.br>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Aug 2004, Takashi Iwai wrote:

> Can "network sound device" work with the mmap, too?

I think yes, it can, but the real output will be more delayd. So, it won't 
be much useable for the strict real-time applications.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
