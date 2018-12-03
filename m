From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH linux-next v2 5/6] dt-bindings: clock: add clock id for
 renesas adg clocks
Date: Mon, 3 Dec 2018 14:16:00 +0200
Message-ID: <25148671-24cd-980b-ce6d-adabb3cfd09e@mentor.com>
References: <20181203112409.18276-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203112409.18276-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiada_wang@mentor.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Jiada,

On 12/03/2018 01:24 PM, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> This patch adds clock ID for renesas adg clocks
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  include/dt-bindings/clock/renesas-adg.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/clock/renesas-adg.h
> 
> diff --git a/include/dt-bindings/clock/renesas-adg.h b/include/dt-bindings/clock/renesas-adg.h
> new file mode 100644
> index 000000000000..fe30c186cef7
> --- /dev/null
> +++ b/include/dt-bindings/clock/renesas-adg.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Mentor Graphics inc.
> + */
> +#ifndef __DT_BINDINGS_RENESAS_ADG_H__
> +#define __DT_BINDINGS_RENESAS_ADG_H__
> +
> +#define ADG_FIX				0
> +#define ADG_AVB				1
> +
> +#endif /* __DT_BINDINGS_RENESAS_ADG_H__ */
> 

instead of adding these trivial definitions in a new header file with no
potential for further extension, I would like to ask you to write a proper
device tree bindings documentation section and describe the clock ids as
a list of acceptable values for a cell.

--
Best wishes,
Vladimir
