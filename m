From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: SALSA and aplay
Date: Thu, 19 Jul 2007 16:40:08 +0100
Message-ID: <20070719154008.GA3238@localhost>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<s5hr6n7ukwf.wl%tiwai@suse.de>
	<200707181601.11164.gineera@aspect135.co.uk>
	<200707181720.29171.gineera@aspect135.co.uk>
	<s5hy7hcu49f.wl%tiwai@suse.de> <20070719142440.GA2467@localhost>
	<s5hk5swqxim.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id CC91110382A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 17:36:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk5swqxim.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 19, 2007 at 04:27:29PM +0200, Takashi Iwai wrote:
> At Thu, 19 Jul 2007 15:24:40 +0100,
> John Rigg wrote:
> > Wouldn't it be better to specify hw:0 (or whatever card you are using)
> > in this case? With this type of hardware I'd rather make sure that dmix
> > isn't used at all (I assume that dmix is now the default instead of
> > hw:0).
> 
> Well, you can claim that because you don't get bug reports or rants ;)

:-)
I wasn't criticising the decision to make dmix the default, just
suggesting that Alan and other users of pro and semi-pro hardware
specify on the command line which device they want apps to use.

> The only reason that plug+dmix is used is that it can handle most
> cases without hitches.  It works as it is.  That's all above other
> reasons.

I understand entirely.

John
