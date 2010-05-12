From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 5/6] kirkwood: Add i2s support
Date: Wed, 12 May 2010 11:54:24 +0100
Message-ID: <20100512105424.GH4330@rakim.wolfsonmicro.main>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.475198903@mandriva.com>
	<20100512102419.GF4330@rakim.wolfsonmicro.main>
	<AANLkTilU65zldd85iqsxGniC6VZkwYqcsBxXsLHDRcQv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3840124376
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 12:54:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilU65zldd85iqsxGniC6VZkwYqcsBxXsLHDRcQv@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: apatard@mandriva.com, alsa-devel@alsa-project.org, tbm@cyrius.com, saeed@marvell.com, nico@fluxnic.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 01:48:57PM +0300, saeed bishara wrote:

Please don't top post.

> 	some of the dma stuff handled by the i2s! For example the i2s trigger
> function actually enables the dma, this should be moved to the dma
> driver. Also, the playback and capture trigger funtions looks alike

There's no real problem with doing this from an ASoC point of view, both
devices are part of the same chip so they're free to peer into each
other's implementations as much as makes sense for that hardware.
