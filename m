From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: pxa: add I2C dependencies as needed
Date: Tue, 03 Jun 2014 23:12:09 +0200
Message-ID: <87k38xg0k6.fsf@free.fr>
References: <46560700.2S4p0nUZl8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 by alsa0.perex.cz (Postfix) with ESMTP id D7ECE2655A1
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 23:12:15 +0200 (CEST)
In-Reply-To: <46560700.2S4p0nUZl8@wuerfel> (Arnd Bergmann's message of "Tue,
 03 Jun 2014 20:38:27 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Arnd Bergmann <arnd@arndb.de> writes:

> We have in the past added 'depends on I2C' for some of the PXA boards
> after hitting randconfig build bugs. I have seens a couple of new
> bugs in this area during the linux-next cycle for 3.16, after it
> became possible to build some more PXA machines with I2C disabled.
>
> To shut this up for good, this adds the dependency to every board
> that uses I2C as the interface to the codec. I have gone through
> all board files and verified that they all either use AC97 or
> I2C, and this annotates the latter. Some of these already enable
> I2C from mach-pxa/Kconfig, but since that can change it's better
> to be explicit here.
>
> The link error that can result otherwise happens when CONFIG_I2C
> is set to 'm' and the codec driver is built-in as a result of being
> selected by the platform specific glue.

Hi Arnd,

Any reason SND_PXA2XX_SOC_MIOA701 escaped ? The board is PXA based, and its
codec wm9713 is I2C based, and relies on AC97.

Cheers.

-- 
Robert
