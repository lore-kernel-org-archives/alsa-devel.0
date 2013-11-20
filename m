From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio
 machine driver.
Date: Wed, 20 Nov 2013 07:49:06 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828B38EC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101184008.GF2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 423E926165F
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 08:49:16 +0100 (CET)
In-Reply-To: <20131101184008.GF2493@sirena.org.uk>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Shawn Guo <Shawn.Guo@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Zhengxiong Jin <Jason.Jin@freescale.com>, "oskar@scara.com" <oskar@scara.com>, Fab
List-Id: alsa-devel@alsa-project.org


> > +	/* TODO: The SAI driver should figure this out for us */
> > +	switch (channels) {
> > +	case 2:
> > +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffc, 0xfffffffc, 2,
> 0);
> > +		break;
> > +	case 1:
> > +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffe, 0xfffffffe, 1,
> 0);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> Yes, it should - this code should probably just be copied straight into
> the SAI driver.  If we need to support other configurations we can do
> that later.
> 

Well, yes.
I have considered carefully about this, It maybe nicer to move this to SAI driver's .hw_params.



--
Best Regards,
Xiubo
