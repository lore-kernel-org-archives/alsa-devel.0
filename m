From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mpu401_pnp
Date: Wed, 9 Feb 2005 17:46:10 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502091741060.14773-100000@studcom.urz.uni-halle.de>
References: <4207C02C.2060602@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mailgate.uni-halle.de (mailgate.urz.Uni-Halle.DE [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BC25226D
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 17:46:11 +0100 (MET)
In-Reply-To: <4207C02C.2060602@free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: matthieu castet <castet.matthieu@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

matthieu castet wrote:
> Clemens Ladisch wrote:
> > matthieu castet wrote:
> >
> >>Ok, I found a bug in your patch : when you call pnp_register_driver, you
> >>should check that it is >= 0. If not you shouldn't call
> >>pnp_unregister_driver.
> >
> > I just copied this from the other ALSA PnP drivers.  It seems those
> > have all the same bug.
>
> only old oss driver seem to use it, the other alsa driver use
> pnp_register_card_driver that seem only provide >= 0 res

It seems both pnp_register_driver() and pnp_register_card_driver()
can return a negative value (when CONFIG_PNP isn't set).  I'll fix it
when I've found out how the 2.2/2.4 wrappers behave.


Best regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
