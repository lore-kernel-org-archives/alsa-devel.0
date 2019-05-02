From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Date: Thu, 2 May 2019 10:46:49 +0530
Message-ID: <20190502051440.GA3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> No C++ comments in .h files
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h            | 4 ++--
>  drivers/soundwire/cadence_master.h | 4 ++--
>  drivers/soundwire/intel.h          | 4 ++--

As I said previously this touches subsystem header as well as driver
headers which is not ideal. Also I agree with Greg, SPDX line format is
a requirement but not the copyright one but that is not a deal breaker
here.

>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index c77de05b8100..2f8436584e7f 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */
>  
>  #ifndef __SDW_BUS_H
>  #define __SDW_BUS_H
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index eb902b19c5a4..75f7412cfbbd 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */
>  #include <sound/soc.h>
>  
>  #ifndef __SDW_CADENCE_H
> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> index c1a5bac6212e..71050e5f643d 100644
> --- a/drivers/soundwire/intel.h
> +++ b/drivers/soundwire/intel.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */
>  
>  #ifndef __SDW_INTEL_LOCAL_H
>  #define __SDW_INTEL_LOCAL_H
> -- 
> 2.17.1

-- 
~Vinod
