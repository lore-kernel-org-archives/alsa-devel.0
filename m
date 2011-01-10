From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v3] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 22:34:00 +0000
Message-ID: <20110110223400.GE5886@opensource.wolfsonmicro.com>
References: <1294687713-16433-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 060F424647
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 23:33:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294687713-16433-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 01:28:32PM -0600, Timur Tabi wrote:
> Update the CS4270 driver to use ASoC's internal codec register cache feature.
> This change allows ASoC to perform the low-level I2C operations necessary to
> read the register cache.  Support is also added for initializing the register
> cache with an array of known power-on default values.
> 
> The CS4270 driver was handling the register cache itself, but somwhere along
> the conversion to multi-compaonent, this feature broke.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.

> Mark, I don't have power-management support working on my hardware, so I can't
> test cs4270_soc_resume(), but I have a suspicion that the call to
> i2c_smbus_write_byte_data() should be replaced with codec->hw_write().

Like Liam said snd_soc_cache_sync() is probably what you're looking for
here.
