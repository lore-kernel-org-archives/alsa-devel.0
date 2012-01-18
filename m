From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic32x4: always enable
	dividers
Date: Wed, 18 Jan 2012 16:29:16 +0100
Message-ID: <CACKLOr3On8ZZ+K3J4YbE21H-QKimHROMOCL0rqaA02gX7EMseA@mail.gmail.com>
References: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A32A3103B4D
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:29:16 +0100 (CET)
Received: by wico1 with SMTP id o1so2815394wic.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 07:29:16 -0800 (PST)
In-Reply-To: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
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
> Dividers (such as MDAC) are always needed, independent of the codec
> being I2S master or slave. Needed on a custom board where the codec has
> to be slave.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Javier Martin <javier.martin@vista-silicon.com>
