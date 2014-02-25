From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Mark DC offset control
	registers volatile
Date: Tue, 25 Feb 2014 16:13:02 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376BAD41AF@SW-EX-MBX01.diasemi.com>
References: <1393210853-32246-1-git-send-email-broonie@kernel.org>
 <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
 <20140224124230.GF25940@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376BAD405D@SW-EX-MBX01.diasemi.com>
 <20140225012138.GK25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 554AB265620
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 17:13:05 +0100 (CET)
In-Reply-To: <20140225012138.GK25940@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 25 Feb 2014 01:22:04 +0000, Mark Brown wrote:

> That breaks suspend and resume without further work - for suspend and
> resume we generally rely on restoring the register cache to restore the
> current settings but if a register is volatile it won't be cached so
> will go back to the hardware defaults after suspend.  The ability to
> avoid I2C traffic is partly just a nice side effect (though it was
> needed on devices that don't have readback), the main thing these days
> is that controls get efficient suspend and resume handling for free.

Yes, true. Good point. 

> 
> Refactoring the offset correction to happen once on startup would solve
> the issue since the cache could just be bypassed, though you are likely
> to find that there is some run to run variation for the callibration due
> to effects like thermal variation and simple measurement errors.  Still,
> the effects are typically very small.

I have to agree, the variation won't be great. If it were then you'd see
problems for example when keeping a device awake for prolonged periods and
during fluctuations in temperature. As far as I'm aware issues like this have
not been experienced with this device so I think it's safe to make this a one
time thing at startup.
