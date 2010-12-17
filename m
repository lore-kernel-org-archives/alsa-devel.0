From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: sh: fsi: Add over/under run
	counter
Date: Fri, 17 Dec 2010 12:59:05 +0000
Message-ID: <20101217125904.GG31453@rakim.wolfsonmicro.main>
References: <w3pr5dhgij9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9324624179
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 13:59:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3pr5dhgij9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 17, 2010 at 12:55:22PM +0900, Kuninori Morimoto wrote:
> Current FSI driver had printed under/over run error
> if status register have its error bit.
> But runtime print cause the next error
> because print out is slow.
> This patch add error counter and print error when sound stop

Applied, thanks.
