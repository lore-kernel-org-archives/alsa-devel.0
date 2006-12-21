From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: sound/isa/cmi8330.c: dead ENABLE_SB_MIXER code
Date: Thu, 21 Dec 2006 21:22:05 +0100
Message-ID: <200612212122.06376.linux@rainbow-software.org>
References: <20061204160434.GF30290@stusta.de> <s5hac1kfbpo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailhub3.nextra.sk (smtp3.nextra.sk [195.168.1.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33E9A23A
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2006 21:22:15 +0100 (MET)
In-Reply-To: <s5hac1kfbpo.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, George Talusan <gstalusan@uwaterloo.ca>, linux-kernel@vger.kernel.org, perex@suse.cz, Adrian Bunk <bunk@stusta.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 19 December 2006 10:59, you wrote:
> At Mon, 4 Dec 2006 17:04:34 +0100,
>
> Adrian Bunk wrote:
> > In sound/isa/cmi8330.c, the ENABLE_SB_MIXER code is currently never
> > used.
> >
> > What's the story behind this?
> > Should ENABLE_SB_MIXER be enabled?
> > Or the code be removed?
>
> CMI8330 has a dual interface for SB and Adlib modes.  The mixer can
> also behave differently according to the mode.  The current code has
> mixer elements corresponding to both modes.

CMI8330 (and also CMI8329) appears like SB16 and WSS

> However, these mixer elements _seem_ to interactive with each other,
> and cannot be controlled individually.  That's why ENABLE_SB_MIXER is
> disabled.  I cannot check this issue any longer since the test board
> got broken long time ago...

The mixer is a bit weird - and probably different between CMI8329 and CMI8330. 
At least on my CMI8329A, the master volume does not work. And there are also 
some problems with PCM volume - I can decrease it in alsamixer but not 
increase - but it works both ways in XMMS...
I have also some boards with integrated CMI8330 - so I might test it 
sometimes.

> I don't think we would get many gain by changing this old code.
> (and the relevant part isn't so big.)
> Let's keep as it is.
>
>
> Takashi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ondrej Zary

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
