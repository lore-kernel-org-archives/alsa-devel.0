From: lokowich <lokowich@acdstar.com>
Subject: Re: MPC5200 I2S driver for ASoC
Date: Wed, 01 Aug 2007 16:03:57 -0500
Message-ID: <46B0F53D.4060308@acdstar.com>
References: <46B0C3EE.5020401@acdstar.com>
	<9e4733910708011241g3c52339cte955a39c3e4f80df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sentry.acdstar.com (mail.acdstar.com [209.98.244.9])
	by alsa0.perex.cz (Postfix) with ESMTP id AE9892442A
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 23:16:25 +0200 (CEST)
Received: from MailerDaemon by sentry.acdstar.com with local-bsmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IGLYO-0001X9-KR
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 16:16:24 -0500
Received: from [192.168.2.3] (port=48355 helo=mail.acdstar.com)
	by sentry.acdstar.com with esmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IGLYL-0001X0-5L
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 16:16:21 -0500
In-Reply-To: <9e4733910708011241g3c52339cte955a39c3e4f80df@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks, must've missed that one when grabbing the FEC patch.  This AC97 
driver seems more mature than the BSP version, but relies on the powerpc 
architecture rather than ppc.  I've dabbled but haven't made the jump to 
the newer scheme.  Are we stopping further MPC52xx development in ppc?

Jon Smirl wrote:
> This was posted to linux-ppc in May. It may have some updated code.
>
> Patch: [PATCH 9/9] sound: Add support for Freescale MPC5200 AC97 interface.
> http://patchwork.ozlabs.org/linuxppc/patch?id=11102
>
>
>   

This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
