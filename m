From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: Add device's module
	clock selection.
Date: Mon, 6 Jan 2014 04:10:12 +0000
Message-ID: <1d24a986cd5e43608100d32ef32ff656@BY2PR03MB505.namprd03.prod.outlook.com>
References: <20140104161956.79906baf@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A6A26163C
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 05:10:16 +0100 (CET)
In-Reply-To: <20140104161956.79906baf@armhf>
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
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



> Subject: Re: [PATCH] ASoC: simple-card: Add device's module clock selection.
> 
> Li,
> 
> I am trying to have many DAI links in the simple-card, but I get an
> error on getting the device clock: only the dma device needs a clock
> and the spdif codec has none. What was the purpose of this default
> device clock?
> 

Yes, for spdif there is no need to do the CPU/CODEC DAI devices' sysclk setting,
but for many others like SAI,SSI... need.

I will send another patch to fix this.

Thanks,

--
Best Regards,
Xiubo 
