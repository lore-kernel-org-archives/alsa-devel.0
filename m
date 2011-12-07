From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Include linux/module.h for
	smdk2443_wm9710
Date: Thu, 8 Dec 2011 00:12:25 +0800
Message-ID: <20111207161223.GE22355@opensource.wolfsonmicro.com>
References: <1323251539.27710.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFCF224545
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 17:13:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323251539.27710.5.camel@phoenix>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Graeme Gregory <graeme.gregory@wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 07, 2011 at 05:52:19PM +0800, Axel Lin wrote:
> Include linux/module.h to fix below build error:
>   CC      sound/soc/samsung/smdk2443_wm9710.o
> sound/soc/samsung/smdk2443_wm9710.c:64: error: expected declaration specifiers or '...' before string constant

Applied, thanks.
