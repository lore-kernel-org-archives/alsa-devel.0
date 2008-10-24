From: Liam Girdwood <lrg@kernel.org>
Subject: Re: ASoC: pxa2xx-ssp
Date: Fri, 24 Oct 2008 16:54:38 +0100
Message-ID: <1224863678.28382.54.camel@dell-desktop.example.com>
References: <1224809675.8330.4.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 11F9024570
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 17:55:01 +0200 (CEST)
In-Reply-To: <1224809675.8330.4.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-10-23 at 22:54 -0200, Daniel Ribeiro wrote:
> Hi!
> 
> What is needed for [0] to be accepted on mainline linux?
> 
> [0]http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=blob;f=sound/soc/pxa/pxa2xx-ssp.c;h=6b1baeece184e990c4254e2f43495013d4562c95;hb=e4d89cdd854b4a40c963adf434d261070c67b6bb
> 

When I last worked on this it was in need of updates for SSP register
IO, clk API and more testing. It has the IO and clk stuff now.

Does this code work well on your platform/board ?

If so, I guess we could scratch off the more testing part and consider
it for the next merge window. Iirc it was also waiting on some pxa
dependencies going upstream, so it may wait a little longer.

I'm sure it's on Mark's long todo list....

Liam 
