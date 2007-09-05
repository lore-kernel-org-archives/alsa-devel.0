From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] sgalaxy: checkpatch fixes
Date: Wed, 05 Sep 2007 14:23:09 +0200
Message-ID: <46DE9FAD.8020909@gmail.com>
References: <20070904234925.d96c021c.krzysztof.h1@wp.pl>	<46DDDB21.9000003@gmail.com>
	<20070905064758.9965e781.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C0C810396D
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 14:29:35 +0200 (CEST)
In-Reply-To: <20070905064758.9965e781.krzysztof.h1@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/05/2007 06:47 AM, Krzysztof Helt wrote:

> I about acquring the SG Waverider card. I saw your driver and thought 
> about asking you to cooperate to merge you driver into the sgalaxy or
> polish the driver more. You are just one step before me.

Ah, recently grabbed a Waverider as well. I now have some 15 Sound Galaxy 
models I believe which is partly why testing them all is taking too 
much/long ;-)

Will make time now though.

> Yes, but as I am about merging your patch into the sgalaxy
> (my first idea).
> I want to avoid situation with patches being rejected due
>  to coding style problem in context lines.

Nah, really the only "important" thing is (while you're there) to do the "if 
((err = ))" breaking -- noone here is religious about the rest.

But, well, forgetting all about sgalaxy.c makes as much sense. The new 
driver already support more models anyway (the ones without EEPROMs).

Rene.
