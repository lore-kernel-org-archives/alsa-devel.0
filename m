From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 11:58:31 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E7DD4@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<2C7D3DF36ADFFC479B44490D912B616705F69E7BAA@dlee07.ent.ti.com>
	<4A0D4B37.9020003@samsung.com>
	<200905151409.13619.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C07B224369
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 18:58:40 +0200 (CEST)
In-Reply-To: <200905151409.13619.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, ext Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> > > I think that interfaces can be enabled in DAI init as Mark suggests,
> > Yes, but i worry about whether this reg value can be changed on the 
> > fly or not.

> I believe this needs codec off/on

As per TRM, neither OPT_MODE nor sampling rates while affected filter
is running can't be change on-the-fly.

> > > but input/output should be enabled depending on whether 
> > > we are doing playback/capture or not, and then they should
> > > be handled in the codec driver.

> > Hmm, the twl4030 codec can do the voice communication at 
> > the same time while doing playback/capture, is not it?

> I think he means the bits in the OPTION register.
> The Option1 code toggles some of the bits in case of 4 channel mode.
> Same thing can be done for Option2 voice operation I think.

I meant that in option2, we can use I2S DAI and/or PCM DAI, not only
PCM/Voice DAI.
