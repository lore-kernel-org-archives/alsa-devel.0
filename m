From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: EMU10K1 Problem. Im stumped.
Date: Sat, 05 Jul 2008 10:06:45 +0100
Message-ID: <486F39A5.2040108@superbug.co.uk>
References: <1215192750.9160.6.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D1C324405
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jul 2008 11:06:47 +0200 (CEST)
In-Reply-To: <1215192750.9160.6.camel@temp-fallen>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Travis Place wrote:
> Just had a user on #alsa with an EMU10K1 problem.
>
> To summarize, the card shows up in linux (but doesnt work), yet the card
> works perfectly in windows. The correct modules are loading, but ALSA
> doesnt see the card.
>
> It had the user unload/reload snd-emu10k1 and check dmesg output, and
> the relevant result is as follows.
>
> EMU10K1_Audigy: probe of 0000:00:0a.0 failed with error -16
>
>   
The driver is requesting an IRQ to use, but fails to get it.
the output of
cat /proc/interrupts

and the entire dmesg output would help track this one down.
