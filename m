From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Non-DMA ASoC driver
Date: Wed, 28 Nov 2012 04:46:37 +0000
Message-ID: <DB8F1B3EEF94C3439BFFE674EB05E3CC029C82CB@SIXPRD0211MB418.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 4195726030F
 for <Alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 05:46:54 +0100 (CET)
Received: from mail137-ch1 (localhost [127.0.0.1])	by
 mail137-ch1-R.bigfish.com (Postfix) with ESMTP id 4773840018C	for
 <Alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 04:46:53 +0000 (UTC)
Received: from CH1EHSMHS043.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.226])	by mail137-ch1.bigfish.com (Postfix) with ESMTP id
 40A2D4A0045	for <Alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 04:46:52
 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm exploring hardware options for an audio interface for a Freescale i.MX28-based embedded Linux device. One option is to use a Synchronous Serial Port interface to connect in slave mode to an external CODEC. I have several doubts about the feasibility of this option, but for now, I have just one question:

If we use this SSP, then we can't use DMA, but we would have to use interrupts for audio transfer. But I can't find any example code for a non-DMA based ASoC driver. Is it feasible to make a non-DMA based ASoC driver? How would it be implemented?

All the ASoC drivers I see use a machine driver that declares a struct snd_soc_card with field .platform that points to a struct snd_soc_platform object, which implements the DMA stuff. If I don't use DMA, do I still need to somehow make a non-DMA platform driver that implements a struct snd_soc_platform object and handles the interrupts? Or, should I handle the interrupts and audio buffer manipulation directly in the CPU DAI driver?

(My current guess is that this is feasible, but charting new territory, so we'll probably end up using different hardware design that allows us to do a more conventional DMA-based driver.)

Thanks,
Craig McQueen
