From: Sigi Jekabsons <zig@icmelectrics.com>
Subject: Re: snd-hda-intel,
 AD 1988b: SPDIF output not working correctly, volume low for analog output
Date: Mon, 20 Aug 2007 17:35:46 +0800
Message-ID: <46C96072.3070501@icmelectrics.com>
References: <200707170832.01976.ml_alsa@mortal-soul.de>	<200707200829.03682.ml_alsa@mortal-soul.de>	<s5hd4ynnq44.wl%tiwai@suse.de>	<200707232258.24771.ml_alsa@mortal-soul.de>	<loom.20070818T162601-634@post.gmane.org>
	<s5h3ayeo8tu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maow.myip.org (203-59-197-231.dyn.iinet.net.au [203.59.197.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 9556110393E
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 11:35:58 +0200 (CEST)
In-Reply-To: <s5h3ayeo8tu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Takashi Iwai wrote:
> Then it must be a usage error.  In the ALSA system, the same stream is
> used regardless of audio or non-audio data.
>
> It might be that you set non-audio bit permanently.  Verify with
> iecset program in alsa-utils package.
>
>
> Takashi
>   
Audio mode is enabled.  I haven't made any other changes since compiling 
in the modifications I mentioned earlier.  I wasn't aware of this 
utility before looking up this thread however, so I don't know what the 
data rate or mode it was running before. 

Thanks.
