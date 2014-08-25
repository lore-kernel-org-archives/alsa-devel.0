From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename
 big_endian_data to is_msb_first.
Date: Mon, 25 Aug 2014 03:22:01 +0000
Message-ID: <d37de1209f2e484da3d1fbe5e71cdc86@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
 <53FAAB0D.2000403@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 by alsa0.perex.cz (Postfix) with ESMTP id BF6E1261ADA
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 05:22:04 +0200 (CEST)
In-Reply-To: <53FAAB0D.2000403@tabi.org>
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
To: Timur Tabi <timur@tabi.org>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Monday, August 25, 2014 11:19 AM
> To: Xiubo Li-B47053; broonie@kernel.org; alsa-devel@alsa-project.org;
> mark.rutland@arm.com; nicoleotsuka@gmail.com
> Cc: devicetree@vger.kernel.org
> Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename big_endian_data to
> is_msb_first.
> 
> Xiubo Li wrote:
> > -	sai->big_endian_data = of_property_read_bool(np, "big-endian-data");
> > +	sai->is_msb_first = of_property_read_bool(np, "msb-first");
> 
> This will break backwards compatibility with older device trees.
>

Well, this hasn't been used for any other SoCs expect the LS1+, which are
still doing the Upstream.

Thanks,

BRs
Xiubo
