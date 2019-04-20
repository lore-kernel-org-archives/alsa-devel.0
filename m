From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the
 issue about unsupported rate
Date: Sat, 20 Apr 2019 07:16:50 +0000
Message-ID: <AM0PR04MB646849E3A8601038312FA9BEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
 <20190419181003.GA1136@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60079.outbound.protection.outlook.com [40.107.6.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 346BFF807B6
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2019 09:16:53 +0200 (CEST)
In-Reply-To: <20190419181003.GA1136@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi
> 
> 
> On Fri, Apr 19, 2019 at 10:23:50AM +0000, S.j. Wang wrote:
> > When the output sample rate is [8kHz, 30kHz], the limitation of the
> > supported ratio range is (1/24, 8). In the driver we use (8kHz, 30kHz)
> > instead of [8kHz, 30kHz].
> > So this patch is to fix this issue and the potential rounding issue
> > with divider.
> >
> > Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz output
> > sample rate")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c index
> > 0b937924d2e4..5b8adc7fb117 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -282,10 +282,10 @@ static int fsl_asrc_config_pair(struct
> fsl_asrc_pair *pair)
> >               return -EINVAL;
> >       }
> >
> > -     if ((outrate > 8000 && outrate < 30000) &&
> > -         (outrate/inrate > 24 || inrate/outrate > 8)) {
> > -             pair_err("exceed supported ratio range [1/24, 8] for \
> > -                             inrate/outrate: %d/%d\n", inrate, outrate);
> > +     if ((outrate >= 8000 && outrate <= 30000) &&
> > +         (outrate > 24 * inrate || inrate > 8 * outrate)) {
> > +             pair_err("exceed supported ratio range (1/24, 8) for
> > + inrate/outrate: %d/%d\n",
> 
> Using one of the conditions:
>         if (inrate > 8 * outrate)
>                 pair_err();
> 
> This means:
>         if (inrate <= 8 * outrate)
>                 /* Everything is fine */
> 
> So the supported ratio range is still [1/24, 8] right?
> 
Oh, yes,  should still [1/24, 8].

> Thanks
