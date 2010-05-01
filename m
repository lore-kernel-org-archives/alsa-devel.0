From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] Merge es1688 and es968 drivers
Date: Sat, 1 May 2010 22:54:50 +0200
Message-ID: <20100501225450.56143e22.krzysztof.h1@poczta.fm>
References: <20100501155257.b7284b9b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpo.poczta.interia.pl (smtpo.poczta.interia.pl
	[217.74.65.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BF451037F7
	for <alsa-devel@alsa-project.org>;
	Sat,  1 May 2010 22:54:08 +0200 (CEST)
In-Reply-To: <20100501155257.b7284b9b.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 1 May 2010 15:52:57 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The ESS ES968 chip is nothing more then a PnP companion
> for non-PnP audio chips. It was paired with non-PnP ESS' chips:
> ES688 and ES1688. The ESS' audio chips are handled by the es1688
> driver in native mode. The PnP cards are handled by the ES968
> driver in SB compatible mode.
> 
> Move the ES968 chip handling to the es1688 driver so the driver
> can handle both PnP and non-PnP cards. The es968 is removed.
> 
> Also, a new PnP id is added for the card I acquired (the change
> was tested on this card).
> 

Takashi, please drop this patch. It breaks compilation of GUS driver.

I'll prepare a new set and make the change to es1688-lib a separate patch.

Regards,
Krzysztof

----------------------------------------------------------------------
Szukasz pracy? Zobacz ciekawe oferty w Twoim miescie
Sprawdz >>> http://linkint.pl/f26b2
