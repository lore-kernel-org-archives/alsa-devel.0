From: Travis Place <wishie@wishie.net>
Subject: Re: Patch for alsa-info.sh - AC97 including regs
Date: Tue, 26 Feb 2008 02:26:06 +1000
Message-ID: <200802260226.07271.wishie@wishie.net>
References: <200802260205.50530.wishie@wishie.net>
	<s5hablpt3cx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C3CB243D8
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 17:26:15 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id C131D4B89C
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 16:47:35 +1000 (EST)
In-Reply-To: <s5hablpt3cx.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Feb 2008 2:20:14 am Takashi Iwai wrote:
> At Tue, 26 Feb 2008 02:05:50 +1000,
>
> Travis Place wrote:
> > Ok, ive added the +regs file aswell, but decided to store its output in a
> > seperate tmp file (before being added to the complete output).
>
> Thanks, applied now to HG tree.
>
> > This way, we can change how its output if we'd like, with less stuffing
> > around (and all tmp files are cleaned up after each run, anyway).
>
> Apropos about tmp files: let's use mktemp for temporary files.  Using
> the fixed tmp directory could be a possible security hole.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Good call.. ill fix that up, and post the patch when ready.. getting rather 
late/early for me (2:30am).

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
