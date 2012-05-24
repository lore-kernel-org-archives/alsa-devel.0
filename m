From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Thu, 24 May 2012 11:33:07 +0100
Message-ID: <20120524103306.GI5361@opensource.wolfsonmicro.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
	<4FBC8C11.6020602@stericsson.com>
	<20120523174009.GE4064@opensource.wolfsonmicro.com>
	<4FBDD365.7080304@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50944103EDF
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 12:41:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FBDD365.7080304@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 24, 2012 at 08:21:25AM +0200, Ola Lilja wrote:

> Well, yes. One of the control enables/disables the ability to use another
> charge-pump voltage when the signal gets over a certain threshold. The other
> parameters are tuning of this theshold and responsiveness. This feature can be
> changed during runtime depending of quality vs. powersaving needs.

Right, this is what I had expected except usually the consequence of the
charge pump voltage failing to adapt rapidly enough is clipping which is
normally considered unacceptably bad in any situation so with most
devices there isn't much opportunity to tune the responsiveness.  You do
see on/off controls that get used for configurations the device can't
handle for some reason but the responsiveness parameters that work are
normally a static property of the device.

I guess you might be able to do something slightly more aggressive for
voice perhaps...  Anyway, like I say the main thing here is surprise at
seeing these things user tunable.
