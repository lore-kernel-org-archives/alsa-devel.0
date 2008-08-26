From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert wm8750 to a new-style
	i2c	driver (testers wanted)
Date: Tue, 26 Aug 2008 20:05:03 +0100
Message-ID: <20080826190501.GB3461@sirena.org.uk>
References: <20080826180656.44f43073@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EBF9D2448F
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 21:05:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826180656.44f43073@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 26, 2008 at 06:06:56PM +0200, Jean Delvare wrote:
> Convert the wm8750 codec driver to the new (standard) device driver
> binding model.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

for the wm8750 driver.  I'm pretty confident the spitz change is correct
too but don't have hardware to actually test.

>  /* spitz audio private data */
>  static struct wm8750_setup_data spitz_wm8750_setup = {
> +	.i2c_bus = 0,
>  	.i2c_address = 0x1b,
>  };

The assignment to 0 is redundant but it's useful for documentation.
