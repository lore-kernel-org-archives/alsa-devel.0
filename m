From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/10] Convert gameport to driver model/sysfs
Date: Fri, 11 Feb 2005 09:11:40 +0100
Message-ID: <20050211081140.GB1675__44606.1409581036$1108109687$gmane$org@ucw.cz>
References: <200502110158.47872.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from suse.cz (twilight.ucw.cz [81.30.235.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 024B01B6
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2005 09:11:08 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <200502110158.47872.dtor_core@ameritech.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: InputML <linux-input@atrey.karlin.mff.cuni.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 11, 2005 at 01:58:47AM -0500, Dmitry Torokhov wrote:

> This series of patches adds a new "gameport" bus to the driver model.
> It is implemented very similarly to "serio" bus and also allows
> individual drivers to be manually bound/disconnected from a port
> by manipulating port's "drvctl" attribute.

Good work! I'm pulling it into my tree. And test.

> The changes can also be pulled from my tree (which has Vojtech's
> input tree as a parent):
> 
> 	bk pull bk://dtor.bkbits.net/input 
> 
> I am CC-ing ALSA list as the changes touch quite a few sound drivers.
> 
> Comments/testing is appreciated.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
