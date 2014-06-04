From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: add I2C dependencies as needed
Date: Wed, 04 Jun 2014 21:40:09 +0200
Message-ID: <87fvjkfopy.fsf@free.fr>
References: <46560700.2S4p0nUZl8@wuerfel> <87k38xg0k6.fsf@free.fr>
 <20140603215944.GB2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D4C265162
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 21:40:18 +0200 (CEST)
In-Reply-To: <20140603215944.GB2520@sirena.org.uk> (Mark Brown's message of
 "Tue, 3 Jun 2014 22:59:44 +0100")
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

>> Any reason SND_PXA2XX_SOC_MIOA701 escaped ? The board is PXA based, and its
>> codec wm9713 is I2C based, and relies on AC97.
>
> The WM9713 is AC'97 only, there's no I2C interface there.
Gees, you're right. I was remembering the registers, and that made my think of
I2C registers, like in Maxim regulators.

My bad, you're right, no I2C.

Cheers.

-- 
Robert
