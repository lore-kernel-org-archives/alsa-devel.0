From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Fri, 27 Aug 2010 20:14:30 +0100
Message-ID: <20100827191428.GB6666@opensource.wolfsonmicro.com>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
	<1282913484.3025.25.camel@odin>
	<1365302F-4C5D-4075-8D38-94DEEEF2583E@opensource.wolfsonmicro.com>
	<AANLkTikr3rpij1FuKAQrwR0U8kpJUnKzfVJEzeYeGEsk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B2321038A6
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 21:14:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikr3rpij1FuKAQrwR0U8kpJUnKzfVJEzeYeGEsk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ian Lartey <ian@opensource.wolfsonmicro.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 27, 2010 at 03:32:16PM +0200, Manuel Lauss wrote:

> I've found another AC97-related issue on another board (DB1300):
> With AC97 enabled, the device warning doesn't appear but my ethernet
> is gone instead:

This seems like some sort of pin mux issue or something driver specific?
I'm having a hard time thinking of anything ASoC could do that'd cause
this, but I don't know how the two subsystems might interact on this
system or au1x in general.

In any case I'm tempted to apply what we've got here since while there
are still issues it's all au1x (and seemingly AC97) specific and it
improves the situation for that platform - we can continue to work on
the remaining problems without re-reviewing this code again.  Liam, does
that seem reasonable?
