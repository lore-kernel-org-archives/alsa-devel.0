From: Li Xiubo <B47053@freescale.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio
 machine driver.
Date: Tue, 5 Nov 2013 06:17:32 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287564A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
 <20131101120700.GE10324@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 89C14264FE7
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 07:17:38 +0100 (CET)
In-Reply-To: <20131101120700.GE10324@S2101-09.ap.freescale.net>
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
To: Shawn Guo <shawn.guo@linaro.org>, Guangyu Chen <B42378@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <bro>
List-Id: alsa-devel@alsa-project.org


> > >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208
> > > +++++++++++++++++++++++++++++++++++++
> >
> > I just doubt if this file naming is appropriate. Even if we might not
> > have rigor rule for the file names, according to existing ones, they
> > are all in a same pattern: [SoC name]-[codec name].c
> >
> > "imx-sgtl5000.c" for example
> >
> > I think it would make user less confused about what this file exactly
> > is if this machine driver also follow the pattern: vf610-sgtl5000.c
> >
> >
> > @Shawn
> >
> > What do you think about the file name?
> 
> Yeah, it would be better to name the file following the existing the
> pattern.
> 

Please see the next version.

Best Regards,
Xiubo
