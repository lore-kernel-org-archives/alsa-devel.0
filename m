From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap: Add basic audio support for
 Nokia RX-51/N900
Date: Wed, 5 May 2010 09:48:29 +0300
Message-ID: <20100505094829.ffec7939.jhnikula@gmail.com>
References: <1273037477-20626-1-git-send-email-jhnikula@gmail.com>
	<201005050930.22712.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B26E1037FF
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 08:47:17 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1547922ewy.17
	for <alsa-devel@alsa-project.org>; Tue, 04 May 2010 23:47:17 -0700 (PDT)
In-Reply-To: <201005050930.22712.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 May 2010 09:30:22 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Also, tlv320aic3x driver will try to set the defaults to the codec during the 
> i2c probing. I'm not sure, but if the reset line is low at that point it may 
> cause problems (reset line is low, and the reset sequence has not been 
> followed).
> Than later in the machine driver the chip is taken out from reset, which might 
> means, that the chip will be in reset state, so the initial configuration done 
> by the codec driver might be lost.
> 
> I think it would be better to handle the reset GPIO within the codec driver at 
> the end for proper operation.
> 
> What do you think?
> 
Thanks! Definitely reset handling is better to move to codec driver.
Especially important if starting to manage digital voltages there. I'll
cook up updated versions.


-- 
Jarkko
