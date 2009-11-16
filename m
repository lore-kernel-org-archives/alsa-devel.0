From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc-core: let suspend/resume not called if
 the card is not instantiated
Date: Mon, 16 Nov 2009 17:04:50 +0000
Message-ID: <20091116170450.GC29365@rakim.wolfsonmicro.main>
References: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
	<20091113133824.GD21516@rakim.wolfsonmicro.main>
	<3c17e3570911130656v662dccej7d6c67e7eaa65b65@mail.gmail.com>
	<20091113150224.GA23607@rakim.wolfsonmicro.main>
	<3c17e3570911130729xab6a443t5b257c2699dfa169@mail.gmail.com>
	<20091113170459.GB23607@rakim.wolfsonmicro.main>
	<3c17e3570911131646h62cf59c2q765a5aca6f626ad4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90ACB1038EA
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 18:04:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3570911131646h62cf59c2q765a5aca6f626ad4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 14, 2009 at 08:46:05AM +0800, Barry Song wrote:

> Then do you think it is workable to find the dai in dai_list before
> calling its suspend/resume? My original plan was checking the
> existence of DAI in dai_list, if DAI doesn't exist, don't call its PM

I think so, yes.

> entries.  Then I found card->instantiated, I moved to check it.
> If you have better plan for fixing this problem, I can wait and keep
> this fix locally.

I don't have any immediate plan to work on this, like I say it's only
really an issue in development.
