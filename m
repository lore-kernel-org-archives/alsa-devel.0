From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 2/4] ASoC: add ep93xx AC97 audio driver
Date: Mon, 11 Oct 2010 15:17:21 +0300
Message-ID: <20101011121721.GG27142@gw.healthdatacare.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<b0202066df3bb9732fbecca627d0149165905a95.1286707213.git.mika.westerberg@iki.fi>
	<20101011094717.GA9231@rakim.wolfsonmicro.main>
	<20101011100742.GE27142@gw.healthdatacare.com>
	<20101011104335.GC9231@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E115C103A9D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 14:17:25 +0200 (CEST)
Received: by bwz18 with SMTP id 18so2056608bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 05:17:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011104335.GC9231@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, martinwguy@gmail.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 11:43:36AM +0100, Mark Brown wrote:
> 
> You're doing INIT_COMPLETION every single time you use it - is that
> really required?

Ah, now I get it.

It seems that while I only use complete() there is no need for
calling INIT_COMPLETION() everytime. Will remove from the next
version.

> > Yeah, sorry about that. I had the impression that using the latest
> > mainline would be right thing to do :( I will base the next version
> > against that tree pointed by Jassi.
> 
> Latest mainline means you're missing any changes that are ready for the
> next merge window, once code has gone to Linus it's bugfix only outside
> of the merge window so actual development happens in -next.

Understood, thanks.

MW
