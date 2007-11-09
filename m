From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 09 Nov 2007 10:20:26 -0600
Message-ID: <473488CA.7050308@freescale.com>
References: <472E5A64.6010705@aknet.ru>
	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>
	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>
	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>
	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>
	<s5hd4ulthy3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 136BE2447C
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 17:20:55 +0100 (CET)
In-Reply-To: <s5hd4ulthy3.wl%tiwai@suse.de>
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

> For example, set
> 
> 	slave.periods 3
> 	slave.period_size 4096
> 
> then you'll hear the improvement, I guess.

Can someone tell me exactly where I'm supposed to put those two lines?  Every 
time I try to understand ALSA configuration files, I just get more confused.

-- 
Timur Tabi
Linux kernel developer at Freescale
