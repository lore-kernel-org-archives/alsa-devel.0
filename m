From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Fix sync reg_cache with the
 hardware in wm8990_resume
Date: Wed, 5 Oct 2011 11:21:22 +0100
Message-ID: <20111005102122.GB9783@opensource.wolfsonmicro.com>
References: <1317809809.2374.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFDAB24681
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 12:21:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317809809.2374.5.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 05, 2011 at 06:16:49PM +0800, Axel Lin wrote:
> Current code has off-by-one bug of checking WM8990_RESET.
> Besides, according to wm8990 datasheet (2-wire serial control mode):
> A control word consists of 24 bits. The first 8 bits are address bits,
> the remaining 16 bits are data bits.
> Current code uses 7 bits address bits and 9 bits data bits which is incorrect.

We should just convert drivers like this to snd_soc_cache_sync().
