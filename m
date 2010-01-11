From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
 Codec support for DM365 EVM
Date: Mon, 11 Jan 2010 09:53:43 -0600
Message-ID: <4B4B4987.1080507@ridgerun.com>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
	<20100108193720.GA3088@sirena.org.uk>
	<4B4B3F97.8060508@ridgerun.com>
	<20100111153458.GA2661@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 8009A103822
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 16:54:28 +0100 (CET)
In-Reply-To: <20100111153458.GA2661@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Jan 11, 2010 at 09:11:19AM -0600, Miguel Aguilar wrote:
>> Mark Brown wrote:
> 
>>>> Can you check the part of this patch related to registering both
>>>> codecs AIC3x and the voice codec?
> 
>>> Like I say that all looks fine to me but I can't really check if the
>>> DaVinci code is idiomatic.
> 
>> Is there any way to tell alsamixer to use the controls of one
>> subdevice or the other?
> 
> Not from the arch/arm stuff, but that's a machine driver issue anyway.
> If you really only want to use a single device then just don't hook up
> the other device in the machine driver and it'll never appear.

Do you think that I still using the approach of having both codecs registered in 
the same kernel? or should I get back to the initial approach of selecting the 
wanted codec from the configuration menu?
