From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm8731: initialize the hardware
	when loading	the codec driver
Date: Mon, 8 Jun 2015 10:23:06 +0100
Message-ID: <20150608092306.GD32730@opensource.wolfsonmicro.com>
References: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51A7D2605B7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 11:23:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2015 at 11:55:27AM -0700, Sergey Kiselev wrote:
> From: Sergey Kiselev <sergey.kiselev@intel.com>
> 
> This patch moves the requesting supplies, hardware reset and
> initialization from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe.
> So that the codec hardware is initialized when loading the codec driver,
> and not when loading the machine driver. This avoids unnecesary hardware
> resets and re-initializations when re-loading the machine driver.
> 
> Signed-off-by: Sergey Kiselev <sergey.kiselev@intel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
