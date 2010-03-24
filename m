From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] ASoC: fsi: FSI2 device support
Date: Wed, 24 Mar 2010 11:19:15 +0000
Message-ID: <20100324111914.GB5831@opensource.wolfsonmicro.com>
References: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADDBC1037F5
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 12:19:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 24, 2010 at 03:26:55PM +0900, Kuninori Morimoto wrote:

> These patches are FSI2 support

> Kuninori Morimoto (4):
>       ASoC: fsi: ensures process inside master lock
>       ASoC: fsi: Add FIFO size calculate
>       ASoC: fsi: IRQ related process had be united
>       ASoC: fsi: Add FSI2 device support

Applied patches 1 and 3, patch 4 was OK but won't apply without the FIFO
size change (and presumably depends on that anyway).  As Liam said it'd
be good if you could check what's going on with these old dates.

Thanks.
