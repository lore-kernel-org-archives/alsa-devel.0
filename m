From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Wed, 20 Nov 2013 04:16:09 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828AF608@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104043338.GA2345@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F828AE980@039-SN2MPN1-012.039d.mgd.msft.net>
 <20131120033745.GD11009@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id B854A261A24
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 05:16:15 +0100 (CET)
In-Reply-To: <20131120033745.GD11009@MrMyself>
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
To: Guangyu Chen <guangyu.chen@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Shawn Guo <Shawn.Guo@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhengxiong Jin <Jason.Jin@freescale.com>
List-Id: alsa-devel@alsa-project.org

> > > The udelay just doesn't make sense to what you are talking about.
> > >
> > > Does SAI really need 10us delay between two register-updating?
> > >
> >
> > No, this is not must be.
> 
> Then you should explain in your comments why you really put it here or
> just drop it if it's just a mistake.
> 

The udelay will be removed then.


> > > ISSUE 2: There are two cases listed in 'Synchronous mode'.
> > > 	 However, your driver doesn't take care of them.
> > > 	 The SAI's synchronous mode looks like more flexible
> > > 	 than SSI's. The driver needs to be more sophisticated
> > > 	 so that it can handle multiple cases when TX/RX clocks
> > > 	 are controlled by either TX or RX, and surely, the
> > > 	 asynchronous mode as well.
> > >
> >
> > Because in Vybrid the transmitter bit clock and frame sync are to be
> > used by both the transmitter and receiver, and only this case can be
> > used here, so now I only handle this case.
> 
> It's fairly okay if adding explicit comments to indicate that currently
> the driver only supports its Synchronous mode with clocks controlled by
> TX only.
> 

Just think, on other platforms maybe only the Rx's clock is available.
Thus I think there should be one DT property to control this, and then the SAI driver can be more flexible.

Or could you give me some more practical ideas ?

--
Best Regards,
Xiubo
