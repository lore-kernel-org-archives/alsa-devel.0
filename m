From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: snd_soc_hw_bulk_write_raw: Use the
 codec's hw_write callback
Date: Wed, 11 May 2011 22:00:45 +0200
Message-ID: <20110511200045.GD21150@opensource.wolfsonmicro.com>
References: <1305134752-20571-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1305140714-10953-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84A53103932
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 22:00:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305140714-10953-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2011 at 12:05:14PM -0700, Lars-Peter Clausen wrote:

> Currently there are two places in the snd_soc_cache code where the function to
> write to the hardware is determined by looking at the control_type.
> One lookup is done when the cache is initialized the other is done in
> snd_soc_hw_bulk_write_raw. This requires, that when the spi or i2c write function
> is changed, that both places are updated.
> To avoid missing one of them use the codec's hw_write callback in
> snd_soc_hw_bulk_write_raw instead of looking at the control_type.
> 
> Also this allows to use other bus types to do raw writes instead of limiting it
> to spi and i2c.

You're missing the bigger picture here where the raw bulk write doesn't
work at all at the minute as it doesn't include the register.  Dimitris
said he was going to fix this, I suspect this will collide with that
more important fix.

Please do also bear in mind my previous feedback about fixing the line
lengths and general formatting in your commit logs.  It's rather hard to
read the above.
