From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] sound: Fix empty menuconfig SND_ARM
Date: Sat, 30 Jul 2016 16:14:24 +0200
Message-ID: <87eg6byzzz.fsf@belgarion.home>
References: <20160730140019.20305-1-rosca.eugeniu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id 495772654DC
 for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2016 16:14:29 +0200 (CEST)
In-Reply-To: <20160730140019.20305-1-rosca.eugeniu@gmail.com> (Eugeniu Rosca's
 message of "Sat, 30 Jul 2016 16:00:19 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Eugeniu Rosca <rosca.eugeniu@gmail.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Eugeniu Rosca <roscaeugeniu@gmail.com> writes:

> commit 3c8f7710c1c4 ("ASoC: fix broken pxa SoC support") has removed
> the SND_ARM dependency from SND_PXA2XX_LIB and SND_PXA2XX_LIB_AC97,
> by moving these config entries outside of the "if SND_ARM ... endif"
> construct.
>
> However, by placing these 2 symbols right between the SND_ARM
> menuconfig definition and the first SND_ARM menu entry, the side
> effect is that the SND_ARM menu becomes empty and all the config
> entries caught between "if SND_ARM ... endif" no more belong to
> menuconfig SND_ARM, but to its parent (menuconfig SND).
>
> Fix this.
NAK.

The reason is that SND_PXA2XX_LIB is used outside of SND_ARM, see
sound/soc/pxa/Kconfig, SND_PXA2XX_SOC and co.

With you commit you're breaking every board relying on SND_PXA2XX_SOC but not
SND_ARM.

Cheers.

--
Robert
