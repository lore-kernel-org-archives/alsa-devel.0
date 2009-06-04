From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix possibly incorrect offset in
	wm97xx-core
Date: Thu, 4 Jun 2009 12:06:09 +0100
Message-ID: <20090604110609.GH6983@rakim.wolfsonmicro.main>
References: <200906032344.37640.marek.vasut@gmail.com>
	<20090604084602.GA6983@rakim.wolfsonmicro.main>
	<200906041159.02380.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B09B0103929
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 13:06:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906041159.02380.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 11:59:02AM +0200, Marek Vasut wrote:
> On Thursday 04 of June 2009 10:46:03 Mark Brown wrote:

> > Nack, the existing code reflects the behaviour of the silicon.

> The patch above reflects the behavior of my silicon (WM9712G) :-/

Could you expand on the behaviour you're seeing, please?  Also, what are
the full markings on the chip?
