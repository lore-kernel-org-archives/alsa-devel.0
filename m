From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Fix build error in
 sound/soc/kirkwood/kirkwood-i2s.c
Date: Wed, 28 Dec 2011 11:37:46 +0000
Message-ID: <20111228113745.GD24405@opensource.wolfsonmicro.com>
References: <1325059522.18468.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3264D244CB
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 12:37:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325059522.18468.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 28, 2011 at 04:05:22PM +0800, Axel Lin wrote:
> Since commit db33f4de "ARM: Orion: Remove address map info from all platform data structures",
> the dram is removed from struct kirkwood_asoc_platform_data.

Applied, thanks.
