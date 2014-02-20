From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Make Freescale
 SAI/ESAI/SPDIF to be visible in Kconfig
Date: Thu, 20 Feb 2014 11:07:41 +0800
Message-ID: <20140220030739.GA26721@MrMyself>
References: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
 <1392086825-15737-2-git-send-email-Li.Xiubo@freescale.com>
 <36d9c0a870604fbe87b129e95fea9da1@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140220024432.GU2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 48473265626
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 04:22:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140220024432.GU2669@sirena.org.uk>
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
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 20, 2014 at 11:44:32AM +0900, Mark Brown wrote:
> On Thu, Feb 20, 2014 at 02:06:20AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > I'm not very sure of this patch, maybe should we add one menu
> > in Kconfig for all visible CPU DAIs firstly like for code drivers?
> 
> Allowing them to be individually selected is definitely useful if people
> are trying to minimise their kernel size and/or build time.  However
> none of the other Freescale people have commented on this patch (which
> I'd have expected) so I was giving them time and IIRC it needs a rebase
> against current code.

Last month I was revising a new CODEC driver for ESAI and meanwhile abort
to plan to try simple card for this combination but being suspended due to
some tough internal issues. So I think it should be a good idea for us to
move towards simple card starting from this patch.

Surely, Acked.
Nicolin Chen
