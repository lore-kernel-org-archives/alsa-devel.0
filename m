From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v5 3/6] media: dt-bindings: Add bindings
	for TDA1997X
Date: Sat, 16 Dec 2017 19:32:34 +0100
Message-ID: <CAOFm3uEmV+oeQhh48X7+bpn8HPP85ho5=sN2oVVKAOdnftskng@mail.gmail.com>
References: <1513447230-30948-1-git-send-email-tharvey@gateworks.com>
 <1513447230-30948-4-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E3FBB266BEF
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 19:33:15 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id y82so2232988wmg.1
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 10:33:15 -0800 (PST)
In-Reply-To: <1513447230-30948-4-git-send-email-tharvey@gateworks.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Tim,

On Sat, Dec 16, 2017 at 7:00 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> Cc: Rob Herring <robh@kernel.org>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

<snip>

> --- /dev/null
> +++ b/include/dt-bindings/media/tda1997x.h
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (C) 2017 Gateworks Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

Please consider using the new SPDX tags per Thomas doc patches [1]
Thanks!
[1] https://lkml.org/lkml/2017/12/4/934
-- 
Cordially
Philippe Ombredanne, your friendly kernel licensing scruffy
