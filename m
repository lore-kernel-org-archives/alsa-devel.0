From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 12:41:20 +0200
Message-ID: <20171020104120.GB3210@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D164266A51
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 12:41:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> new file mode 100644
> index 000000000000..2683c6798b95
> --- /dev/null
> +++ b/drivers/soundwire/bus.h
> @@ -0,0 +1,62 @@
> +/*
> + *  This file is provided under a dual BSD/GPLv2 license.  When using or
> + *  redistributing this file, you may do so under either license.
> + *
> + *  GPL LICENSE SUMMARY
> + *
> + *  Copyright(c) 2015-17 Intel Corporation.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of version 2 of the GNU General Public License as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  BSD LICENSE
> + *
> + *  Copyright(c) 2015-17 Intel Corporation.
> + *
> + *  Redistribution and use in source and binary forms, with or without
> + *  modification, are permitted provided that the following conditions
> + *  are met:
> + *
> + *    * Redistributions of source code must retain the above copyright
> + *      notice, this list of conditions and the following disclaimer.
> + *    * Redistributions in binary form must reproduce the above copyright
> + *      notice, this list of conditions and the following disclaimer in
> + *      the documentation and/or other materials provided with the
> + *      distribution.
> + *    * Neither the name of Intel Corporation nor the names of its
> + *      contributors may be used to endorse or promote products derived
> + *      from this software without specific prior written permission.
> + *
> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +#ifndef __SDW_BUS_H
> +#define __SDW_BUS_H
> +
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/acpi.h>
> +#include <linux/soundwire/sdw.h>
> +
> +int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size);
> +
> +#endif /* __SDW_BUS_H */

When your header boiler-plate text is bigger than the content, please
reconsider it.  Are you sure you need this .h file?  Why?
