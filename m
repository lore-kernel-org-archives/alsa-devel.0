From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 01 Feb 2008 09:18:46 -0600
Message-ID: <47A33856.9020806@freescale.com>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>	<s5hd4ulthy3.wl%tiwai@suse.de>	<473488CA.7050308@freescale.com>	<1194869575.32342.1220819105@webmail.messagingengine.com>	<47A23469.1010905@freescale.com>	<s5h8x243liz.wl%tiwai@suse.de>	<47A330C1.7030205@freescale.com>
	<s5hodb01zrp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 37C4E2458D
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 16:18:50 +0100 (CET)
In-Reply-To: <s5hodb01zrp.wl%tiwai@suse.de>
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

Takashi Iwai wrote:

> An ML archive has also a URL :)
> An advantage of ML is that it can involve developers more easily.

I'm not saying that the developers should use BTS instead of ML.  I'm saying 
that if it really is a bug in ALSA, I'd like to have formal recognition of that. 
  A entry in BTS would qualify.  I strewn-out discussion on a mailing list has 
too low of a signal-to-noise ratio to be useful to the PHBs.

> OK, now the question is in which condition this happens...

I'll try to get an exact testcase, but I think it's pretty much always with 
"mplayer -ao oss".

> Could you rewrite snd-dummy driver to behave like your driver?

Uh, are you kidding?  My driver is an ASoC driver.  How am I supposed to make a 
dummy driver "behave" like my driver?  My driver isn't doing anything unusual.

> As mentionted, it's important to get the environment to reproduce the
> problem reliably independent on hardwares.

I understand that, but I don't see how I can do that.

-- 
Timur Tabi
Linux kernel developer at Freescale
