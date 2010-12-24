From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/9] ASoC: codecs: wm8523: Fix register
 cache incoherency
Date: Fri, 24 Dec 2010 15:59:30 +0000
Message-ID: <20101224155929.GC16614@opensource.wolfsonmicro.com>
References: <1293198484-1902-1-git-send-email-lars@metafoo.de>
	<1293198484-1902-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 710EF1039EA
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 16:59:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293198484-1902-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 24, 2010 at 02:47:58PM +0100, Lars-Peter Clausen wrote:

>  	/* Change some default settings - latch VU and enable ZC */
> -	wm8523->reg_cache[WM8523_DAC_GAINR] |= WM8523_DACR_VU;
> -	wm8523->reg_cache[WM8523_DAC_CTRL3] |= WM8523_ZC;
> +	reg_cache[WM8523_DAC_GAINR] |= WM8523_DACR_VU;
> +	reg_cache[WM8523_DAC_CTRL3] |= WM8523_ZC;

All the drivers where you're making this substitution should in
principle be changed to use snd_soc_update_bits() since we now have
support for multiple cache memory formats so may not have this flat in
memory structure, though for the sake of getting the fixes in it's
probably best to ignore that and fix it up later.
