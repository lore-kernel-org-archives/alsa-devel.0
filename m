From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] cs4270: add support for slave
	mode	configurations
Date: Wed, 25 Feb 2009 15:34:45 +0000
Message-ID: <20090225153444.GC31637@sirena.org.uk>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A95A7103823
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 16:34:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1235569041-856-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2009 at 02:37:21PM +0100, Daniel Mack wrote:

>  	reg = snd_soc_read(codec, CS4270_MODE);
>  	reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
> -	reg |= cs4270_mode_ratios[i].speed_mode | cs4270_mode_ratios[i].mclk;
> +	reg |= cs4270_mode_ratios[i].mclk;
> +
> +	if (cs4270->slave_mode)
> +		reg |= CS4270_MODE_SLAVE;
> +	else
> +		reg |= cs4270_mode_ratios[i].speed_mode;

Shouldn't this be clearing MODE_SLAVE if it's in master mode?  Since
we're doing a read/modify/write here it'd probably just be as easy to
set or clear the bit when setting the DAI format rather than storing the
data and setting it here.
