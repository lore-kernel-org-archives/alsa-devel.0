From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for spi regmap
Date: Wed, 21 Mar 2012 22:35:53 +0530
Message-ID: <1332349553.21744.33.camel@matrix>
References: <1332345170.21744.10.camel@matrix>
	<20120321155635.GE3226@opensource.wolfsonmicro.com>
	<1332348080.21744.26.camel@matrix>
	<20120321163811.GH3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe002.messaging.microsoft.com [216.32.180.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FB631044A4
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 17:54:06 +0100 (CET)
In-Reply-To: <20120321163811.GH3226@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


> > Actually I don't have enough details about the problem that you
> > mentioned with this. I am waiting for inputs from some body else. Can
> 
> ...and didn't bother asking any questions so it's unlikely anyone will
> say anything...

No, actually it's not like that. You mentioned that the sequence should
be changed, which will fix an issue that the driver has with suspend and
resume. I asked other users of this driver about the issue and waiting
for their feedback. I just wanted to have clear picture about the issue
before I commit any change there. Just to make sure that only changing
of sequence is enough or some thing extra need to be done.

> 
> > you please elaborate the problem if you have details? so that I can
> > correct it.
> 
> What is unclear in the previous feedback?  You should be converting this
> to use a regmap patch...

OK, thanks!
