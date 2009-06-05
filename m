From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix possibly incorrect offset in
	wm97xx-core
Date: Fri, 5 Jun 2009 09:51:25 +0100
Message-ID: <20090605085125.GC17158@rakim.wolfsonmicro.main>
References: <200906032344.37640.marek.vasut@gmail.com>
	<200906041159.02380.marek.vasut@gmail.com>
	<20090604110609.GH6983@rakim.wolfsonmicro.main>
	<200906042205.48277.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E30124619
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 10:51:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906042205.48277.marek.vasut@gmail.com>
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

On Thu, Jun 04, 2009 at 10:05:48PM +0200, Marek Vasut wrote:

> Actually, after discussing this on IRC with you, I come with the following 
> patch (it should be applied on top of the mainstone accelerated touch patch 
> which follows).

Yes, something along these lines would be a good fix.  As discussed let
me get my test system up and running to have a look at what's going on
here before we do anything - should be sometime next week.
