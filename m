From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Fri, 07 Sep 2007 14:11:20 +0200
Message-ID: <46E13FE8.5060309@gmail.com>
References: <46dfa2e7d6be4@wp.pl>	<46DFD29A.6020601@gmail.com>	<20070906231206.2ba8f939.krzysztof.h1@gmail.com>	<46E06E37.4090304@gmail.com>
	<s5h4pi66886.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B5B5D103892
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 14:17:54 +0200 (CEST)
In-Reply-To: <s5h4pi66886.wl%tiwai@suse.de>
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/07/2007 01:11 PM, Takashi Iwai wrote:

> The codes used for this auto-probing is relatively small and easy, so
> as Rene expected, I don't mind about it :)
> 
> The criterion is only whether it's _really_ useful and works without
> hitch.

Exactly. Krysztof snipped most of my objections but we are talking about 
legacy ISA hardware here. So imagine you have _another_ piece of legacy ISA 
hardware sitting on say IRQ 5. Unless you load your driver after the driver 
for the other bit of hardware is loaded, your driver finds IRQ 5 free, grabs 
it and configures the card for IRQ 5, after which your nor the other piece 
of hardware work anymore.

At this point, you've helped this poor unaware user from the docks into the 
harbour as he has no idea what's going on, having not specified anything 
himself.

I'll repeat -- there's really no defending that massive junk :-)

> We keep the old code as is just because it was worked, and we shouldn't
> break it.  The concept is not perfect, but if it practically works, I
> have no objection.

What practically works is sticking an options line in modprobe.conf...

But hey, I'm aware some people think it helps. As long as you are aware 
you're wrong and that it _is_ massive junk, I'm halfway content :-)

Rene.
