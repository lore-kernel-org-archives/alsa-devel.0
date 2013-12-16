From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH v2] ASoC: SGTL5000: Fix kernel failed while
 trying to get optional VDDD supply.
Date: Mon, 16 Dec 2013 03:31:36 +0000
Message-ID: <1e493d42f11648428d1ce95883313f2a@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1385621219-20652-1-git-send-email-Li.Xiubo@freescale.com>
 <20131129183855.GI27568@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F828E3D21@039-SN2MPN1-011.039d.mgd.msft.net>
 <20131203123459.GS27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0154.outbound.protection.outlook.com [207.46.163.154])
 by alsa0.perex.cz (Postfix) with ESMTP id A9094261B2F
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 04:31:39 +0100 (CET)
In-Reply-To: <20131203123459.GS27568@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "oskar@scara.com" <oskar@scara.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


> > 2, If the regulator dt node is exist but the optional VDDD is absent (i.e.
> > The external VDDD is not used), a -EPROBE_DEFER will be returned, if
> > just return the -EPROBE_DEFER to the probe(and then the probe deferral
> > mechanism will do the probe again later, is that right ?), and then
> > the
> > regulator_get_optional() will be called later again, and the
> > -EPROBE_DEFER will be returned again too, and now how should I handle
> > -EPROBE_DEFER error twice ? Or should there be a counter about this ?
> > That to say when the -EPROBE_DEFER error is the second time returned
> > from regulator_get_optional() can we ensure that the optional VDDD is really
> not in use.
> 
> The driver should just defer when it's told to defer, I don't understand why it
> would want to count anything?
>

It's just one idea for the special handling of regulator_get_optional() in this
case.

--
Xiubo
