From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 3/6] ASoC: max9867: Drop probe function
Date: Thu, 1 Mar 2018 21:06:18 +0100
Message-ID: <20180301200618.GB2304@lenoch>
References: <20180301141843.GB30722@lenoch> <20180301142027.GE30722@lenoch>
 <20180301175654.GF12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id B0AC2267C11
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:06:24 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992827AbeCAUGYNYRIL (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 21:06:24 +0100
Content-Disposition: inline
In-Reply-To: <20180301175654.GF12864@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 01, 2018 at 05:56:54PM +0000, Mark Brown wrote:
> On Thu, Mar 01, 2018 at 03:20:27PM +0100, Ladislav Michl wrote:
> > Driver probe function has no use and can be deleted.
> 
> This doesn't apply against current code, please check and resend.

It was generated and tested against next-20180301. Which version do
you want me to generate against? Based on 4.16-rc1 it'll fail to
merge later.

Thank you,
	ladis
