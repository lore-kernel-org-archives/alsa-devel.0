From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v7 2/3] ASoC: da7210: Add support for line
 out and DAC
Date: Fri, 21 Oct 2011 17:02:38 +0530
Message-ID: <1319196758.24621.201.camel@matrix>
References: <1319121769.24621.130.camel@matrix>
	<CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
	<1319186260.24621.154.camel@matrix>
	<20111021090054.GF3513@opensource.wolfsonmicro.com>
	<1319190555.24621.160.camel@matrix>
	<20111021102429.GB4080@opensource.wolfsonmicro.com>
	<1319195132.24621.198.camel@matrix>
	<20111021111223.GD4080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 299442453A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 13:21:30 +0200 (CEST)
In-Reply-To: <20111021111223.GD4080@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "Girdwood, Liam" <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-21 at 12:12 +0100, Mark Brown wrote:
> On Fri, Oct 21, 2011 at 04:35:32PM +0530, Ashish Chavan wrote:
> 
> > Yes, your understanding is correct. Actually I acted bit lazy here by
> > not splitting, assuming that both patches are going to get merged
> > shortly. Do you think is it mandatory to do that? Or can I repost the
> > patch after just resolving merge issue?
> 
> It's better to refactor, it makes review much easier.
> 

OK. I am moving out line out and mic/aux related stuff from DAPM patch
and adding them in to other respective patches.
