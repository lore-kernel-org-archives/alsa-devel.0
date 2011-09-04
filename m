From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Remove unused mutex
Date: Sun, 4 Sep 2011 07:10:15 -0700
Message-ID: <20110904141015.GB3668@opensource.wolfsonmicro.com>
References: <1315140751.8673.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 740C4244AA
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Sep 2011 16:40:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315140751.8673.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 04, 2011 at 08:52:31PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/alc5623.c |    2 --
>  sound/soc/codecs/wm9090.c  |    2 --

This has already been done for wm9090, can you resubmit with just the
alc5623 change please?
