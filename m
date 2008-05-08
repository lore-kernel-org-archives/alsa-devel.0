From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] snd-pcsp: relax dependancy on CONFIG_INPUT
Date: Thu, 08 May 2008 21:53:25 +0400
Message-ID: <48233E15.6000206@aknet.ru>
References: <482316B8.5080200@aknet.ru> <s5h4p98yfof.wl%tiwai@suse.de>
	<4823390D.8010000@aknet.ru>
	<20080508173552.GA22887@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 3092A24795
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 19:53:35 +0200 (CEST)
In-Reply-To: <20080508173552.GA22887@cs181133002.pp.htv.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

Adrian Bunk wrote:
> Sorry for the silly question, but are there serious usecases where 
> people in very space limited environments and with CONFIG_INPUT=n
> want PC-Speaker support?
I don't know, but there might be
someone who wants the PCM support
from pc-speaker, and hates the beeps
at the same time. So they can disable
it forever. :)
I also want to resolve the conflict
with INPUT_PCSPKR somehow. Making the
input part of snd-pcsp optional looks
like the first step to me. It became
known to me that loading multiple
drivers for the same device will be
possible in the future. I want to get
everything ready for loading pcspkr
and snd-pcsp together.
And overall, having snd-pcsp to depend
on CONFIG_INPUT only because it can do
a console beeps as a bonus, looks ill-
behaved to me. So I just propose that
patch as a small logical correction
and cleanup, rather than a new feature.
