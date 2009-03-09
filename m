From: Gregorio Guidi <gregorio.guidi@gmail.com>
Subject: Re: [PATCH] fix headphone settings and master
	volume	(Conexant CX20551 0x103c30b2)
Date: Mon, 9 Mar 2009 15:49:47 +0100
Message-ID: <200903091549.47758.gregorio.guidi@gmail.com>
References: <200903082119.41670.gregorio.guidi@gmail.com>
	<s5hljredifh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.tre.it (mail.tre.it [62.13.171.46])
	by alsa0.perex.cz (Postfix) with ESMTP id 1399710387F
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 15:49:54 +0100 (CET)
In-Reply-To: <s5hljredifh.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 09 March 2009 12:50:10 Takashi Iwai wrote:
> At Sun, 8 Mar 2009 21:19:41 +0100,
>
> Gregorio Guidi wrote:
> > Hi, I have an Intel HDA card, Conexant CX20551 (Waikiki) model,
> > Subsystem Id: 0x103c30b2 (HP DV2000 series).
> >
> > With these settings, there are 4 volume controls: "PCM-2" and "Speaker"
> > to control speakers, "PCM" and "Headphone" to control headphones.
> > At the moment "PCM-2", "Speaker", "PCM" work fine, but "Headphone" has no
> > effect (also reported inside bug #3091).
>
> Does the current driver work with model=laptop-hp option?

I did try the laptop-hp option. I got only two controls: PCM and Master, PCM 
controlled both speakers and headphones, while Master controlled only the 
headphones (in fact the "Master" control for model=laptop-hp is the same as 
the "Headphone" control for model=laptop with the patch). There is no automute 
when plugging headphones.

By the way, I was incorrect: also with model=laptop (the default) "PCM" 
controls both speakers and headphones (PCM-2 only the speakers).

Let me know if you need info or you have something to test.

Gregorio Guidi
