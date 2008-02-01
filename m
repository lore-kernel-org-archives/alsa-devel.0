From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 01 Feb 2008 10:00:44 -0600
Message-ID: <47A3422C.7040905@freescale.com>
References: <472E5A64.6010705@aknet.ru>
	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>
	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>
	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>
	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>
	<s5hd4ulthy3.wl%tiwai@suse.de>	<473488CA.7050308@freescale.com>	<1194869575.32342.1220819105@webmail.messagingengine.com>	<47A23469.1010905@freescale.com>
	<s5h8x243liz.wl%tiwai@suse.de>	<47A330C1.7030205@freescale.com>
	<s5hodb01zrp.wl%tiwai@suse.de>	<47A33856.9020806@freescale.com>
	<s5hk5lo1ytp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id B5C7B24559
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 17:00:48 +0100 (CET)
In-Reply-To: <s5hk5lo1ytp.wl%tiwai@suse.de>
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

> Simply make snd_pcm_hardware fields to match with yours so that 
> we get the identical hardware constraints.  You see many examples in
> the code.

Alright, I'll add it to my to-do list.

-- 
Timur Tabi
Linux kernel developer at Freescale
