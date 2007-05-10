From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC AC97 device reg bugfix
Date: Thu, 10 May 2007 18:09:15 +0100
Message-ID: <1178816955.10518.129.camel@a10072.wolfsonmicro.main>
References: <1178814513.10518.127.camel@a10072.wolfsonmicro.main>
	<s5htzukiqqk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id B27F124358
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 19:09:17 +0200 (CEST)
In-Reply-To: <s5htzukiqqk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-10 at 18:32 +0200, Takashi Iwai wrote:
> At Thu, 10 May 2007 17:28:33 +0100,
> Liam Girdwood wrote:
> > 
> > This patch fixes a bug whereby AC97 bus device data was being clobbered
> > when AC97 codecs using the generic ac97_codec.c driver were being
> > registered. Codecs that didn't use the generic driver were unaffected
> > (e.g. WM9712, WM9713).
> > 
> > Changes:-
> > 
> >  o Add new AC97 codec class for custom (or need bus dev registration)
> > AC97 codecs.
> >  o Only register/deregister this custom codec device with the AC97 bus.
> > The generic AC97 driver already does this for generic codec devices.
> > 
> > This may be related to bug #3038 :-
> >  
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3038
> > 
> > Manuel, can you try this on SH & Au1x00.
> 
> Is this supposed to be merged to the upstream?  Then give a sign-off,
> please.


Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Thanks

Liam
