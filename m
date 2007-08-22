From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Wed, 22 Aug 2007 17:08:18 -0500
Message-ID: <46CCB3D2.7060908@freescale.com>
References: <46CB2BB4.9060808@freescale.com>	<s5hbqd0j5c6.wl%tiwai@suse.de>	<46CC480F.7090604@freescale.com>	<s5h3aybipj1.wl%tiwai@suse.de>	<Pine.LNX.4.58.0708221320240.30669@shell2.speakeasy.net>	<s5h7innnuv3.wl%tiwai@suse.de>	<46CCA5E1.5050704@freescale.com>
	<s5h3aybnsfq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 01DC9103804
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 00:08:22 +0200 (CEST)
In-Reply-To: <s5h3aybnsfq.wl%tiwai@suse.de>
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

> The purpose of prepare callback is to make the PCM stream ready to
> start.  (The trigger callbacks are supposed to be just triggering, not
> preparing the stream.)
> Usually, once after the PCM is triggered, the registers are no
> longer as same as the beginning.  If you want to stop and restart the
> stream, you'll very likely to reset the registers again.  That's why
> prepare is called again.  (Or, your driver is always go-or-die? :)

I thought you meant that the .prepare() function can be called multiple times 
*in a row*, like .hw_params() is.  But I guess that's not what you meant.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
