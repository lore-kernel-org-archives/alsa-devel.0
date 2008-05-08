From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] snd-pcsp: relax dependancy on CONFIG_INPUT
Date: Fri, 09 May 2008 02:38:46 +0400
Message-ID: <482380F6.3070309@aknet.ru>
References: <482316B8.5080200@aknet.ru> <s5h4p98yfof.wl%tiwai@suse.de>
	<4823390D.8010000@aknet.ru>
	<20080508173552.GA22887@cs181133002.pp.htv.fi>
	<482345AD.2040909@aknet.ru>
	<20080508221724.GG22887@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 31276247CD
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 00:38:50 +0200 (CEST)
In-Reply-To: <20080508221724.GG22887@cs181133002.pp.htv.fi>
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
> And your patches breaks the compilation with CONFIG_SND_PCSP=y, 
> CONFIG_INPUT=m if anyone will ever try this combination.
OK, that's nasty indeed...
Then I guess it is not a big deal
to leave that dependancy as-is until
the real need in changing it appear.

Btw, is there really no way at all
to tell kconfig something like
depends on INPUT if SND_PCSP_INPUT
or similar?
