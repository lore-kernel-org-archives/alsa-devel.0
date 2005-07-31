From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] AC97 bus interface for ad-hoc drivers
Date: Sun, 31 Jul 2005 15:26:48 +0100
Message-ID: <1122820009.3211.2.camel@localhost.localdomain>
References: <1121775624.14604.14.camel@cearnarfon>
	 <s5hbr4old2a.wl%tiwai@suse.de>
	 <Pine.LNX.4.63.0507270856510.21762@localhost.localdomain>
	 <1122582399.5371.90.camel@localhost.localdomain>
	 <s5h4qaddh5w.wl%tiwai@suse.de>
	 <1122636040.3117.28.camel@localhost.localdomain>
	 <s5hwtn9c0of.wl%tiwai@suse.de>
	 <1122641516.3117.38.camel@localhost.localdomain>
	 <s5hmzo5bpwx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzo5bpwx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Nicolas Pitre <nico@cam.org>, alsa-devel@lists.sourceforge.net, Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-07-29 at 17:19 +0200, Takashi Iwai wrote:
> 
> Thanks.  I applied it to CVS with some modifications.
> 
> - the registration and unregistration to ac97_bus is done in
>   dev_register and dev_unregister callbacks.  This assures that
>   card->dev is set.
> 
> - 2.2/2.4 workaronds in alsa-driver tree.
> 
> Please check whether it's OK (later, after cvs tree is sync'ed)

Works as expected.

Thanks

Liam



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
