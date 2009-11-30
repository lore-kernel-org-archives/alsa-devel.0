From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
Date: Mon, 30 Nov 2009 18:09:24 +0100
Message-ID: <eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
	<eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id E45162442F
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 18:09:24 +0100 (CET)
Received: by fxm3 with SMTP id 3so2814719fxm.4
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 09:09:24 -0800 (PST)
In-Reply-To: <eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
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
Cc: Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

2009/11/30 javier Martin <javier.martin@vista-silicon.com>

> Dear Sascha,
> in "imx_ssi_set_dai_fmt()" callback you should add something like:
>
>     /* sync */
>     scr |= SSI_SCR_SYN;
>
> This would enable SSI working in SYN mode which means that RX and TX
> sections will share same frame and bit clocks. Right now I can't imagine a
> situation where this is not desirable. Moreover, if I don't add SYN mode I
> cannot get it working in my i.mx27 based board with an wm8974.
>

Well, after a chat with Mark it seems that it is not so uncommon that RX and
TX sections have different clocks. So you could add a flag in the platform
data similar to the one that switches between FIQ and DMA so that people can
choose if they want the feature or not.

Thank you.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
