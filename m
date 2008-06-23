From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Fix register programming in Freescale
 MPC8610 HPCD sound driver
Date: Mon, 23 Jun 2008 11:59:57 -0500
Message-ID: <485FD68D.7020303@freescale.com>
References: <1213383751-17284-1-git-send-email-timur@freescale.com>	<485FD229.1090102@freescale.com>	<s5hej6o3xqs.wl%tiwai@suse.de>	<485FD3C7.6010301@freescale.com>
	<s5habhc3x8z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AFC4248D7
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 19:00:01 +0200 (CEST)
In-Reply-To: <s5habhc3x8z.wl%tiwai@suse.de>
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

> So, if you think it's really worth to be pushed, I'll try to do it
> now.  Just let me know.

At this point, I wouldn't bother.  The source code is fixed, but the end result
is that the hardware isn't programmed any differently, so it doesn't fix any
actual bugs.

-- 
Timur Tabi
Linux kernel developer at Freescale
