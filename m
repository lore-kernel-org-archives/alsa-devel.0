From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/4] pxa-ssp: switch from network mode
	to	psp
Date: Thu, 5 Mar 2009 11:36:20 +0100
Message-ID: <20090305103620.GA28878@buzzloop.caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<1236197820-21022-4-git-send-email-daniel@caiaq.de>
	<74d0deb30903041256u8eeea03n5500cd59afadd86e@mail.gmail.com>
	<20090304230301.GA20915@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B89B6103858
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 11:36:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304230301.GA20915@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 12:03:01AM +0100, Daniel Mack wrote:
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (fmt & SND_SOC_DAIFMT_INV_MASK)=
 {
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_NF:
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_FSRT;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_IF:
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMP =
| SSPSP_FSRT;
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_IB_IF:
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sspsp |=3D SSPSP_SFRMP;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =

> > Removal of SSPSP_FSRT from NB/IB selection seems to be correct from the=
 docs.
> =

> SSPSP_FSRT has a totally different meaning according to the PXA3xx docs,
> but I'll have a look at the PXA2x specs - maybe we need a special case
> here.

Sorry, got you wrong. I compared that to the PXA27x spec and it turns
out that this bit has no different meaning there. So it is definitely
wrong to use it for inverting the bitclk, no special case needed.

Daniel
