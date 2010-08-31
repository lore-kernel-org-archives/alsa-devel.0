From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND v6 0/3] ASoC: Add iPAQ RX1950 support
Date: Tue, 31 Aug 2010 18:52:52 +0100
Message-ID: <20100831175252.GC30599@rakim.wolfsonmicro.main>
References: <1283156889-5544-1-git-send-email-anarsoul@gmail.com>
	<1283160241.3055.18.camel@odin>
	<20100831122559.GJ20849@rakim.wolfsonmicro.main>
	<201008312049.29591.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CF82103828
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 19:52:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008312049.29591.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: marek.vasut@gmail.com, alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 31, 2010 at 08:49:19PM +0300, Vasily Khoruzhick wrote:

> Mark, maybe merging third patch without Ben's comment is not good idea? It 
> touches arch/arm/plat-s3c24xx/devs.c

It's required for multi-component which is going in during the next
merge window and Ben is currently not very available.  If there's a
problem we can always fix it up later.
