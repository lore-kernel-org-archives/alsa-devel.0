From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia ETI-B1
	board
Date: Tue, 30 Sep 2008 18:10:16 +0300
Message-ID: <bd7b27490809300810n77b82690j4ddedb0a0f7108ac@mail.gmail.com>
References: <48E23AE0.3040805@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.186])
	by alsa0.perex.cz (Postfix) with ESMTP id EC38D24552
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 17:10:17 +0200 (CEST)
Received: by gv-out-0910.google.com with SMTP id i36so29733gve.24
	for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2008 08:10:17 -0700 (PDT)
In-Reply-To: <48E23AE0.3040805@endrelia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Mandarino <fmandarino@endrelia.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

2008/9/30 Frank Mandarino <fmandarino@endrelia.com>

> See attached.
>
> --
> Frank Mandarino                                fmandarino(a)endrelia.com
> Endrelia Technologies Inc.
> Toronto, Ontario, Canada
>
> The ASoC machine drivers for this board were only provided as examples
> for the new AT91 ASoC platform driver.  Since the ETI-B1 board is
> proprietary and there are other AT91 ASoC machine drivers available,
> it makes sense to remove these drivers.
>
> Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
> ---
>  sound/soc/at91/Kconfig           |   27 ---
>  sound/soc/at91/Makefile          |    7 -
>  sound/soc/at91/eti_b1_bluecore.c |  284 -------------------------------
>  sound/soc/at91/eti_b1_wm8731.c   |  350
> --------------------------------------
>  4 files changed, 0 insertions(+), 668 deletions(-)
>
> Does it make sense to remove these yet? I didn't check different
architectures in asoc-dev but are there any other platform and machine
driver using multiple DAI links with real and "dummy" codec in ASoC v1? In
that sense these are nice reference implementations :-)


Jarkko
