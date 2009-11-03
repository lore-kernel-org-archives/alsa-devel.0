From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs4236: detect chip in one pass
Date: Tue, 3 Nov 2009 20:30:25 +0100
Message-ID: <20091103203025.e7c93616.krzysztof.h1@poczta.fm>
References: <20091101165038.e3f5b0e9.krzysztof.h1@poczta.fm>
	<s5hiqdtxm6t.wl%tiwai@suse.de>
	<20091102221306.f95800ed.krzysztof.h1@poczta.fm>
	<s5hzl749m88.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 37CA2103811
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 20:12:17 +0100 (CET)
In-Reply-To: <s5hzl749m88.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, wim@djo.tudelft.nl, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Nov 2009 07:05:43 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 2 Nov 2009 22:13:06 +0100,
> Krzysztof Helt wrote:
> > 
> > These lines now inside if (CS4236B) clause. If one removes this condition, 
> > the CS4236B cannot be fully initialized and the CS4236 controls do not work 
> > (some of them require control port access).
> 
> Hm?  I mean to have code like
> 
> 	if (!(chip->hardware & WSS_HW_CS4236B_MASK)) {
> 		snd_printd("chip is not CS4236+, hardware=0x%x\n",
> 			   chip->hardware);
> 	 	*rchip = chip;
> 	 	return 0;
> 	}
> 

I see. It is only for formatting purpose. I'll change.

Regards,
Krzysztof

-----------------------------------------------------------------------------
Dzwonki na telefon!
Pobierz >> http://link.interia.pl/f2411
