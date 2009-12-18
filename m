From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
Date: Fri, 18 Dec 2009 15:18:50 +0100
Message-ID: <eedb5540912180618w53e24c6ahe1d47d410e1a91e8@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
	<eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
	<eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
	<20091201154920.GW27548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f190.google.com (mail-vw0-f190.google.com
	[209.85.212.190])
	by alsa0.perex.cz (Postfix) with ESMTP id D906910390F
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 15:18:51 +0100 (CET)
Received: by vws28 with SMTP id 28so949698vws.16
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 06:18:51 -0800 (PST)
In-Reply-To: <20091201154920.GW27548@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

>
> Ok, will do. I myself use the asynchronous mode. The MC13783 I use has
> two SSI ports, one for capture and one for playback. I route both ports
> to the same SSI unit using the audio muxer.
>
> Sascha
>

Dear Sascha,
I don't wanna delay the entering of this driver to mainline. It is clear
that it is cleaner and more generic than mine. And, what we really care, it
works for our board.

If you have any inconvenience with my requirement I could just ack the patch
and maybe we could add support for it later.

Thank you.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
