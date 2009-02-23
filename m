From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] ALS4000, slight mixer improvements
Date: Mon, 23 Feb 2009 10:36:51 +0100
Message-ID: <20090223093651.GA1609@rhlx01.hs-esslingen.de>
References: <20090222193341.GA15819@rhlx01.hs-esslingen.de>
	<s5hljrx4n8b.wl%tiwai@suse.de>
	<20090223092636.GA25887@rhlx01.hs-esslingen.de>
	<s5hwsbh33h3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id C2340103862
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 10:36:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwsbh33h3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 23, 2009 at 10:30:16AM +0100, Takashi Iwai wrote:
> At Mon, 23 Feb 2009 10:26:36 +0100,
> Andreas Mohr wrote:
> > AFAICS, things should ideally work this way:
> > plug USB adapter, ALSA uses its default USB-Audio.conf settings (just like
> > with several other PCI and such cards), then for devices with non-existing
> > H/W volume (and only those!!), automatically and generically provide ALSA
> > softvol.
> 
> The "automatically" is easy to write but hard to achieve the guarantee
> to work with all possible devices :)
> 
> Especially the mixer name of usb-audio is determined dynamically by
> guess from usb descriptors, covering all possible names is no easy
> task.

Oh well, I'm not entirely up to what you're indicating here,
but at least I do have some diversity, via two very different adapters
(one 5.1 / H/W softvol, one not), and thus I should be able to draw
some conclusions.

Thanks!

Andreas Mohr
