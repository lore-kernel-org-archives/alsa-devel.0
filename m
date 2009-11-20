From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: i.MX audio support
Date: Fri, 20 Nov 2009 08:51:31 +0100
Message-ID: <eedb5540911192351l5abc7a18s5a218f9b20b58d1b@mail.gmail.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
	<20091119175327.GV30179@pengutronix.de>
	<20091119185426.GA2814@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 19C20103819
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 08:51:32 +0100 (CET)
Received: by fxm1 with SMTP id 1so7509229fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 23:51:32 -0800 (PST)
In-Reply-To: <20091119185426.GA2814@sirena.org.uk>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Theoretically, current merged code only supports i.MX21/27 in the DMA
part. So it would be correct adding a DMA separate driver for i.MX31.

However I disagree with completely new SSI code. It should be possible
to add an arch define to export proper DMA structures whether we are
using i.MX21/27 or i.MX31 in the current SSI driver.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
