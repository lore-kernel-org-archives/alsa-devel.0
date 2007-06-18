From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] Missing shutdown() vectors in ASoC
Date: Mon, 18 Jun 2007 13:15:51 +0100
Message-ID: <1182168951.26658.103.camel@localhost.localdomain>
References: <8d6898730706120004u31ddc1edj9e38e575b6aa5e53@mail.gmail.com>
	<8d6898730706120514na050b79j813ba93db23dc768@mail.gmail.com>
	<1181655900.29999.28.camel@a10072.wolfsonmicro.main>
	<8d6898730706180042v5f980486j73d783a04f9ddf5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 191A72432E
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 14:15:53 +0200 (CEST)
In-Reply-To: <8d6898730706180042v5f980486j73d783a04f9ddf5f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-06-18 at 13:12 +0530, Nobin Mathew wrote:
> Hi Liam,
> 
>  Can you please look at this mail Thread.
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-June/001436.html
> 

Atm, shutdown can be implemented in the current version of ASoC by
adding a shutdown callback to the "soc-audio" platform device in
soc-core.c. This callback could then call your codec/platform/machine
shutdown()'s.

Future versions (in dev-ppc branch atm) wont need this as shutdown can
be added to each driver in the regular Linux way.

Liam 
