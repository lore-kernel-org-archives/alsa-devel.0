From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Wed, 13 Oct 2010 10:33:07 +0100
Message-ID: <20101013093307.GG6424@rakim.wolfsonmicro.main>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
	<20100831110115.GC20849@rakim.wolfsonmicro.main>
	<AANLkTim9YRNtYuZeSJP2ffj1tiLjs=yL54XV9n+wTgDs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04B4C243BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:33:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim9YRNtYuZeSJP2ffj1tiLjs=yL54XV9n+wTgDs@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 05:00:52PM +0200, Manuel Lauss wrote:

> Here's a snippet of the kernel log with linked-list debugging enabled.
> Looks like the list issue Liam fixed ~1.5 years ago:
> ( see http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014757.html
> )

This should be fixed by Mika Westerberg's series posted as ASoC AC97
generic glue patches which I'm about to apply.
