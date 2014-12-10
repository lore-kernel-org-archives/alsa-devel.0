From: Alexander Stein <alexanders83@web.de>
Subject: Re: [PATCH v2] ALSA: sound/atmel/ac97c.c: Add device
	tree support
Date: Wed, 10 Dec 2014 21:09:19 +0100
Message-ID: <2706097.m58HT92L1r@kongar>
References: <1418241578-17049-1-git-send-email-alexanders83@web.de>
 <5488A766.5070206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FDD326068C
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 21:09:27 +0100 (CET)
In-Reply-To: <5488A766.5070206@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Wednesday 10 December 2014, 21:04:54 wrote Lars-Peter Clausen:
> On 12/10/2014 08:59 PM, Alexander Stein wrote:
> > This adds device tree support for the AC97 controller. It uses the
> > soc-ac97link bindings, but actually only ac97-reset is used.
> >
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> > ---
> > Changes in v2:
> > * It now uses the soc-ac97link bindings (partly) instead of defining its own.
> >    This should ease the transition to ASoC once a new driver has been written.
> 
> Partly? How do they differ? And why do they differ? The devicetree should 
> describe the hardware, which I guess is the same in both cases.

The devicetree is defined the same way, but not all set properties are used.
The soc-ac97link binding defines 3 GPIOs where 2 are used in conjunction with different pinctl modes for different reset modes.
The rather old atmel_ac97c driver only supports reset per Reset-GPIO which is the 3rd one given in devicetree. Because this driver only
uses the 3rd GPIO I've written 'partly'.

Best regards,
Alexander
