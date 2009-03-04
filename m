From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: make ops a pointer in 'struct
	snd_soc_dai'
Date: Wed, 04 Mar 2009 15:32:58 -0600
Message-ID: <49AEF38A.6050802@freescale.com>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>	
	<ed82fe3e0903020439u497389ccp7ec35c7de37ad936@mail.gmail.com>	
	<f17812d70903020646q15d43dcch8ad90df2cb486499@mail.gmail.com>	
	<49AC225D.6090002@freescale.com>
	<f17812d70903021740w5c0c5dfck5a92869650bf5bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CAF62433C
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 22:33:02 +0100 (CET)
In-Reply-To: <f17812d70903021740w5c0c5dfck5a92869650bf5bd7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

Eric Miao wrote:

> Updated as below, (gzip version attached due to mailing list
> mail size limitation).
> 
> From 74a2b6dfff2948d9d04b33d0a02f645f8c12caf7 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao@marvell.com>
> Date: Mon, 2 Mar 2009 22:38:31 +0800
> Subject: [PATCH] ASoC: make ops a pointer of 'struct snd_soc_dai'
> 
> Considering the fact that most cpu_dai or codec_dai are using a same
> 'snd_soc_dai_ops' for several similar interfaces, 'ops' would be better
> made a pointer instead, to make sharing easier and code a bit cleaner.
> 
> The patch below is rather preliminary since the asoc tree is being
> actively developed, and this touches almost every piece of code,
> (and possibly many others in development need to be changed as
> well). Building of all codecs are OK, yet to every SoC, I didn't test
> that.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

Tested on an MPC8610 HPCD, and it works.  That's all I can vouch for,
though.

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
