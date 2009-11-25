From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 16/17] ALSA: ARM: add Raumfeld audio support
Date: Wed, 25 Nov 2009 11:02:18 +0000
Message-ID: <20091125110218.GD17420@opensource.wolfsonmicro.com>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-17-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 344A024367
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 12:02:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259145751-3331-17-git-send-email-daniel@caiaq.de>
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
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 11:42:30AM +0100, Daniel Mack wrote:

> +static struct i2c_board_info max9486_hwmon_info = {
> +	I2C_BOARD_INFO("max9485", 0x63),
> +};

This should be in the board file under arch/arm.

> +extern void raumfeld_enable_audio(bool en);

This should be in a proper header file somewhere.

> +static void raumfeld_cs4270_shutdown(struct snd_pcm_substream *substream)
> +{
> +}
> +

Remove this and the other empty functions.

> +	case 96000:
> +		set_max9485_clk(1);

It might be a bit more legible to have some constants for the arguments
for this function - it's not entirely clear what's going on, the 1 and 0
look like a boolean but that's not what's really going on here.  It may
be better to do this as a proper driver, there was at least one driver I
remember being posted for a TDM clock generator which I think got
merged.
