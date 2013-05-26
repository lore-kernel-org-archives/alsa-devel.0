From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH: TinyCompress 1/2] add utils file with rate
 conversion helper
Date: Sun, 26 May 2013 19:43:47 +0530
Message-ID: <20130526141347.GY30200@intel.com>
References: <1369296767-30136-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 55DD3261785
 for <alsa-devel@alsa-project.org>; Sun, 26 May 2013 16:50:40 +0200 (CEST)
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
 r4QEDmYV004884
 for <alsa-devel@alsa-project.org>; Sun, 26 May 2013 19:43:48 +0530
Received: (from vkoul@localhost)
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r4QEDl12004883
 for alsa-devel@alsa-project.org; Sun, 26 May 2013 19:43:47 +0530
Content-Disposition: inline
In-Reply-To: <1369296767-30136-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 23, 2013 at 01:42:46PM +0530, Vinod Koul wrote:
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Applied both

--
~Vinod
> ---
>  Android.mk                          |    2 +-
>  include/tinycompress/tinycompress.h |    2 +
>  makefile.linux                      |    2 +-
>  utils.c                             |   96 +++++++++++++++++++++++++++++++++++
>  4 files changed, 100 insertions(+), 2 deletions(-)
>  create mode 100644 utils.c
> 
> diff --git a/Android.mk b/Android.mk
> index b9c52e2..104dfef 100644
> --- a/Android.mk
> +++ b/Android.mk
> @@ -2,7 +2,7 @@ LOCAL_PATH:= $(call my-dir)
>  
>  include $(CLEAR_VARS)
>  LOCAL_C_INCLUDES:= $(LOCAL_PATH)/include
> -LOCAL_SRC_FILES:= compress.c
> +LOCAL_SRC_FILES:= compress.c utils.c
>  LOCAL_MODULE := libtinycompress
>  LOCAL_SHARED_LIBRARIES:= libcutils libutils
>  LOCAL_MODULE_TAGS := optional
> diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
> index 9867afc..e947322 100644
> --- a/include/tinycompress/tinycompress.h
> +++ b/include/tinycompress/tinycompress.h
> @@ -267,4 +267,6 @@ const char *compress_get_error(struct compress *compress);
>  #define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
>  #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
>  
> +/* utility functions */
> +unsigned int compress_get_alsa_rate(unsigned int rate);
>  #endif
> diff --git a/makefile.linux b/makefile.linux
> index 60d6c04..677878d 100644
> --- a/makefile.linux
> +++ b/makefile.linux
> @@ -2,7 +2,7 @@ LIB = libtinycompress
>  BIN = cplay
>  VER = 0.1
>  LIBSRC = compress.c
> -SRC = cplay.c
> +SRC = cplay.c utils.c
>  LIBOBJ = ${LIBSRC:.c=.o}
>  OBJ = ${SRC:.c=.o}
>  
> diff --git a/utils.c b/utils.c
> new file mode 100644
> index 0000000..fa37f23
> --- /dev/null
> +++ b/utils.c
> @@ -0,0 +1,96 @@
> +/*
> + * BSD LICENSE
> + *
> + * tinycompress utility functions
> + * Copyright (c) 2011-2013, Intel Corporation
> + * All rights reserved.
> + *
> + * Author: Vinod Koul <vinod.koul@intel.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * Redistributions of source code must retain the above copyright notice,
> + * this list of conditions and the following disclaimer.
> + * Redistributions in binary form must reproduce the above copyright notice,
> + * this list of conditions and the following disclaimer in the documentation
> + * and/or other materials provided with the distribution.
> + * Neither the name of Intel Corporation nor the names of its contributors
> + * may be used to endorse or promote products derived from this software
> + * without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
> + * THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * LGPL LICENSE
> + *
> + * tinycompress utility functions
> + * Copyright (c) 2011-2013, Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU Lesser General Public License,
> + * version 2.1, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
> + * License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public License
> + * along with this program; if not, write to
> + * the Free Software Foundation, Inc.,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <linux/types.h>
> +#include <sys/time.h>
> +#define __force
> +#define __bitwise
> +#define __user
> +#include "tinycompress/tinycompress.h"
> +
> +
> +unsigned int compress_get_alsa_rate(unsigned int rate)
> +{
> +	switch (rate) {
> +	case 5512:
> +		return SNDRV_PCM_RATE_5512;
> +	case 8000:
> +		return SNDRV_PCM_RATE_8000;
> +	case 11025:
> +		return SNDRV_PCM_RATE_11025;
> +	case 16000:
> +		return SNDRV_PCM_RATE_16000;
> +	case 220500:
> +		return SNDRV_PCM_RATE_22050;
> +	case 32000:
> +		return SNDRV_PCM_RATE_32000;
> +	case 44100:
> +		return SNDRV_PCM_RATE_44100;
> +	case 48000:
> +		return SNDRV_PCM_RATE_48000;
> +	case 64000:
> +		return SNDRV_PCM_RATE_64000;
> +	case 88200:
> +		return SNDRV_PCM_RATE_88200;
> +	case 96000:
> +		return SNDRV_PCM_RATE_96000;
> +	case 176400:
> +		return SNDRV_PCM_RATE_176400;
> +	case 192000:
> +		return SNDRV_PCM_RATE_192000;
> +	default:
> +		return 0;
> +	}
> +}
> -- 
> 1.7.0.4
> 
