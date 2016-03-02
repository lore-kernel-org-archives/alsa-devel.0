From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 1 Mar 2016 17:43:57 -0800
Message-ID: <20160302014356.GA29297@Asurada-Nvidia>
References: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
 <20160226205208.GA25515@Asurada-Nvidia>
 <AM3PR04MB1412F6FB7E5107BBA3AB9B559ABB0@AM3PR04MB1412.eurprd04.prod.outlook.com>
 <20160301090615.GA4738@Asurada-CZ80>
 <20160302013439.GL18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 831D626154F
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 02:43:46 +0100 (CET)
Received: by mail-pa0-f45.google.com with SMTP id bj10so53665688pad.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2016 17:43:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160302013439.GL18327@sirena.org.uk>
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
Cc: Zidan Wang <zidan.wang@nxp.com>, alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 02, 2016 at 10:34:39AM +0900, Mark Brown wrote:
> On Tue, Mar 01, 2016 at 01:06:16AM -0800, Nicolin Chen wrote:
> 
> > I personally suggest you to use fsl-asoc-card. Since the Codec IC
> > provides three DAIs. And in the schematics, you do have three DAI
> > links. It sounds plausible to me that we might treat these three
> > DAI links as three different cards. Then use different compatible
> > names: "imx-audio-wm8958-aif1" and so on. And each one can also
> > has ASRC back-end support.
> 
> No, that's really not going to work very well - having the same CODEC
> with very tightly coupled clocking connected into three cards is just
> going to be a mess, especially for the WM8958 where AIF3 is mostly just
> a pinmux to the other two DAIs rather than something that could ever be
> fully independent.

I see. Thanks for the input.
