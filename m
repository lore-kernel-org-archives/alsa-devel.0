From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v4 3/7] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Tue, 18 Oct 2011 18:30:28 +0530
Message-ID: <1318942828.13721.39.camel@matrix>
References: <1318670595.613.42.camel@matrix>
	<20111017214242.GD5200@opensource.wolfsonmicro.com>
	<1318938548.13721.23.camel@matrix>
	<20111018120841.GA28501@opensource.wolfsonmicro.com>
	<1318940943.13721.25.camel@matrix>
	<20111018123124.GC28501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id D7F642454E
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 14:49:32 +0200 (CEST)
In-Reply-To: <20111018123124.GC28501@opensource.wolfsonmicro.com>
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

> > > I don't see any conflict in the above?
> 
> > If I add these two, alsamixer and amixer shows only one of them (one
> > which is added first). Is that fine?
> 
> Eh?  One is a Volume, the other is a Switch.  Note that alsamixer does
> render the two stacked on top of each other in the UI.
> 

Yes, I guessed that earlier. Anyways I generally don't rely on alsamixer
and use amixer whereever possible. In amixer also, it shows only one
control, the one that I add first. If I change "Mic" to some thing else
like "MicM" or "Mic Mute", then it shows both controls.

BTW does amixer version have any significance here? I know my alsa-utils
are quite old (1.0.14)
