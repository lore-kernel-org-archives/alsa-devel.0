From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] ALSA: wss_lib: rework snd_ad1848_probe()
Date: 06 Aug 2008 09:57:24 +0200
Message-ID: <20080806075724.5A1AA7DC87F@f20.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 1D9F124701
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 09:57:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

> Hi Takashi.
> 
> This reworks snd_ad1848_probe(), making for IMO significantly more 
> straightforward reading.
> 
> The original had a somewhat odd try-loop where it not only waited for 
> the codec to come out of init but also retried a failed basic detect 
> which seems to not make sense. Except for that, the detection logic 
> should be unchanged.
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

> I am by the way rather unsure what it is that the spin_lock is trying to 
> protect us from here. What's the error scenario if we just not take it? 
> We aren't live yet...
> 
> Next step is folding this into snd_wss_probe() directly.
> 

I would like to leave it separate as 1. End of this function is good check point of correct detection for ad1848 chips, 2. The snd_wss_probe() is long enough.
But I won't oppose it fiercely.

Krzysztof

----------------------------------------------------------------------
Tani Telefon!
Sprawdz >>>  http://link.interia.pl/f1ec0  
