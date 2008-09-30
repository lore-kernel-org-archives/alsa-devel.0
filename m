From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia ETI-B1
 board
Date: Tue, 30 Sep 2008 11:39:09 -0400
Message-ID: <48E2481D.6030208@endrelia.com>
References: <48E23AE0.3040805@endrelia.com>
	<bd7b27490809300810n77b82690j4ddedb0a0f7108ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.teksavvy.com
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DDA21037EB
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 17:39:11 +0200 (CEST)
In-Reply-To: <bd7b27490809300810n77b82690j4ddedb0a0f7108ac@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org



Jarkko Nikula wrote:
> 2008/9/30 Frank Mandarino <fmandarino@endrelia.com
> <mailto:fmandarino@endrelia.com>>
> 
>     See attached.
> 
>     --
>     Frank Mandarino                              
>      fmandarino(a)endrelia.com <http://endrelia.com>
>     Endrelia Technologies Inc.
>     Toronto, Ontario, Canada
> 
>     The ASoC machine drivers for this board were only provided as examples
>     for the new AT91 ASoC platform driver.  Since the ETI-B1 board is
>     proprietary and there are other AT91 ASoC machine drivers available,
>     it makes sense to remove these drivers.
> 
>     Signed-off-by: Frank Mandarino <fmandarino@endrelia.com
>     <mailto:fmandarino@endrelia.com>>
>     ---
>      sound/soc/at91/Kconfig           |   27 ---
>      sound/soc/at91/Makefile          |    7 -
>      sound/soc/at91/eti_b1_bluecore.c |  284 -------------------------------
>      sound/soc/at91/eti_b1_wm8731.c   |  350
>     --------------------------------------
>      4 files changed, 0 insertions(+), 668 deletions(-)
> 
> Does it make sense to remove these yet? I didn't check different
> architectures in asoc-dev but are there any other platform and machine
> driver using multiple DAI links with real and "dummy" codec in ASoC v1?
> In that sense these are nice reference implementations :-)
> 
> 
> Jarkko

My reasons for wanting it removed are that 1) it only works on our
proprietary board, and 2) I don't have time to maintain it as changes
are made to ASoC.

If it is still useful for documentation purposes, then perhaps it should
be moved to a file in Documentation/sound/alsa/soc.  But then again,
someone will have maintain the documentation.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
