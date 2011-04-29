From: Andrew Clayton <andrew@digital-domain.net>
Subject: Re: 2.6.38.4 broke my audio
Date: Fri, 29 Apr 2011 09:25:08 +0100
Message-ID: <20110429092508.35423bca@omega.digital-domain.net>
References: <20110424113037.11af0b04@omega.digital-domain.net>
	<20110425000126.GA18681@suse.de>
	<s5htydmhed2.wl%tiwai@suse.de>
	<20110425173409.GA32047@suse.de>
	<s5hpqoagjtf.wl%tiwai@suse.de>
	<BANLkTim0UGi2Y9wE4NEMgyKQLx73garNxA@mail.gmail.com>
	<s5hvcy1b2kj.wl%tiwai@suse.de>
	<BANLkTinVWhbis7HxfQLc-89eQgg=qsFhhg@mail.gmail.com>
	<s5h39l4gkf1.wl%tiwai@suse.de>
	<BANLkTinmXbkk579oaiTqRdexvOZFpS_gvg@mail.gmail.com>
	<s5haafbae7k.wl%tiwai@suse.de>
	<BANLkTimbyDBgdCuo=feser9eRnPhS34FQA@mail.gmail.com>
	<s5hy62vfpx4.wl%tiwai@suse.de>
	<BANLkTimMQgquUD+wi6WuxzVAK8eA7kQEQQ@mail.gmail.com>
	<s5hvcxzey1z.wl%tiwai@suse.de>
	<BANLkTim22Cb3e-ST2Mphn2CRksXWa6GwDw@mail.gmail.com>
	<s5hr58mgatq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr58mgatq.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Emmanuel Benisty <benisty.e@gmail.com>, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Apr 2011 08:16:17 +0200, Takashi Iwai wrote:

> OK, but now the patch assumes that it's a mutable output, so the 
> auto-mute shall happen.
> 
> Actually other OSes seem to mute the line-out as well, so we may
> follow the standard scenario.

OK, so I guess the bit in the distribution that saves and restores
mixer settings at shutdown/startup needs updating to take this new
mixer into account? as the speaker mixer is always muted at startup
now.

Cheers,
Andrew
