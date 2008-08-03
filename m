From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] wss_lib: remove open_mutex
Date: Sun, 3 Aug 2008 17:50:59 +0200
Message-ID: <20080803175059.10eee100.krzysztof.h1@poczta.fm>
References: <20080802074846.91839fb6.krzysztof.h1@poczta.fm>
	<s5hbq0a8qew.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id A1BB324753
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 17:45:38 +0200 (CEST)
In-Reply-To: <s5hbq0a8qew.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 03 Aug 2008 10:16:07 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 2 Aug 2008 07:48:46 +0200,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Open and close operations are mutexed in higher layer
> > so remove open_mutex inside the driver.
> 
> I see snd_wss_open() is called also from the timer API.  This isn't
> protected for PCM streams, at least.
> 
> 

Right, I missed this.

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e91
