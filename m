From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: pxa/raumfeld: adopt new
 snd_soc_dai_set_pll() API
Date: Mon, 30 Nov 2009 13:34:51 +0000
Message-ID: <20091130133451.GA18944@rakim.wolfsonmicro.main>
References: <1259575964-32251-1-git-send-email-daniel@caiaq.de>
	<20091130125543.GE10968@rakim.wolfsonmicro.main>
	<20091130130637.GH14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E1E0103836
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 14:34:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091130130637.GH14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 02:06:37PM +0100, Daniel Mack wrote:

> Ah, right. The pxa-ssp code doesn't pay attention to either argument,
> hence I didn't notice. Thanks!

OK.

> Daniel
> 
> 
> From fdc23d80fa7a3b2aa76e05ee9fbd85dea0f647d8 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Mon, 30 Nov 2009 11:08:17 +0100
> Subject: [PATCH] ALSA: ASoc: pxa/raumfeld: adopt new snd_soc_dai_set_pll() API

Applied, thanks.

Can I please remind you again to send patches in the format documented
in Documentation/SubmittingPatches - when you include lots of text
before the actual patch it's not possible to use standard tools like git
am to apply without post-processing since all that text ends up in the
commit log, and things like From: and the subject line don't get picked
up either.
