From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: Possible regression of Mackerel/ASoC Simple Card
 in next-20130107
Date: Tue, 14 Jan 2014 04:10:56 +0000
Message-ID: <4d593a7756024226a22d93cce2b78b9c@BY2PR03MB505.namprd03.prod.outlook.com>
References: <20140108040017.GA11231@verge.net.au>
 <20140114022353.GA7053@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CCE72610B5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 05:11:06 +0100 (CET)
In-Reply-To: <20140114022353.GA7053@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi 

> >
> > I noticed that next-20130107 does not boot on the Mackerel board does not
> > boot using its defconfig. The boot log is as follows.
> >
> > I have not investigated any further as typically when I investigate
> > problems in next they turn out to be known problems.
> 
> This problem does not appear to be present any more in next-20140113.
> 
 
Maybe the following patch fixed this if the dts is not using.

"ASoC: simple-card: fix a bug where cinfo will be NULL before using it"

Thanks,
