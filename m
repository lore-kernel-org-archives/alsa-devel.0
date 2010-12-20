From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8580: Debug interface index
Date: Mon, 20 Dec 2010 12:34:04 +0000
Message-ID: <20101220123403.GD26706@rakim.wolfsonmicro.main>
References: <1291340065-16897-1-git-send-email-jassi.brar@samsung.com>
	<1291376076.3271.32.camel@odin>
	<20101203163932.GX859@rakim.wolfsonmicro.main>
	<AANLkTim+_FVqeat+X1Bf-gBWTfs1VyrQsT14_hHA6LGi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 497B724572
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 13:34:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTim+_FVqeat+X1Bf-gBWTfs1VyrQsT14_hHA6LGi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 05, 2010 at 12:26:43AM +0900, Jassi Brar wrote:

> Just for the sake of consistency.
> We moved to using driver's id since the commit
> 'ASoC: multi-component - ASoC Multi-Component Support'.

That's not actually true - the ID is initialised by default from the
driver, but the referenced copy is in the DAI runtime structure.
