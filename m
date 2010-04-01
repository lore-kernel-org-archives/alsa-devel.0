From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa: add namespace on ssp
Date: Thu, 1 Apr 2010 09:54:20 +0100
Message-ID: <20100401085419.GC32025@rakim.wolfsonmicro.main>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
	<y2pf17812d71004010033x5b3e789foa782dd6cd8af63ef@mail.gmail.com>
	<g2w771cded01004010045n56803dfbge90d3a70a731977d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2AAE244CD
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 10:54:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g2w771cded01004010045n56803dfbge90d3a70a731977d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 01, 2010 at 03:45:03PM +0800, Haojian Zhuang wrote:
> On Thu, Apr 1, 2010 at 3:33 PM, Eric Miao <eric.y.miao@gmail.com> wrote:

> > This is not necessary, provided that those functions are static already.
> > Unless this driver is going to support a different SSP, in which case a
> > separate driver is needed then.

> > What's the real motivation behind this?

> It's the request from Mark. Both ssp_ and pxa_ssp_ prefix exist in
> pxa-ssp.c. From the view of naming space, it's not align.

Just to be clear, the main issue was that subsequent patches in the
series made the symbols exported at which point they end up in the
global namespace and the potential confusion is an issue.
