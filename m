From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] miroSOUND PCM12 driver
Date: Wed, 16 Mar 2005 11:51:46 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503161138550.28424-100000@studcom.urz.uni-halle.de>
References: <20050313103317.GA2280@tuba>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C21616F
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 11:52:12 +0100 (MET)
In-Reply-To: <20050313103317.GA2280@tuba>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> The tenth birthday of this card is coming soon and now it's time to get
> an ALSA driver for the miroSOUND PCM12 :)
>
> Any comments?

> +++ alsa-driver/isa/opti9xx/Makefile	Fri Mar 11 18:51:05 2005
> +obj-$(CONFIG_SND_MIRO) += snd-miro.o snd-opti92x-cs4231.o

Is there any reason for the dependency on the snd-opti92x-cs4231
driver?

> MODULE_SUPPORTED_DEVICE("{{miroSOUND,PCM1 pro}, "
> 			"{miroSOUND,PCM12}, "
> 			"{miroSOUND,PCM20 Radio}}");

The first entry in each pair should be the vendor name.

> static int wss;                                 /* unknown range */
> static int ide;                                 /* unknown range */

"unknown"? :-)

> int snd_miro_mixer(miro_t * miro)
> ...
> 	switch (miro->hardware) {
>         case OPTi9XX_HW_82C924:
> 		strcpy(card->mixername, "ACI & OPTi924");
>         case OPTi9XX_HW_82C929:
> 		strcpy(card->mixername, "ACI & OPTi929");
> 	default:
> 		strcpy(card->mixername, "ACI & OPTi9xx");
> 	}

The default case cannot happen (bwahaha!), so it might make sense to
put a snd_BUG() in there.

> - OPL4 support is still missing, because I'm still waiting for response
> of my broken OPL4 chip. :(

Is it broken with the snd-opti92x-cs4231 driver, too?

> - I never saw any docs about the cards. All knowledge is taken from ACI
> driver (OSS) and OPTi9xx (ALSA) drivers.

There are OPTi manuals on the ALSA FTP server.


Otherwise, it looks fine.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
