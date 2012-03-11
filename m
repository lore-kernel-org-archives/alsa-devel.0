From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Sun, 11 Mar 2012 13:58:59 +0000
Message-ID: <4F5CAFA2.4000002@freescale.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
	<1331316853.3789.4.camel@odin> <4F5A55DE.8020609@freescale.com>
	<20120311125558.GG3233@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe005.messaging.microsoft.com [213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id F325F2439F
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 14:59:06 +0100 (CET)
In-Reply-To: <20120311125558.GG3233@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <5B4AF0BFA2743449A34EA276D473F590@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> I wonder if PowerPC mutexes are
> less forgiving here?

I'm still debugging this (although I have higher priority tasks to worry 
about, unfortunately), but it appears that the mutex is already taken when 
that code is executed.  Unfortunately, I have been unable to figure out 
where.  One second the 'count' value is 1, and then it suddenly becomes 
'0', and then mutex_lock() is called.

-- 
Timur Tabi
Linux kernel developer at Freescale
