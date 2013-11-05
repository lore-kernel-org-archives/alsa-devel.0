From: Li Xiubo <B47053@freescale.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio
 machine driver.
Date: Tue, 5 Nov 2013 03:26:16 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828754AB@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101101750.GB16492@curry>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id DAAE5261A0F
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 04:26:22 +0100 (CET)
In-Reply-To: <20131101101750.GB16492@curry>
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
To: Oskar Schirmer <oskar@scara.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, Shawn Guo <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Guangyu Chen <B42378@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Fabio
List-Id: alsa-devel@alsa-project.org


=
> [...]
> > diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c b/sound/soc/fsl/fsl-
> sgtl5000-vf610.c
> > new file mode 100644
> > index 0000000..f535b42
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> > @@ -0,0 +1,208 @@
> > +/*
> > + * Freeacale ALSA SoC Audio using SGT1500 as codec.
>           ^                             ^   ^
>      "Freescale"                    "SGTL5000"
> 
Yes. See the next version.
