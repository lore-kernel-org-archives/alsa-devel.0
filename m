From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix memory leaks for the
 CS4270 driver
Date: Fri, 05 Sep 2008 09:11:57 -0500
Message-ID: <48C13E2D.10402@freescale.com>
References: <1220479634-26912-1-git-send-email-timur@freescale.com>	<s5hd4jko0p2.wl%tiwai@suse.de>	<48C004B4.2000208@freescale.com>	<s5htzcv98j8.wl%tiwai@suse.de>	<ed82fe3e0809041120u7b070c33j4bae7c221b935f36@mail.gmail.com>	<s5hvdxbt81w.wl%tiwai@suse.de>	<48C13804.8070307@freescale.com>
	<s5hmyim8z0r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 76C42103825
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:12:02 +0200 (CEST)
In-Reply-To: <s5hmyim8z0r.wl%tiwai@suse.de>
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

> Hm, but I think the code in the current ALSA tree has leak at
> removal (i.e. missing remove callback), and ASoC v2 isn't for 2.6.28
> yet.  Not a big issue, though.

The drivers cannot be compiled as modules anyway, so they can never be removed.
 I only want to fix real bugs in the V1 drivers these days.

-- 
Timur Tabi
Linux kernel developer at Freescale
