From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Wed, 22 Aug 2007 16:08:49 -0500
Message-ID: <46CCA5E1.5050704@freescale.com>
References: <46CB2BB4.9060808@freescale.com>	<s5hbqd0j5c6.wl%tiwai@suse.de>	<46CC480F.7090604@freescale.com>	<s5h3aybipj1.wl%tiwai@suse.de>	<Pine.LNX.4.58.0708221320240.30669@shell2.speakeasy.net>
	<s5h7innnuv3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 39C551037FB
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 23:08:54 +0200 (CEST)
In-Reply-To: <s5h7innnuv3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> The buffer allocation in prepare callback would actually do work.
> I've never mentioned that it doesn't work.  It's just not
> recommended, simply because the prepare is called more often than
> hw_params even without changing the parameters.

What is the driver supposed to do on the second call to .prepare()?  In other 
words, what is the point of calling it multiple times in a row?  Once my 
driver is prepared to start, how could it become more prepared?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
