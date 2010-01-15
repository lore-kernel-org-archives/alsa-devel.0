From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: cs4270: allow passing
	freq=0 in set_dai_sysclk()
Date: Fri, 15 Jan 2010 11:08:56 -0600
Message-ID: <4B50A128.9050105@freescale.com>
References: <20100113162749.GA26519@sirena.org.uk>
	<1263573409-30863-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 476E31037F7
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 18:08:59 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0FH8wJK021469
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 10:08:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0FHEwUx012646
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 11:14:59 -0600 (CST)
In-Reply-To: <1263573409-30863-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> For setups with variable MCLKs, the current logic of limiting the
> available sampling rates at startup time is not sufficient. We need to
> be able to change the setting at a later point, and so the codec must
> offer all possible rates until the hw_params are given.
> 
> This patches allows that by passing 0 as 'freq' argument to
> cs4270_set_dai_sysclk().
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Timur Tabi <timur@freescale.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
