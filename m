From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sh: FSI: Remove DMA support
Date: Fri, 30 Oct 2009 10:38:49 +0000
Message-ID: <20091030103849.GA5345@rakim.wolfsonmicro.main>
References: <u8wetpos0.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC41A244D5
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 11:38:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <u8wetpos0.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2009 at 12:02:39PM +0900, Kuninori Morimoto wrote:
> SuperH FSI device have the hardware limitation to use DMA.
> If DMA is used, LCD output will be broken.
> Maybe there are some solution. But I don't know how to do it now.
> This patch remove DMA support and use soft transfer.

Oh dear.  I suspect it may be possible to resolve this by configuring
the priorities of the various devices on the bus so that the display
hardware gets priority but this is a reasonable approach for now.

I've applied both patches - thanks.
