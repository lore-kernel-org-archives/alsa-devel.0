From: Li Xiubo <B47053@freescale.com>
Subject: Re: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000
 codec driver about regulator.
Date: Wed, 6 Nov 2013 08:59:53 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id BC8AE2608CA
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 10:00:00 +0100 (CET)
In-Reply-To: <20131101185045.GG2493@sirena.org.uk>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, Shawn Guo <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Guangyu Chen <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "oskar@scara.com" <oskar@scara.com>
List-Id: alsa-devel@alsa-project.org

> > On VF610 series there are no regulators used, and now whether the
> > CONFIG_REGULATOR mirco is enabled or not, for the VF610 audio patch
> > series, the board cannot be probe successfully.
> > And this patch will solve this issue.
> 
> I don't understand what this is for at all, you're just saying there is a
> problem you're trying to solve but you don't explain anything about what
> the problem is or how your changes address it.
> 

Sorry for confusing.

The SGTL5000 is based on regulators and when it is disabled, there will be an error returns directly while the SGTL5000 codec is probing.
But on VF610 boards there has no regulators or needn't configure them, so the CONFIG_REGULATOR is disabled, and then the error is returned causing
to the SGTL5000 probe broken. 

Has I make it clear?

> > +#ifndef CONFIG_SND_SOC_FSL_SGTL5000_VF610
> >  static int ldo_regulator_register(struct snd_soc_codec *codec,
> 
> This is definitely broken, it won't work with multi-platform kernels, and
> I don't understand what this is supposed to do - what is the reason for
> making this change?
>

Yes, it is.

How about adding one node properties like : "regulator-exist", which will be controlled by platform data ?
