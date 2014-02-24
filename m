From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Mark DC offset control
	registers volatile
Date: Mon, 24 Feb 2014 13:57:53 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376BAD405D@SW-EX-MBX01.diasemi.com>
References: <1393210853-32246-1-git-send-email-broonie@kernel.org>
 <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
 <20140224124230.GF25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.165])
 by alsa0.perex.cz (Postfix) with ESMTP id F355726534B
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 14:57:55 +0100 (CET)
In-Reply-To: <20140224124230.GF25940@sirena.org.uk>
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

On Mon, 24 Feb 2014 12:43:51 +0000, Mark Brown wrote:

> > Having looked over the driver again, can you include the following
> > registers as well:
> 
> > DA732X_REG_HPL
> > DA732X_REG_HPR
> 
> I did notice those.  However they are a bit more fun since they have
> some non-volatile fields in them which are also used for control.  I
> *suspect* that a lot of the time it'll be possible to get away with just
> caching the first read but it needs further study - often with these
> things the basic offset is constant in a given system so the sign may
> well be right all the time.  That's just a guess, though, and may not
> actually hold at which point a bit more attention might be needed.

The field DA732X_HP_OUT_COMPO is the only volatile field for those two
registers. Having looked at this some more, I believe the offset_cancellation
need only be done at Codec initialisation, and doesn't need to be done every time
the system resumes. Moving to a one time run may make dealing with this easier,
if we're to do something clever. However, In terms of control, really only the
MUTE, OUT_EN and OUT_HIZ_EN fields will be used with some frequency, in these
registers, and generally they will be writes which will likely cause I2C traffic
anyway. I'd be tempted to keep it simple and just make those registers volatile,
then you know it will work as expected, at least for the time being until a
better solution presents itself.
