From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: i.MX audio support
Date: Fri, 20 Nov 2009 11:32:10 +0100
Message-ID: <eedb5540911200232u21767102i8310e62b952c77bb@mail.gmail.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
	<20091119175327.GV30179@pengutronix.de>
	<20091119185426.GA2814@sirena.org.uk>
	<eedb5540911192351l5abc7a18s5a218f9b20b58d1b@mail.gmail.com>
	<20091120095109.GW30179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BFA1103819
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 11:32:11 +0100 (CET)
Received: by fxm1 with SMTP id 1so7822250fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 02:32:11 -0800 (PST)
In-Reply-To: <20091120095109.GW30179@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> I would agree if the current code worked and would be good shape.
> Unfortunately it's not. It hardcodes the fact that there are 2 SSI units
> (i.MX51 has three of them). Instead of writel/readl it uses direct pointer
> derefs. The driver skips audio while it reinitialises the DMA engine. In
> mx1_mx2_pcm_open() there are several memory leaks. The driver does not
> call clk_get itself but depends on the board doing it. The only
> available board support depends on a board not present in the kernel, so
> we are not able to compile it (and it won't because the audmux
> definitions are missing)

We have still some pending HW changes in our board so we are not ready
to submit it now. Anyway it would have been nice to have such this
comments when I submitted my patches to avoid unnecessary rework.

> This all leads to a huge series of patches and much work and in the end
> we would have a nearly rewritten driver.

All right, just let me test your patch in our board and comment.

Thank you.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
