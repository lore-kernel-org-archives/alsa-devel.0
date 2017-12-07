From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v2 02/15] soc: qcom: add support to APR bus
	driver
Date: Thu, 7 Dec 2017 10:53:19 +0100
Message-ID: <CAOFm3uE=xoiyWE7d6bw=CeGzxcT1NMxnZ0zX_z-wPOVPTGL7zw@mail.gmail.com>
References: <20171205221812.25641-1-srinivas.kandagatla@linaro.org>
 <20171205221812.25641-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BA0AA266E6C
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 10:54:00 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id f140so11723248wmd.2
 for <alsa-devel@alsa-project.org>; Thu, 07 Dec 2017 01:53:59 -0800 (PST)
In-Reply-To: <20171205221812.25641-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: ALSA <alsa-devel@alsa-project.org>, bgoswami@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, plai@codeaurora.org, kwestfie@codeaurora.org, tiwai@suse.com, Mark <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

Srinivas,

On Tue, Dec 5, 2017 at 11:17 PM,  <srinivas.kandagatla@linaro.org> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[]
> --- /dev/null
> +++ b/drivers/soc/qcom/apr.c
> @@ -0,0 +1,395 @@
> +/* SPDX-License-Identifier: GPL-2.0
> +* Copyright (c) 2011-2016, The Linux Foundation
> +* Copyright (c) 2017, Linaro Limited
> +*/

Accept my apologies as I am nitpicking there, but I think that Linus's
preferred style for the SPDX id line is the C++  style //.

And while you are at it since these is only license and copyrights you
could go with this all the way, as in this:

> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2011-2016, The Linux Foundation
> +// Copyright (c) 2017, Linaro Limited

You can check the doc patches posted by Thomas (tglx) and earlier
comments from Linus wrt comment style and his good rationale for
these.
-- 
Cordially
Philippe Ombredanne
