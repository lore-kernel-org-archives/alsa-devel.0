From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v3 02/15] soundwire: Add SoundWire bus type
Date: Thu, 30 Nov 2017 12:42:30 +0100
Message-ID: <CAOFm3uGxCQQvtts47_ZdjQryokujmunOpf4ZNcG94WpkcQ7A7g@mail.gmail.com>
References: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
 <1512035830-29161-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id A5C7026698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 12:43:11 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id g130so1256891wme.0
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 03:43:11 -0800 (PST)
In-Reply-To: <1512035830-29161-3-git-send-email-vinod.koul@intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 30, 2017 at 10:56 AM, Vinod Koul <vinod.koul@intel.com> wrote:
[]
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> new file mode 100644
> index 000000000000..2af05b21961e
> --- /dev/null
> +++ b/drivers/soundwire/bus.h
> @@ -0,0 +1,57 @@
> +/*
> + *  This file is provided under a dual BSD/GPLv2 license.  When using or
> + *  redistributing this file, you may do so under either license.
> + *
> + *  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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

Hi Vinod,

You may want to use the proper SPDX ids convention here instead? e.g.
below is all you need IMHO: not 50 lines of boilerplate but only two.

You will make everyone happier with a sigh of relief when you remove
this boilerplate, and you will also have saved a few trees if this
ever printed on paper, making earth a better planet as a bonus ;)

> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright (c) 2015-17 Intel Corporation.

Neater and simpler, is it not? In any case the SPDX line should go at the top.
See Linus and tglx doc posts for comment and doc styles for this.
NB: some includes used in assembly sometimes require to use /**/
comments instead.

-- 
Cordially
Philippe Ombredanne
