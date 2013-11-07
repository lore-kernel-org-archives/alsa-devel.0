From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000
 codec driver about regulator.
Date: Thu, 7 Nov 2013 03:01:02 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828783E6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131106100305.GI11602@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A5D2650AF
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 04:01:06 +0100 (CET)
In-Reply-To: <20131106100305.GI11602@sirena.org.uk>
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

> > The SGTL5000 is based on regulators and when it is disabled, there
> > will be an error returns directly while the SGTL5000 codec is probing.
> 
> What makes you say this?  
>

>From the code:
File path: "sound/soc/codecs/sgtl5000.c"
==================
#ifdef CONFIG_REGULATOR
.....
#else
static int ldo_regulator_register(struct snd_soc_codec *codec,
                                struct regulator_init_data *init_data,
                                int voltage)
{
        dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
        return -EINVAL;
}

static int ldo_regulator_remove(struct snd_soc_codec *codec)
{
        return 0;
}
#endif
-------------------

sgtl5000_probe() -->
sgtl5000_enable_regulators() -->
sgtl5000_replace_vddd_with_ldo() -->
ldo_regulator_register().


> That's not how the regulator API works.  Have
> you actually seen any problems?

There are some regulator APIs implemented by SGTL5000 driver, not the regulator subsystem APIs.
