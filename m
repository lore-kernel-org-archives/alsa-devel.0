From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Date: Wed, 1 May 2019 18:05:03 +0200
Message-ID: <20190501160503.GB19281@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 01, 2019 at 10:57:25AM -0500, Pierre-Louis Bossart wrote:
> No C++ comments in .h files

That's not really the issue here.

> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h            | 4 ++--
>  drivers/soundwire/cadence_master.h | 4 ++--
>  drivers/soundwire/intel.h          | 4 ++--
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

The first line is fine to change, as that was the requirement (although
I think it has now been fixed), the second line is just taste, whatever
you want, it's not a requirement.

But I really don't care, it's not my code :)

thanks,

greg k-h
