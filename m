From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Make Freescale
 SAI/ESAI/SPDIF to be visible in Kconfig
Date: Fri, 21 Mar 2014 06:46:11 +0000
Message-ID: <0bc01e5036fa4a11beaea10c56c283fe@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
 <1392086825-15737-2-git-send-email-Li.Xiubo@freescale.com>
 <36d9c0a870604fbe87b129e95fea9da1@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140220024432.GU2669@sirena.org.uk> <20140220030739.GA26721@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 67A5A26167A
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 07:46:15 +0100 (CET)
In-Reply-To: <20140220030739.GA26721@MrMyself>
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
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Has this patch been missing? I couldn't found it anywhere in the next branch.
:)

Thanks very much,

--
Best Regards,
Xiubo



> -----Original Message-----
> From: Nicolin Chen [mailto:Guangyu.Chen@freescale.com]
> Sent: Thursday, February 20, 2014 11:08 AM
> To: Mark Brown
> Cc: Xiubo Li-B47053; lgirdwood@gmail.com; shawn.guo@linaro.org; perex@perex.cz;
> tiwai@suse.de; Estevam Fabio-R49496; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] ASoC: fsl: Make Freescale SAI/ESAI/SPDIF to be
> visible in Kconfig
> 
> On Thu, Feb 20, 2014 at 11:44:32AM +0900, Mark Brown wrote:
> > On Thu, Feb 20, 2014 at 02:06:20AM +0000, Li.Xiubo@freescale.com wrote:
> >
> > > I'm not very sure of this patch, maybe should we add one menu
> > > in Kconfig for all visible CPU DAIs firstly like for code drivers?
> >
> > Allowing them to be individually selected is definitely useful if people
> > are trying to minimise their kernel size and/or build time.  However
> > none of the other Freescale people have commented on this patch (which
> > I'd have expected) so I was giving them time and IIRC it needs a rebase
> > against current code.
> 
> Last month I was revising a new CODEC driver for ESAI and meanwhile abort
> to plan to try simple card for this combination but being suspended due to
> some tough internal issues. So I think it should be a good idea for us to
> move towards simple card starting from this patch.
> 
> Surely, Acked.
> Nicolin Chen
> 
