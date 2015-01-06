From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] sound: soc: atmel sam9g20_wm8731: remove
	useless include
Date: Tue, 6 Jan 2015 12:15:46 +0100
Message-ID: <20150106111546.GN4194@piout.net>
References: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54ABB574.30602@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CD1C2604BF
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 12:15:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54ABB574.30602@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Bo,

On 06/01/2015 at 18:14:12 +0800, Bo Shen wrote :
> >
> >  #include <asm/mach-types.h>
> 
> Btw, do you consider to remove this also?
> 

I just sent a patch for that. Feel free to squash both.

> >-#include <mach/hardware.h>
> >
> >  #include "../codecs/wm8731.h"
> >  #include "atmel-pcm.h"
> >

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
