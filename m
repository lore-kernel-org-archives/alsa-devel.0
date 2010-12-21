From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sh: fsi: modify improper dependent
Date: Tue, 21 Dec 2010 23:23:25 +0000
Message-ID: <20101221232325.GA10081@opensource.wolfsonmicro.com>
References: <w3p8vzlntmb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30B2E103A6B
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 00:23:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3p8vzlntmb.wl%kuninori.morimoto.gx@renesas.com>
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

On Mon, Dec 20, 2010 at 10:03:13AM +0900, Kuninori Morimoto wrote:
> FSI-AK4642 and FSI-DA7210 are depend on I2C, not I2C_SH_MOBILE
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.

I'm assuming that this is because these are actually generic drivers for
multiple boards rather than a specific board?  It'd be good if the
changelog were more clear on this.
