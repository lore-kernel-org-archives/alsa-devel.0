From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic32x4: always enable
	analouge block
Date: Wed, 18 Jan 2012 16:29:54 +0100
Message-ID: <CACKLOr2Cv3BZyXD7yKh0FmuTG8jp2P+qqq8GXv+4bSx+o3n-sw@mail.gmail.com>
References: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
	<1326883739-8148-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E18E103B4C
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:29:55 +0100 (CET)
Received: by wera13 with SMTP id a13so2406080wer.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 07:29:54 -0800 (PST)
In-Reply-To: <1326883739-8148-2-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 18 January 2012 11:48, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Register LDOCTLEN must always be initialized to clear the analog power
> control bit, otherwise the analog block will stay deactivated.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Javier Martin <javier.martin@vista-silicon.com>

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
