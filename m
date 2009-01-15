From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Thu, 15 Jan 2009 22:16:10 +0000
Message-ID: <496FB5AA.1030205@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<20090115172057.GC12768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id C58FA1038AC
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 23:15:44 +0100 (CET)
In-Reply-To: <20090115172057.GC12768@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> Always do this for ALSA patch submissions (the same thing will apply to
> the majority of kernel subsystems).  Please also CC at least me on ASoC
> patches.

My bad, sorry.

> I do read the list but it helps to make sure things don't get
> missed.

Sure.

> These all look fine apart from one small thing in the codec driver 

>> +
>> +	soc_ac97_ops.reset(codec->ac97);
> 
> This should check the return value, resets can and do fail.

This call returns void. So no.

I cant see a way to determine the outcome of a reset on wm9705. I could 
program a register, then check to see it is set to its reset value, but 
if the codec is hung, this could cause lockups.

Russell's isue has been fixed.

TTFN!

-Ian
