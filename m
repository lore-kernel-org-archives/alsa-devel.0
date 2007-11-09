From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 09 Nov 2007 14:06:41 -0600
Message-ID: <4734BDD1.9080103@freescale.com>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>	<s5hd4ulthy3.wl%tiwai@suse.de>
	<473488CA.7050308@freescale.com> <4734A448.7000909@aknet.ru>
	<4734BA93.6040900@freescale.com> <4734BC5F.8040800@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CE3B24368
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 21:07:07 +0100 (CET)
In-Reply-To: <4734BC5F.8040800@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stas Sergeev wrote:
> Timur Tabi wrote:
>> How can I tell that my /etc/asound.conf is actually loaded and used?
> Write some total crap into it, and
> if the sound stops working, then it
> is definitely used. :)

It looks like it's not being used.  I also tried ~/.asoundrc and that didn't 
make a difference either.  When is /etc/asound.conf supposed to be loaded?  I 
must be missing something fundamental here.  I'm running ALSA 1.0.14 and my 
libasound is 2.0.0.

-- 
Timur Tabi
Linux kernel developer at Freescale
