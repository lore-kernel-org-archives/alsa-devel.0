From: Liam Girdwood <lrg@ti.com>
Subject: Re: Non-DMA ASoC driver
Date: Wed, 28 Nov 2012 10:08:33 +0000
Message-ID: <50B5E2A1.1020101@ti.com>
References: <DB8F1B3EEF94C3439BFFE674EB05E3CC029C82CB@SIXPRD0211MB418.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C57E26167A
 for <Alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 11:08:40 +0100 (CET)
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC029C82CB@SIXPRD0211MB418.apcprd02.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 28/11/12 04:46, Craig McQueen wrote:
> I'm exploring hardware options for an audio interface for a Freescale i.MX28-based embedded Linux device. One option is to use a Synchronous Serial Port interface to connect in slave mode to an external CODEC. I have several doubts about the feasibility of this option, but for now, I have just one question:
>
> If we use this SSP, then we can't use DMA, but we would have to use interrupts for audio transfer. But I can't find any example code for a non-DMA based ASoC driver. Is it feasible to make a non-DMA based ASoC driver? How would it be implemented?
>

This has been done in sound/soc/fsl/imx-pcm-fiq.c and can be used as your 
platform driver.

Regards

Liam
