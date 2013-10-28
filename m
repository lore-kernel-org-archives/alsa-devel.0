From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs
 about the sgt15000 codec.
Date: Mon, 28 Oct 2013 06:07:41 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286A3DC@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131018172814.GT2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E29F26109C
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 07:07:46 +0100 (CET)
In-Reply-To: <20131018172814.GT2443@sirena.org.uk>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "oskar@scara.com" <oskar@scara.>
List-Id: alsa-devel@alsa-project.org

> > @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct
> snd_soc_codec *codec,
> >  				struct regulator_init_data *init_data,
> >  				int voltage)
> >  {
> > +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> > +	return 0;
> > +#else
> >  	dev_err(codec->dev, "this setup needs regulator support in the
> kernel\n");
> >  	return -EINVAL;
> > +#endif
> >  }
> 
> If these systems don't actually need the internal regulator then should
> they not be trying to enable it?  
>
Yes, I think do not trying to enable the regulator is much better.

>Alternatively if it's OK to ignore this then why is this conditional in the board?
> 
The CONFIG_SND_SOC_FSL_SGTL5000 micro maybe confuse you and others.
And it should be CONFIG_SND_SOC_FSL_SGTL5000_VF610....
