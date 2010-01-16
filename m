From: "Ambrose, Martin" <martin@ti.com>
Subject: Re: [PATCH] ARM: DaVinci: Audio support for
	DA850/OMAP-L138 EVM
Date: Sat, 16 Jan 2010 17:25:41 -0600
Message-ID: <A24693684029E5489D1D202277BE8944515C9CC3@dlee02.ent.ti.com>
References: <1250024605-27215-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C24D1037F8
	for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2010 00:25:47 +0100 (CET)
In-Reply-To: <1250024605-27215-1-git-send-email-chaithrika@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Subrahmanya, Chaithrika" <chaithrika@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
Cc: "Tufino, Bobby" <tufino@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Longley, Lester" <lester@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello.

On DA850/OMAPL138 the McASP AMUTE pin is multiplexed with UART2_RTS.
As a consequence, I believe, of the below additions when the kernel is built with
SOC audio support the ttyS2 console stops accepting input after boot.

Moreover on the EVM the AMUTE pin is only connected to headers AFAICT.
Specifically I think the DA850_AMUTE pin can be removed from below without 
any loss of audio functionality while preserving console input.

> +const short da850_mcasp_pins[] __initdata = {
> +	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
> +	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
> +	DA850_AXR_11, DA850_AXR_12,
> +	-1
> +};

Regards,
Martin
