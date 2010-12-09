From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA
 oper. in I2S code
Date: Thu, 09 Dec 2010 10:08:02 +0000
Message-ID: <1291889282.3271.20.camel@odin>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291856375.31916.94.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D736103850
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 11:08:05 +0100 (CET)
Received: by wwe15 with SMTP id 15so2123829wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 02:08:05 -0800 (PST)
In-Reply-To: <1291856375.31916.94.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-09 at 03:59 +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Changes to I2S code:
> - SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.
> - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
>   while ALSA will do all sample format translation for us.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
