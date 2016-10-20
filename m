From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoc: wm8580: Add the wm8581 codec to
	the driver
Date: Thu, 20 Oct 2016 10:45:19 +0100
Message-ID: <20161020094519.GM3207@localhost.localdomain>
References: <1476815075-12976-1-git-send-email-flatmax@flatmax.org>
 <1476919754-9636-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A9DB52657DF
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 11:45:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1476919754-9636-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2016 at 10:29:14AM +1100, Matt Flax wrote:
> This patch adds support for the wm8581 codec to the wm8580 driver.
> The wm8581 codec hardware adds a fourth DAC and otherwise is
> compatible with the wm8580 codec.
> 
> of_device_id data is used to allow the driver to select the
> suitable DAC count specified in the device tree codec selection.
> The wm8580_driver_data struct is used to store the number of DACs.
> 
> The snd_soc_dai_driver no longer lists the channels_max for the
> playback substream. This variable is set during the i2c probe
> from the of_device_id supplied wm8580_driver_data struct.
> 
> With knowledge of the number of DACs in use, the DAC4 controls,
> widgets and routes are added as required for DAC4.
> 
> The device tree documentation for the wm8580 is altered to list
> the wm8581 codec support, as is the Kconfig file.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---

Looks good to me.

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
