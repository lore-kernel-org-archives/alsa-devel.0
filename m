From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH Resend 3/8] ASoC: simple-card: simplify the
	daifmt code
Date: Fri, 24 Jan 2014 07:26:26 +0000
Message-ID: <bd116a4f66f14933a9f018e3f37343b4@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
 <1390453370-29194-4-git-send-email-Li.Xiubo@freescale.com>
 <20140123192004.GD11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 by alsa0.perex.cz (Postfix) with ESMTP id D88B926165C
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 08:26:29 +0100 (CET)
In-Reply-To: <20140123192004.GD11727@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH Resend 3/8] ASoC: simple-card: simplify the daifmt code
> 
> On Thu, Jan 23, 2014 at 01:02:45PM +0800, Xiubo Li wrote:
> > In the asoc_simple_card_parse_of() will parse the device node's CPU/CODEC
> > DAI commone fmts, and then in asoc_simple_card_sub_parse_of() will parse
> > the CPU/CODEC DAI's sub-node fmts, so we can combine the info->daifmt and
> > info->set.fmt in asoc_simple_card_sub_parse_of() not while just before
> > _set_fmt().
> 
> This doesn't apply against the current topic/simple, can you please
> check and resend?

Yes, it's caused by the dependency of PATCH 2/8, and the PATCH 2/8 needs to
be revised.

I will resend them, which hasn't been applied, and also adding one binding
patch.

Thanks,

--
Best Regards,
Xiubo
