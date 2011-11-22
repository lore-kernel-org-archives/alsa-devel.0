From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 09:37:58 -0600
Message-ID: <4ECBC1D6.9090301@freescale.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 57E34103A81
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:38:10 +0100 (CET)
In-Reply-To: <20111122153539.GF6624@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Neumann <s.neumann@raumfeld.com>, Sven@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> That's very odd, not ringing any bells at all.  It's not like the
> existing code is trying to do anything clever with skipping writes, it
> just blasts in all the register values and it's affecting two different
> registers.

Is there a quick-and-dirty way to test suspend/resume?  It's not officially supported on our board with a CS4270, so I never tried it, and I'm not familiar with it.

-- 
Timur Tabi
Linux kernel developer at Freescale
