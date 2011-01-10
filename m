From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] [v3] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 21:59:25 +0000
Message-ID: <1294696765.3416.243.camel@odin>
References: <1294687713-16433-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 60A4610391E
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 23:05:17 +0100 (CET)
Received: by wwe15 with SMTP id 15so19799846wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 14:05:17 -0800 (PST)
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 13:28 -0600, Timur Tabi wrote:
> Update the CS4270 driver to use ASoC's internal codec register cache feature.
> This change allows ASoC to perform the low-level I2C operations necessary to
> read the register cache.  Support is also added for initializing the register
> cache with an array of known power-on default values.
> 
> The CS4270 driver was handling the register cache itself, but somwhere along
> the conversion to multi-compaonent, this feature broke.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> ---
> 
> Mark, I don't have power-management support working on my hardware, so I can't
> test cs4270_soc_resume(), but I have a suspicion that the call to
> i2c_smbus_write_byte_data() should be replaced with codec->hw_write().
> 

You may want to look at using snd_soc_cache_sync() to flush your cache
at resume().

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
