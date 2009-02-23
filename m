From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] ALS4000, slight mixer improvements
Date: Mon, 23 Feb 2009 10:26:36 +0100
Message-ID: <20090223092636.GA25887@rhlx01.hs-esslingen.de>
References: <20090222193341.GA15819@rhlx01.hs-esslingen.de>
	<s5hljrx4n8b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id A6BBA10384C
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 10:26:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hljrx4n8b.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, andi@lisas.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Feb 23, 2009 at 08:38:12AM +0100, Takashi Iwai wrote:
> Applied now.  Thanks.

Thanks!

> > Will now try to get HDA settings on Aspire One A110L investigated
> > (using Takashi's elaborate tools) and corrected
> > (the non-working microphone thingy, plus some weird random switching/activation
> > of noise in sound sources at times and stuff).
> 
> Let me know if it's finished!

Maybe I should start for real first ;)


> > Speaking of sound problems, any thoughts about how to end up with
> > _automatic_, generic ALSA soft volume for those cheap non-hardvol USB sticks?
[...]
> 
> The only problem right now is that the driver might give a real volume
> control but in a different name.  OTOH, softvol itself isn't too bad as
> default PCM definition.  Just editing USB-Audio.conf should suffice...

Probably something like
http://launchpadlibrarian.net/7244751/USB-Audio.conf
(referenced by https://bugs.launchpad.net/ubuntu/+source/alsa-lib/+bug/104130 )?

AFAICS, things should ideally work this way:
plug USB adapter, ALSA uses its default USB-Audio.conf settings (just like
with several other PCI and such cards), then for devices with non-existing
H/W volume (and only those!!), automatically and generically provide ALSA
softvol.

Anyway, I'll look into it since it might be easy and is very important
to have _by default_.

Thanks,

Andreas Mohr
